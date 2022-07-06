#!/usr/bin/env sh

RUNNER_WORKDIR=${INPUT_WORKDIR:-.}
RUNNER_OPTIONS=${INPUT_OPTIONS:-"$@"}

if $INPUT_RDJSON_FORMATTER; then
  RUNNER_OPTIONS="--require /rubocop/lib/rdjson_formatter.rb ${RUNNER_OPTIONS}"
fi

if [[ -z ${GITHUB_WORKSPACE} ]]; then
  cd ${RUNNER_WORKDIR}
else
  cd ${GITHUB_WORKSPACE}/${RUNNER_WORKDIR}
fi

bundle exec rubocop ${RUNNER_OPTIONS}
EXITCODE=$?

if $INPUT_PRESERVE_EXITCODE; then
  exit $EXITCODE
fi
