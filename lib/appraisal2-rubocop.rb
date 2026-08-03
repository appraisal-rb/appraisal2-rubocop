# frozen_string_literal: true

require "appraisal2/rubocop"
require "version_gem"
require_relative "appraisal2/rubocop/version"

Appraisal2::Rubocop::Version.class_eval do
  extend VersionGem::Basic
end
