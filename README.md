# Run Rubocop docker action

This action runs rubocop with given options.

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
| `options`           |         | String  | Rubocop command line options to pass |
| `preserve_exitcode` | True    | Boolean | Preserve rubocop exit code or alwaye finish successffuly |

## Example usage

```yaml
uses: d-lebed/rubocop-run-action@v0.3.0
with:
  options: --format=json --out=rubocop.json
  preserve_exitcode: false
```
