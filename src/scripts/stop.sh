#!/bin/bash -e

if [ -n "$FILTER_ORB_DEBUG" ]; then
  set -x
fi

if [ -z "$FILTER_PATH" ]; then
  echo no filter path given
  exit 1
fi

if git diff "$FILTER_BASE_REVISION".."$FILTER_HEAD_REVISION" --name-only | grep -q -E "$FILTER_PATH"; then
  echo ci canceled due to diff detected to "$FILTER_PATH" between "$FILTER_BASE_REVISION".."$FILTER_HEAD_REVISION"
  circleci-agent step halt
fi
