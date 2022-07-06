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

| Name                | Default           | Type    | Description |
| ------------------- | ----------------- | ------- | ----------- |
| `options`           | `--format=github` | String  | RuboCop command line options to pass |
| `preserve_exitcode` | True              | Boolean | Preserve RuboCop exit code or always finish successfully |
| `workdir`           | `.`               | String  | From which directory to run RuboCop |

## Example usage

```yaml
steps:
- name: Checkout
  uses: actions/checkout@v3
  with:
    path: app_code

- name: Generate RuboCop report
  uses: d-lebed/rubocop-run-action@v0.4.0
  with:
    options: --format=json --out=rubocop-report.json --format=github
    preserve_exitcode: false
    workdir: app_code
```

## Using with Docker Compose

It is possible to use Docker container provided by this repo in development. If you are using Docker Compose add
something like that to your docker-compose.yml

```yaml
# ...

services:
  rubocop:
    image: ghcr.io/d-lebed/rubocop-run-action:latest
    volumes:
      - .:/code

# ...
```

Then run `docker compose run --rm rubocop <extra options if needed>`. Mount default rubocop config to
/root/.rubocop.yml if you want to have fallback to the default one.

## Using with editors

### Sublime Text

You can use it with Sublime Text. For example to run
[SublimeLinter-rubocop](https://github.com/SublimeLinter/SublimeLinter-rubocop) add something like that to
your SublimeLinter config:

```json
{
  "linters": {
    "rubocop": {
      "use_bundle_exec": false,
      "executable": [
        "docker",
        "run",
        "--rm",
        "-i",
        "-v",
        "~/.rubocop.yml:/root/.rubocop.yml",
        "-v",
        "${folder:$file_path}:${folder:$file_path}",
        "-w",
        "${folder:$file_path}",
        "ghcr.io/d-lebed/rubocop-run-action:latest"
      ]
    },
    "eslint": {
      "disable": true
    }
  }
}
```

`"~/.rubocop.yml:/root/.rubocop.yml"` mount is optional. You can use it if you want to have default RuboCop config
when files you lint are located not in your project directory.
