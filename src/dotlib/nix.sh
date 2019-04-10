#!/usr/bin/env bash

__dotlib::load_nix() {
    local NIX_SH=${HOME}/.nix-profile/etc/profile.d/nix.sh
    [[ -e ${NIX_SH} ]] && source ${NIX_SH}
}
