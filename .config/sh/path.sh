#==============================================================================
# ~/.config/sh/path.sh
#
# This file contains customizations for the `PATH` environment variable. It is
# sourced elsewhere.
#==============================================================================

export PATH="${HOME}/.local/bin:${HOME}/.krew/bin:${GOPATH}/bin:${CARGO_HOME}/bin:${DENO_INSTALL_ROOT}/bin:${XDG_DATA_HOME}/npm/bin:${PATH}"
