#!/bin/bash -e

# Fetch remote revision to get diff of target revisions
# This process needs if repository shallow cloned.
echo "$FILTER_REMOTE"
echo "$FILTER_BASE_REVISION"
echo "$FILTER_HEAD_REVISION"
git fetch "$FILTER_REMOTE" "$FILTER_BASE_REVISION" "$FILTER_HEAD_REVISION"
