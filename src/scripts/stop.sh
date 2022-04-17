#!/bin/bash -e

if [ "$FILTER_PATH" != "" ] && [ ! $(git diff "$FILTER_BASE_REVISION".."$FILTER_HEAD_REVISION" --name-only | grep -E "$FILTER_PATH") ]; then
  echo ci canceled due to no diff detected to "$FILTER_PATH"
  circleci-agent step halt
fi
