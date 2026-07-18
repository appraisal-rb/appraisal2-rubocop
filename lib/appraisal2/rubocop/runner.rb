# frozen_string_literal: true

require "open3"

module Appraisal2
  module Rubocop
    class Runner
      DEFAULT_COMMAND = "rubocop"
      DEFAULT_FLAGS = ["--autocorrect"].freeze
      RUBOCOP_BIN_PATH_LOADER = "load Gem.activate_bin_path(\"rubocop\", \"rubocop\")"

      PRESERVED_BUNDLE_VARS = [
        "BUNDLE_GEMFILE",
        "BUNDLE_APP_CONFIG",
        "BUNDLE_PATH",
        "BUNDLE_USER_CONFIG",
        "BUNDLE_USER_CACHE",
        "BUNDLE_USER_PLUGIN",
        "BUNDLE_IGNORE_FUNDING_REQUESTS",
        "BUNDLE_DISABLE_SHARED_GEMS",
        "BUNDLE_VERSION",
        "BUNDLER_VERSION"
      ].freeze

      PRESERVED_RUNTIME_VARS = [
        "PATH",
        "GEM_HOME",
        "GEM_PATH"
      ].freeze

      def initialize(path, command: ENV.fetch("APPRAISAL2_RUBOCOP_COMMAND", DEFAULT_COMMAND), flags: nil)
        @path = path.to_s
        @command = command.to_s
        @flags = flags || configured_flags
      end

      def correct(content)
        return content if disabled?

        env = command_env
        args = command_args(env)
        stdout, stderr, status = Open3.capture3(env, *args, stdin_data: content)
        raise "appraisal2-rubocop failed: #{args.join(" ")}\n#{stderr}" unless status.success?

        stdout
      end

      def command_args(env = nil)
        return [@command, *rubocop_args] unless default_command?

        env ||= command_env
        [
          Gem.ruby,
          *ruby_require_flags(env),
          "-e",
          RUBOCOP_BIN_PATH_LOADER,
          "--",
          *rubocop_args
        ]
      end

      def command_env
        current_env = ENV.to_h
        clean_env = bundler_base_env(current_env)

        # Avoid leaking parent Bundler activation into the RuboCop subprocess.
        # The selected BUNDLE_GEMFILE is preserved below, and the Ruby command
        # explicitly loads bundler/setup only when a bundle has been selected.
        clean_env["BUNDLE_LOCKFILE"] = nil
        clean_env["BUNDLE_BIN_PATH"] = nil
        clean_env["BUNDLER_SETUP"] = nil

        (PRESERVED_BUNDLE_VARS + PRESERVED_RUNTIME_VARS).each do |key|
          clean_env[key] = current_env[key] if current_env[key]
        end

        clean_env["RUBYOPT"] = sanitized_rubyopt(current_env["RUBYOPT"])
        clean_env
      end

      private

      def default_command?
        @command == DEFAULT_COMMAND
      end

      def rubocop_args
        ["--stdin", @path, *@flags, "--stderr", "--format", "quiet"]
      end

      def bundler_base_env(current_env)
        if defined?(Bundler) && Bundler.respond_to?(:unbundled_env)
          Bundler.unbundled_env.to_h.dup
        elsif defined?(Bundler) && Bundler.respond_to?(:original_env)
          Bundler.original_env.to_h.dup
        else
          current_env.to_h
        end
      end

      def ruby_require_flags(env)
        return ["-rbundler/setup", "-rrubygems"] if env["BUNDLE_GEMFILE"]

        ["-rrubygems"]
      end

      def sanitized_rubyopt(rubyopt)
        return unless rubyopt

        options = rubyopt.split(" ")
        options.reject! { |option| option == "-rbundler/setup" || option.include?("bundler/setup") }
        options.empty? ? nil : options.join(" ")
      end

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
