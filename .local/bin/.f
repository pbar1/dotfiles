#!/usr/bin/env sh

set -e

git --git-dir="$HOME/.config/dotfiles.git/" --work-tree="$HOME" "$@"
