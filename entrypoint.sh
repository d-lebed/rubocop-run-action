#!/usr/bin/env sh

# export preserve_exitcode=${INPUT_PRESERVER_EXITCODE:-origin/master}

echo "INPUTS_TEST_STRING ${INPUTS_TEST_STRING}"
echo "INPUTS_TEST_FIRST ${INPUTS_TEST_FIRST}"
echo "INPUTS_TEST_OTHER ${INPUTS_TEST_OTHER}"

bundle exec rubocop $@

exit 0
