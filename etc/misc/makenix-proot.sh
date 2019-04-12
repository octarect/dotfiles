#!/bin/bash

set -ex

# PROOT_BIN_URL="https://github.com/proot-me/proot-static-build/releases/download/v5.1.1/proot_5.1.1_x86_64_rc2--no-seccomp"
PROOT_BIN_URL="https://github.com/proot-me/proot-static-build/releases/download/v5.1.1/proot_5.1.1_x86_64_rc2"
NIX_INSTALL_URL="https://nixos.org/nix/install"

source ${HOME}/.dotenv

work_dir=${HOME}/nix
proot_bin_path=${DOT_CACHE_DIR}/proot
nix_install_script_path=${work_dir}/install.sh

mkdir -p ${work_dir}
mkdir -p ${DOT_CACHE_DIR}

curl -X GET -L ${PROOT_BIN_URL} > ${proot_bin_path}
chmod +x ${proot_bin_path}

curl -X GET -L ${NIX_INSTALL_URL} > ${nix_install_script_path}

# ${proot_bin_path} -b ${work_dir}:/nix /bin/bash ${nix_install_script_path}
PROOT_NO_SECCOMP=1 ${proot_bin_path} -b ${work_dir}:/nix /bin/bash
