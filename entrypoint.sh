#!/usr/bin/env sh

# export preserve_exitcode=${INPUT_PRESERVER_EXITCODE:-origin/master}

echo "INPUT_TEST_STRING ${INPUT_TEST_STRING}"
echo "INPUT_TEST_FIRST ${INPUT_TEST_FIRST}"
echo "INPUT_TEST_OTHER ${INPUT_TEST_OTHER}"

if [[ ${INPUT_TEST_FIRST} == "true" ]]; then
  echo "INPUT_TEST_FIRST \"true\""
fi

if [[ ${INPUT_TEST_FIRST} == true ]]; then
  echo "INPUT_TEST_FIRST 'true'"
fi

if [[ ${INPUT_TEST_OTHER} == "false" ]]; then
  echo "INPUT_TEST_OTHER \"false\""
fi

if [[ ${INPUT_TEST_OTHER} == false ]]; then
  echo "INPUT_TEST_OTHER false"
fi

bundle exec rubocop $@

exit 0
