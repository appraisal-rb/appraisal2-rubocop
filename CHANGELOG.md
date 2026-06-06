# Changelog

## [Unreleased]

### Added

- Added Appraisal2 in-memory gemfile transform hook integration that runs
  RuboCop on generated appraisal gemfiles before Appraisal2 writes them.
- Set the plugin Ruby floor to Ruby 3.1, since generated style normalization is
  intended to run on modern Ruby with RuboCop/RuboCop-LTS.
