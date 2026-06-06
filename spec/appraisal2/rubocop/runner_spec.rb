# frozen_string_literal: true

require "spec_helper"
require "appraisal2/rubocop/runner"
require "open3"

RSpec.describe Appraisal2::Rubocop::Runner do
  describe "#command_args" do
    it "uses RuboCop stdin autocorrect for the generated path by default" do
      runner = described_class.new("gemfiles/style.gemfile")

      expect(runner.command_args).to eq([
        "rubocop",
        "--stdin",
        "gemfiles/style.gemfile",
        "--autocorrect",
        "--stderr",
        "--format",
        "quiet"
      ])
    end
  end

  describe "#correct" do
    it "returns corrected stdout from RuboCop" do
      status = instance_double(Process::Status, :success? => true)
      allow(Open3).to receive(:capture3).and_return(["corrected\n", "", status])
      runner = described_class.new("gemfiles/style.gemfile")

      expect(runner.correct("source\n")).to eq("corrected\n")
      expect(Open3).to have_received(:capture3).with(*runner.command_args, :stdin_data => "source\n")
    end

    it "raises when RuboCop fails" do
      status = instance_double(Process::Status, :success? => false)
      allow(Open3).to receive(:capture3).and_return(["", "failure", status])
      runner = described_class.new("gemfiles/style.gemfile")

      expect { runner.correct("source\n") }.to raise_error(/appraisal2-rubocop failed/)
    end
  end
end
