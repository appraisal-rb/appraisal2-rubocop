# appraisal2-rubocop

Runs RuboCop against Appraisal2-generated gemfiles via Appraisal2 lifecycle hooks.

This plugin is intended for modern Ruby style-maintenance environments. It does
not match Appraisal2's legacy runtime floor.

Require the plugin before generating appraisal gemfiles:

```ruby
require "appraisal2/rubocop"
```

By default each generated gemfile is processed in memory with:

```sh
rubocop --stdin path/to/generated.gemfile --autocorrect --stderr --format quiet
```

Configuration:

- `APPRAISAL2_RUBOCOP=false` disables the hook.
- `APPRAISAL2_RUBOCOP_COMMAND` overrides the executable.
- `APPRAISAL2_RUBOCOP_FLAGS` overrides the default `--autocorrect` flag list.
