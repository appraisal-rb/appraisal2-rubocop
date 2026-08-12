# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

### Added

### Changed

- Prepare project for kettle-jem templates: updated 11 project files across dependencies (11).

- Apply kettle-jem templates: updated 7 project files across code and tests (1), configuration (1), dependencies (1), documentation (1), other (3).

- Prepare project for kettle-jem templates: updated 6 project files across dependencies (5), other (1).

- Prepare project for kettle-jem templates: updated 4 project files across dependencies (4).

### Deprecated

### Removed

### Fixed

### Security

## [1.0.1] - 2026-08-06

- TAG: [v1.0.1][1.0.1t]
- COVERAGE: 100.00% -- 86/86 lines in 4 files
- BRANCH COVERAGE: 95.83% -- 23/24 branches in 4 files
- 26.32% documented

### Added

- kettle-jem-template-20260720-005 - README Support & Community links now
  include RubyForum.
- kettle-jem-template-20260726-001 - Projects now include YARD lint
  configuration and documentation dependencies so documentation issues fail
  before generated docs are refreshed.
- kettle-jem-template-20260727-001 - Spec harness documentation now lists the
  RSpec helpers provided by `kettle-test`.

### Changed

- Re-enabled the StructuredMerge `smorg-rb` semantic Git diff driver for Ruby
  files so this project dogfoods the internal tooling.

- kettle-jem-template-20260720-002 - Development Gemfiles now use the released
  `tree_sitter_language_pack` gem 1.13.3 or newer by default.
- kettle-jem-template-20260725-002 - Version specs now use `anonymous_loader` to
  cover `version.rb` without redefining constants, or are removed when version
  specs are not managed for the project.
- kettle-jem-template-20260728-001 - Generated Ruby workflows now use clearer
  setup-ruby-flash planning and can prepare appraisal-only jobs without
  installing the main Gemfile bundle.
- kettle-jem-template-20260801-001 - Generated README gem dashboard links now
  use ClickGems instead of BestGems.

### Fixed

- kettle-jem-template-20260720-003 - StructuredMerge Git diff driver config now
  uses the installed `smorg-rb` driver command.
- kettle-jem-template-20260725-001 - Release pull request branches beginning
  with `feature/release` now run JRuby and TruffleRuby workflows.
- kettle-jem-template-20260726-002 - Generated version files now document their
  version namespace and constants, reducing warning-only YARD lint output.
- kettle-jem-template-20260726-003 - Coverage upload steps now treat Coveralls,
  QLTY, and Codecov as optional, so provider outages do not fail CI when local
  coverage thresholds still pass.
- kettle-jem-template-20260728-002 - Generated RuboCop configs now ignore the
  same `gemfiles/vendor/bundle` tree as `.gitignore`, so vendored dependency
  installs are not reported as project lint debt.
- kettle-jem-template-20260728-003 - Generated dep-heads workflows now run
  TruffleRuby jobs with current RubyGems and Bundler, avoiding setup failures
  before the test suite starts.
- kettle-jem-template-20260728-004 - Generated dep-heads workflows now use the
  setup-ruby Bundler install path for direct appraisal Gemfiles, avoiding rv
  lockfile parser failures on Git and path dependencies.
- kettle-jem-template-20260728-005 - VersionGem bootstrap now creates the
  missing canonical version spec when a project only has shim namespace version
  specs.
- kettle-jem-template-20260729-001 - Generated JRuby 9.4 workflows now use the
  legacy manual bundle install path, avoiding setup-time Bundler full-index
  failures against `gem.coop`.
- kettle-jem-template-20260730-001 - Gemspec package file enumeration now runs
  relative to the gemspec directory, so release package contents stay correct
  even when the gemspec is loaded from another working directory.

- kettle-jem-template-20260801-002 - Generated RSpec helpers now normalize
  managed configuration block bindings structurally, preventing mixed block
  parameter names from producing invalid configuration after a merge.
- kettle-jem-template-20260801-003 - Generated project metadata and
  documentation now normalize configured underscore hostnames to valid
  hyphenated hostnames.
- kettle-jem-template-20260801-004 - Generated organization README logos now
  use GitHub's stable organization avatar endpoint instead of assuming a
  matching Galtzo-hosted asset exists.

- kettle-jem-template-20260802-001 - Devcontainer JSON files now merge as JSONC,
  preserving comments and trailing commas during template updates.

## [1.0.0] - 2026-07-18

- TAG: [v1.0.0][1.0.0t]
- COVERAGE: 98.85% -- 86/87 lines in 4 files
- BRANCH COVERAGE: 95.83% -- 23/24 branches in 4 files
- 15.79% documented

### Changed

- kettle-jem-template-20260716-002 - Generated gemspec manifests now ship fewer
  repository-only files by default to reduce downstream distro packaging churn.

### Fixed

- Run RuboCop through an explicit Bundler/RubyGems subprocess environment so
  generated gemfile cleanup does not depend on a bare `rubocop` executable
  being present on `PATH`.

## [0.2.3] - 2026-07-01

- TAG: [v0.2.3][0.2.3t]
- COVERAGE: 96.15% -- 50/52 lines in 4 files
- BRANCH COVERAGE: 80.00% -- 8/10 branches in 4 files
- 20.00% documented

### Fixed

- Package configured license files in gem release file lists.

## [0.2.2] - 2026-06-23

- TAG: [v0.2.2][0.2.2t]
- COVERAGE: 96.15% -- 50/52 lines in 4 files
- BRANCH COVERAGE: 80.00% -- 8/10 branches in 4 files
- 20.00% documented

### Added

- Added support for JRuby 10.1 and TruffleRuby 34.0.

### Changed

- Retemplated project metadata and CI/development automation with `kettle-jem` v7.0.0.

### Fixed

- Updated local Appraisal workspace path wiring to use the migrated
  `kettle-dev` organization directory.

## [0.2.1] - 2026-06-14

- TAG: [v0.2.1][0.2.1t]
- COVERAGE: 98.04% -- 50/51 lines in 3 files
- BRANCH COVERAGE: 80.00% -- 8/10 branches in 3 files
- 20.00% documented

### Fixed

- Restored `docs/CNAME` so the generated documentation site keeps its custom domain.
- Avoid loading the Ruby-3.2+-only style toolchain from `Appraisal.root.gemfile`
  on Ruby 3.1, fixing Ruby 3.1 CI dependency resolution.
- Corrected the gemspec public author email to use `floss@galtzo.com`.

## [0.2.0] - 2026-06-06

- TAG: [v0.2.0][0.2.0t]
- COVERAGE: 98.04% -- 50/51 lines in 3 files
- BRANCH COVERAGE: 80.00% -- 8/10 branches in 3 files
- 20.00% documented

### Changed

- Raised the Appraisal2 dependency floor to 3.1.1 and documented the
  `plugin`/`generator_only` integration shape.

## [0.1.0] - 2026-06-06

- TAG: [v0.1.0][0.1.0t]
- COVERAGE: 98.04% -- 50/51 lines in 3 files
- BRANCH COVERAGE: 80.00% -- 8/10 branches in 3 files
- 20.00% documented

### Added

- Added Appraisal2 in-memory gemfile transform hook integration that runs
  RuboCop on generated appraisal gemfiles before Appraisal2 writes them.
- Set the plugin Ruby floor to Ruby 3.1, since generated style normalization is
  intended to run on modern Ruby with RuboCop/RuboCop-LTS.

### Changed

- Updated generated Git attributes to use the `smorg-ruby` diff driver for
  Ruby files.

### Fixed

- Replaced the hardcoded local `appraisal2` Gemfile path with ENV-driven
  `nomono` sibling workspace wiring.

[Unreleased]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v1.0.1...HEAD
[1.0.1]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v1.0.0...v1.0.1
[1.0.1t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v1.0.1
[1.0.0]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v0.2.3...v1.0.0
[1.0.0t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v1.0.0
[0.2.3]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v0.2.2...v0.2.3
[0.2.3t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v0.2.3
[0.2.2]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v0.2.1...v0.2.2
[0.2.2t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v0.2.2
[0.2.1]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v0.2.0...v0.2.1
[0.2.1t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v0.2.1
[0.2.0]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v0.1.0...v0.2.0
[0.2.0t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v0.2.0
[0.1.0]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/93b1188d679a0d56f960a9cd85b48b2c1e2d1a9f...v0.1.0
[0.1.0t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v0.1.0
