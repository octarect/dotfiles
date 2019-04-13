#!/usr/bin/env bash

[[ "${DOT_NIX_DISABLED}" = "1" ]] && return 0

sudo sysctl kernel.unprivileged_userns_clone=1
cat <<EOF | sudo tee /etc/sysctl.d/50-nix.conf >/dev/null
kernel.unprivileged_userns_clone=1
EOF

sh <(curl -X GET -L https://nixos.org/nix/install)

source ${DOT_PATH}/lib/dotlib/init.sh
__dotlib::load_nix

nix-channel --update
nix-env --install tmux
nix-env --install neovim
nix-env --install neofetch
