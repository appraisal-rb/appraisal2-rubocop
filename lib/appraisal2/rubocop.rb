# frozen_string_literal: true

require "version_gem"
require_relative "rubocop/version"

require "appraisal/hooks"
require "appraisal2/rubocop/runner"
require "appraisal2/rubocop/version"

module Appraisal2
  module Rubocop
    class << self
      def install!
        return if @installed

        ::Appraisal.transform_gemfile do |content, context|
          Runner.new(context.path).correct(content)
        end
        @installed = true
      end

      def installed?
        !!@installed
      end

      def reset!
        @installed = false
      end
    end
  end
end

Appraisal2::Rubocop.install!

Appraisal2::Rubocop::Version.class_eval do
  extend VersionGem::Basic
end
