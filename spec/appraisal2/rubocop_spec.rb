# frozen_string_literal: true

require "spec_helper"
require "appraisal/hooks"
require "appraisal2/rubocop"

RSpec.describe Appraisal2::Rubocop do
  after do
    Appraisal::Hooks.reset!
    described_class.reset!
  end

  it "installs only once" do
    described_class.reset!

    expect { described_class.install! }.not_to raise_error
    expect { described_class.install! }.not_to raise_error
    expect(described_class.installed?).to be(true)

    described_class.reset!
    expect { described_class.reset! }.not_to raise_error
  end

  it "registers a gemfile transform" do
    described_class.install!
    status = instance_double(Process::Status, success?: true)
    allow(Open3).to receive(:capture3).and_return(["corrected\n", "", status])

    content = Appraisal::Hooks.run_transform_gemfile(nil, "gemfiles/style.gemfile", "source\n")

    expect(content).to eq("corrected\n")
  end
end
