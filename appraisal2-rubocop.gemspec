# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "appraisal2-rubocop"
  spec.version = "0.1.0"
  spec.authors = ["Peter Boling"]
  spec.email = ["galtzo@floss.com"]

  spec.summary = "Run RuboCop cleanup after Appraisal2 gemfile generation"
  spec.description = "Appraisal2::Rubocop registers Appraisal2 generation hooks that run RuboCop against generated appraisal gemfiles."
  spec.homepage = "https://github.com/appraisal-rb/appraisal2-rubocop"
  spec.licenses = ["MIT"]
  spec.required_ruby_version = ">= 3.1.0"

  spec.files = Dir["lib/**/*.rb", "README.md", "CHANGELOG.md", "LICENSE.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency("appraisal2", ">= 3.1.0")
  spec.add_dependency("rubocop", ">= 1.0")

  spec.add_development_dependency("rake", ">= 13.0")
  spec.add_development_dependency("rspec", "~> 3.13")
end
