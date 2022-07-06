#!/usr/bin/env sh

RUNNER_WORKDIR=${INPUT_WORKDIR:-.}

if [[ -z ${GITHUB_WORKSPACE} ]]; then
  cd ${RUNNER_WORKDIR}
else
  cd ${GITHUB_WORKSPACE}/${RUNNER_WORKDIR}
fi

bundle exec rubocop $@
EXITCODE=$?

if $INPUT_PRESERVE_EXITCODE; then
  exit $EXITCODE
fi
