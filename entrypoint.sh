#!/usr/bin/env sh

bundle exec rubocop $@
EXITCODE=$?

exit ($INPUT_PRESERVE_EXITCODE && $EXITCODE || 0)
