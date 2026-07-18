# frozen_string_literal: true

require "spec_helper"
require "appraisal2/rubocop/runner"
require "open3"

RSpec.describe Appraisal2::Rubocop::Runner do
  describe "#command_args" do
    it "loads the RuboCop executable through RubyGems by default" do
      runner = described_class.new("gemfiles/style.gemfile")

      expect(runner.command_args).to eq([
        Gem.ruby,
        "-rbundler/setup",
        "-rrubygems",
        "-e",
        described_class::RUBOCOP_BIN_PATH_LOADER,
        "--",
        "--stdin",
        "gemfiles/style.gemfile",
        "--autocorrect",
        "--stderr",
        "--format",
        "quiet"
      ])
    end

    it "preserves explicit custom command execution" do
      runner = described_class.new("gemfiles/style.gemfile", command: "bin/rubocop")
      allow(runner).to receive(:command_env)

      expect(runner.command_args).to eq([
        "bin/rubocop",
        "--stdin",
        "gemfiles/style.gemfile",
        "--autocorrect",
        "--stderr",
        "--format",
        "quiet"
      ])
      expect(runner).not_to have_received(:command_env)
    end

    it "does not require bundler/setup when no bundle is selected" do
      runner = described_class.new("gemfiles/style.gemfile")

      expect(runner.command_args({})).to eq([
        Gem.ruby,
        "-rrubygems",
        "-e",
        described_class::RUBOCOP_BIN_PATH_LOADER,
        "--",
        "--stdin",
        "gemfiles/style.gemfile",
        "--autocorrect",
        "--stderr",
        "--format",
        "quiet"
      ])
    end
  end

  describe "#command_env" do
    it "starts from Bundler's unbundled environment and preserves selected bundle variables" do
      allow(ENV).to receive(:to_h).and_return(
        "BUNDLE_GEMFILE" => "/repo/Appraisal.root.gemfile",
        "BUNDLE_LOCKFILE" => "/repo/Gemfile.lock",
        "BUNDLE_BIN_PATH" => "/bundle/bin",
        "BUNDLER_SETUP" => "1",
        "PATH" => "/ruby/bin",
        "RUBYOPT" => "-rbundler/setup -W0"
      )
      allow(Bundler).to receive(:unbundled_env).and_return({
        "BUNDLE_GEMFILE" => "/old/Gemfile",
        "BUNDLE_LOCKFILE" => "/old/Gemfile.lock",
        "BUNDLE_BIN_PATH" => "/old/bundle",
        "BUNDLER_SETUP" => "/old/setup",
        "PATH" => "/system/bin"
      })

      env = described_class.new("gemfiles/style.gemfile").command_env

      expect(Bundler).to have_received(:unbundled_env)
      expect(env["BUNDLE_GEMFILE"]).to eq("/repo/Appraisal.root.gemfile")
      expect(env["PATH"]).to eq("/ruby/bin")
      expect(env["BUNDLE_LOCKFILE"]).to be_nil
      expect(env["BUNDLE_BIN_PATH"]).to be_nil
      expect(env["BUNDLER_SETUP"]).to be_nil
      expect(env["RUBYOPT"]).to eq("-W0")
    end

    it "uses Bundler's original environment when unbundled_env is unavailable" do
      allow(ENV).to receive(:to_h).and_return("PATH" => "/ruby/bin")
      allow(Bundler).to receive(:respond_to?).and_call_original
      allow(Bundler).to receive(:respond_to?).with(:unbundled_env).and_return(false)
      allow(Bundler).to receive(:respond_to?).with(:original_env).and_return(true)
      allow(Bundler).to receive(:original_env).and_return({"PATH" => "/original/bin"})

      env = described_class.new("gemfiles/style.gemfile").command_env

      expect(Bundler).to have_received(:original_env)
      expect(env["PATH"]).to eq("/ruby/bin")
    end

    it "uses the current environment when Bundler is unavailable" do
      hide_const("Bundler")
      allow(ENV).to receive(:to_h).and_return("PATH" => "/ruby/bin")

      env = described_class.new("gemfiles/style.gemfile").command_env

      expect(env["PATH"]).to eq("/ruby/bin")
    end
  end

  describe "#correct" do
    it "returns corrected stdout from RuboCop" do
      status = instance_double(Process::Status, success?: true)
      allow(Open3).to receive(:capture3).and_return(["corrected\n", "", status])
      runner = described_class.new("gemfiles/style.gemfile")

      expect(runner.correct("source\n")).to eq("corrected\n")
      expect(Open3).to have_received(:capture3).with(runner.command_env, *runner.command_args, stdin_data: "source\n")
    end

    it "raises when RuboCop fails" do
      status = instance_double(Process::Status, success?: false)
      allow(Open3).to receive(:capture3).and_return(["", "failure", status])
      runner = described_class.new("gemfiles/style.gemfile")

      expect { runner.correct("source\n") }.to raise_error(/appraisal2-rubocop failed/)
    end

    it "returns original content when disabled" do
      runner = described_class.new("gemfiles/style.gemfile")
      allow(ENV).to receive(:fetch).with("APPRAISAL2_RUBOCOP", "true").and_return("false")
      allow(Open3).to receive(:capture3)

      expect(runner.correct("source\n")).to eq("source\n")
      expect(Open3).not_to have_received(:capture3)
    end
  end

  describe "configured flags" do
    it "uses APPRAISAL2_RUBOCOP_FLAGS when present" do
      allow(ENV).to receive(:[]).with("APPRAISAL2_RUBOCOP_FLAGS").and_return("--safe --only Gemspec")

      expect(described_class.new("gemfiles/style.gemfile").command_args).to include("--safe", "--only", "Gemspec")
    end
  end
end
