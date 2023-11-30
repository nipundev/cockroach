#!/usr/bin/env bash

set -euo pipefail

export EXTRA_TEST_ARGS="--config use_ci_timeouts"

THIS_DIR=$(cd "$(dirname "$0")" && pwd)

unset GITHUB_API_TOKEN

$THIS_DIR/stress_engflow_impl.sh
