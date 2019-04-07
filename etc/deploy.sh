#!/usr/bin/env bash

set -eu

source ${DOT_PATH}/src/dotlib/init.sh

deploy() {
    local src="$1"
    local dst="$2"
    ln -fnsv ${src} ${dst}
    __dotlib::log info "${src} -> ${dst}"
}

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
DOT_DEPLOY_PATH=${DOT_PATH}/etc/deploy
DOT_CONFIG_PATH=${DOT_DEPLOY_PATH}/config
DOT_ZSHENV_PATH=${DOT_DEPLOY_PATH}/config/zsh/.zshenv

########################################
# .config
########################################
mkdir -p ${XDG_CONFIG_HOME}
for src_path in $(find ${DOT_CONFIG_PATH} -mindepth 1 -maxdepth 1)
do
    conf_name=$(realpath ${src_path} --relative-base ${DOT_CONFIG_PATH})
    dst_path=${XDG_CONFIG_HOME}/${conf_name}
    deploy ${src_path} ${dst_path}
done

########################################
# .zshenv
########################################
deploy ${DOT_ZSHENV_PATH} ${HOME}/.zshenv
