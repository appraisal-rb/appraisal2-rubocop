# frozen_string_literal: true

require "open3"

module Appraisal2
  module Rubocop
    class Runner
      DEFAULT_COMMAND = "rubocop"
      DEFAULT_FLAGS = ["--autocorrect"].freeze

      def initialize(path, command: ENV.fetch("APPRAISAL2_RUBOCOP_COMMAND", DEFAULT_COMMAND), flags: nil)
        @path = path.to_s
        @command = command.to_s
        @flags = flags || configured_flags
      end

      def correct(content)
        return content if disabled?

        stdout, stderr, status = Open3.capture3(*command_args, :stdin_data => content)
        raise "appraisal2-rubocop failed: #{command_args.join(" ")}\n#{stderr}" unless status.success?

        stdout
      end

      def command_args
        [@command, "--stdin", @path, *@flags, "--stderr", "--format", "quiet"]
      end

      private

      def configured_flags
        raw = ENV["APPRAISAL2_RUBOCOP_FLAGS"]
        return DEFAULT_FLAGS if raw.nil? || raw.empty?

        raw.split
      end

      def disabled?
        ENV.fetch("APPRAISAL2_RUBOCOP", "true").casecmp("false").zero?
      end
    end
  end
end
