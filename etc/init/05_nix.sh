#!/usr/bin/env bash

[[ "${DOT_NIX_DISABLED}" = "1" ]] && return 0

curl -X GET -L https://nixos.org/nix/install | sh

source ${DOT_PATH}/lib/dotlib/init.sh
__dotlib::load_nix

nix-channel --update
nix-env --install neofetch
