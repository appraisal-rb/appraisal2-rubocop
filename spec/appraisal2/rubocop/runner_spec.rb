# frozen_string_literal: true

require "spec_helper"
require "appraisal2/rubocop/runner"

RSpec.describe Appraisal2::Rubocop::Runner do
  describe "#command_args" do
    it "uses rubocop autocorrect for the generated path by default" do
      runner = described_class.new("gemfiles/style.gemfile")

      expect(runner.command_args).to eq(["rubocop", "--autocorrect", "gemfiles/style.gemfile"])
    end
  end

  describe "#run" do
    it "runs the configured command" do
      runner = described_class.new("gemfiles/style.gemfile", command: "true", flags: [])

      expect(runner.run).to eq(true)
    end
  end
end
