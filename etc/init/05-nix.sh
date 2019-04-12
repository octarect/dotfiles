#!/usr/bin/env bash

[[ "${DOT_NIX_DISABLED}" = "1" ]] && return 0

sh <(curl -X GET -L https://nixos.org/nix/install)

source ${DOT_PATH}/lib/dotlib/init.sh
__dotlib::load_nix

nix-channel --update
nix-env --install tmux
nix-env --install neovim
nix-env --install neofetch
