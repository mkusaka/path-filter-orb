#!/bin/bash -e

# Fetch remote revision to get diff of target revisions
# This process needs if repository shallow cloned.
if [ -n "$FILTER_ORB_DEBUG" ]; then
  set -x
fi

git fetch "$FILTER_REMOTE" "$FILTER_BASE_REVISION" "$FILTER_HEAD_REVISION"
