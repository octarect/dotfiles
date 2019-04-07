#!/usr/bin/env bash

sh <(curl https://nixos.org/nix/install)

source ${DOT_PATH}/src/dotlib/init.sh
__dotlib::load_nix

nix-channel --update
