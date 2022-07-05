#!/usr/bin/env sh

# export preserve_exitcode=${INPUT_PRESERVER_EXITCODE:-origin/master}

echo "INPUT_TEST_STRING ${INPUT_TEST_STRING}"
echo "INPUT_TEST_FIRST ${INPUT_TEST_FIRST}"
echo "INPUT_TEST_OTHER ${INPUT_TEST_OTHER}"

bundle exec rubocop $@

exit 0
