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
    expect(described_class.installed?).to eq(true)
  end
end
