# Run RuboCop docker action

This action runs RuboCop with given options.

## Available plugins

* standard
* rubocop
* rubocop-performance
* rubocop-i18n
* rubocop-md
* rubocop-minitest
* rubocop-rails
* rubocop-rake
* rubocop-require_tools
* rubocop-rspec
* rubocop-sequel
* rubocop-thread_safety

It also includes `pronto` and `pronto-rubocop` gems to be able to run pronto when necessarily.

## Inputs

| Name                | Default           | Type    | Description |
| ------------------- | ----------------- | ------- | ----------- |
| `options`           | `--format=github` | String  | RuboCop command line options to pass |
| `preserve_exitcode` | True              | Boolean | Preserve RuboCop exit code or always finish successfully |
| `rdjson_formatter`  | False             | Boolean | Enable [Reviewdog](https://github.com/reviewdog/reviewdog) JSON formatter |
| `workdir`           | `.`               | String  | From which directory to run RuboCop |

## Example usage

```yaml
steps:
- name: Checkout
  uses: actions/checkout@v3
  with:
    path: app_code

- name: Generate RuboCop report
  uses: d-lebed/rubocop-run-action@v0.10.0
  with:
    options: --format=json --out=rubocop-report.json --format=github
    preserve_exitcode: false
    workdir: app_code
```

## Example usage with Reviewdog

```yaml
steps:
- name: Checkout
  uses: actions/checkout@v3
  with:
    path: app_code

- name: Install Reviewdog
  uses: reviewdog/action-setup@v1

- name: Generate RuboCop report
  uses: d-lebed/rubocop-run-action@v0.10.0
  with:
    options: --format=RdjsonFormatter --out=reviewdog-report.json --format=progress
    rdjson_formatter: true
    preserve_exitcode: false
    workdir: app_code

- name: Post Review
  env:
    REVIEWDOG_GITHUB_API_TOKEN: ${{ github.token }}
  run: |
    reviewdog \
      -reporter=github-pr-review \
      -filter-mode=added \
      -f=rdjson \
      < reviewdog-report.json
```

## Using with Docker Compose

It is possible to use Docker container provided by this repo in development. If you are using Docker Compose add
something like that to your docker-compose.yml

```yaml
# ...

services:
  rubocop:
    image: ghcr.io/d-lebed/rubocop-run-action:v0
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
        "ghcr.io/d-lebed/rubocop-run-action:v0"
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

### VS Code

It is possibe to use it in VS Code using [Linter](https://marketplace.visualstudio.com/items?itemName=fnando.linter)
extension.

Create wrapper script and put it somewhere in your PATH:

```bash
#!/usr/bin/env bash

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --config)
    CONFIG="$2"
    shift # past argument
    shift # past value
    ;;
    --rootDir)
    ROOT_DIR="$2"
    shift # past argument
    shift # past value
    ;;
    --)
    shift # past the double dash, to signify the end of options
    REST_PARAMS="$@" # Collect remaining parameters into REST_PARAMS
    break
    ;;
    *)
    shift # past argument
    ;;
  esac
done

DOCKER_CMD="docker run --rm -i"

if [[ -f "${HOME}/.rubocop.yml" ]]; then
  DOCKER_CMD="${DOCKER_CMD} -v ${HOME}/.rubocop.yml:/root/.rubocop.yml"
fi
if [[ ! -z "${CONFIG}" ]]; then
  DOCKER_CMD="${DOCKER_CMD} -v ${CONFIG}:${ROOT_DIR}/.rubocop.yml"
fi

DOCKER_CMD="${DOCKER_CMD} -v ${ROOT_DIR}:${ROOT_DIR} -w ${ROOT_DIR}"

# Execute!
$DOCKER_CMD ghcr.io/d-lebed/rubocop-run-action:latest $REST_PARAMS
```

Then add next linter configuration to your `settings.json`:

```json
"linter.linters": {
  "rubocop": {
    "enabled": true,
    "command": [
      "docker-lint-rubocop",
      ["$config", "--config", "$config"],
      ["$rootDir", "--rootDir", "$rootDir"],
      "--",
      ["$lint", "--format", "json", "--extra-details"],
      ["$config", "--config", "$config"],
      ["$debug", "--debug"],
      ["$fixAll", "--auto-correct-all", "--stderr"],
      ["$fixCategory", "--auto-correct-all", "--only", "$code", "--stderr"],
      "--stdin",
      "$file"
    ]
  }
}
```
