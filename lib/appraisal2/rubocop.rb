# frozen_string_literal: true

require "version_gem"

require "appraisal/hooks"
require "appraisal2/rubocop/runner"
require_relative "rubocop/version"

module Appraisal2
  module Rubocop
    INSTALL_MUTEX = Mutex.new

    class << self
      def install!
        INSTALL_MUTEX.synchronize do
          return if installed?

          ::Appraisal.transform_gemfile do |content, context|
            Runner.new(context.path).correct(content)
          end
          const_set(:INSTALLED, true)
        end
      end

      def installed?
        const_defined?(:INSTALLED, false)
      end

      def reset!
        remove_const(:INSTALLED) if installed?
      end
    end
  end
end

Appraisal2::Rubocop.install!

Appraisal2::Rubocop::Version.class_eval do
  extend VersionGem::Basic
end
