# appraisal2-rubocop

Runs RuboCop against Appraisal2-generated gemfiles via Appraisal2 lifecycle hooks.

Require the plugin before generating appraisal gemfiles:

```ruby
require "appraisal2/rubocop"
```

By default each generated gemfile is processed with:

```sh
rubocop --autocorrect path/to/generated.gemfile
```

Configuration:

- `APPRAISAL2_RUBOCOP=false` disables the hook.
- `APPRAISAL2_RUBOCOP_COMMAND` overrides the executable.
- `APPRAISAL2_RUBOCOP_FLAGS` overrides the default `--autocorrect` flag list.
