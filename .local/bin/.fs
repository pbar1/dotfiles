#!/usr/bin/env sh

set -e

.f status --short --untracked-files=no "$@"
