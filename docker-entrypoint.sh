#!/usr/bin/env bash
set -e

exec /npm/node_modules/.bin/semantic-release "$@"
