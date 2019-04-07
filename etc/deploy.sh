#!/usr/bin/env bash

set -eu

deploy() {
    local src="$1"
    local dst="$2"
    ln -fnsv ${src} ${dst}
}

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

DOT_DEPLOY_PATH=${DOT_PATH}/home
DOT_CONFIG_PATH=${DOT_DEPLOY_PATH}/config

########################################
# files directly under $HOME
########################################
for src_path in $(find ${DOT_DEPLOY_PATH} -maxdepth 1 -type f)
do
    deploy ${src_path} ${HOME}/$(basename ${src_path})
done

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
