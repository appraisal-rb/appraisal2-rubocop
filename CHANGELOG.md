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

### Deprecated

### Removed

### Fixed

- Restored `docs/CNAME` so the generated documentation site keeps its custom domain.
- Avoid loading the Ruby-3.2+-only style toolchain from `Appraisal.root.gemfile`
  on Ruby 3.1, fixing Ruby 3.1 CI dependency resolution.

### Security

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

[Unreleased]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/v0.1.0...v0.2.0
[0.2.0t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v0.2.0
[0.1.0]: https://github.com/appraisal-rb/appraisal2-rubocop/compare/93b1188d679a0d56f960a9cd85b48b2c1e2d1a9f...v0.1.0
[0.1.0t]: https://github.com/appraisal-rb/appraisal2-rubocop/releases/tag/v0.1.0
