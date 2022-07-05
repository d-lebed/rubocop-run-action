#!/usr/bin/env sh

bundle exec rubocop $@
EXITCODE=$?

if $INPUT_PRESERVE_EXITCODE; then
  exit $EXITCODE
fi
