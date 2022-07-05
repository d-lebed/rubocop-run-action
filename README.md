# Run Rubocop docker action

This action runs rubocop with given options.

## Inputs

## `options`

Rubocop command line options to pass.

## Example usage

```yaml
uses: dlebed/rubocop-run-action@v0.1
with:
  options: --format=json --out=rubocop.json
```
