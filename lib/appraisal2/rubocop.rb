# frozen_string_literal: true

require "appraisal/hooks"
require "appraisal2/rubocop/runner"
require "appraisal2/rubocop/version"

module Appraisal2
  module Rubocop
    class << self
      def install!
        return if @installed

        ::Appraisal.after_write_gemfile do |_appraisal, path|
          Runner.new(path).run
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
