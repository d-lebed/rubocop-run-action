# Run RuboCop docker action

This action runs RuboCop with given options.

## Available plugins

* rubocop
* rubocop-performance
* rubocop-thread_safety
* rubocop-rails
* rubocop-rspec
* standard

## Inputs

| Name                | Default | Type    | Description |
| ------------------- | ------- | ------- | ----------- |
| `options`           |         | String  | RuboCop command line options to pass |
| `preserve_exitcode` | True    | Boolean | Preserve RuboCop exit code or always finish successfully |
| `workdir`           | `.`     | String  | From which directory to run RuboCop |

## Example usage

```yaml
steps:
- name: Checkout
  uses: actions/checkout@v3
  with:
    path: app_code

- name: Generate RuboCop report
  uses: d-lebed/rubocop-run-action@v0.3.0
  with:
    options: --format=json --out=rubocop.json
    preserve_exitcode: false
    workdir: app_code
```
