#!/usr/bin/env bash

set -eu

deploy() {
    local src="$1"
    local dst="$2"
    ln -fnsv ${src} ${dst}
}

link_children() {
    local src_dir="$1"
    local dst_dir="$2"
    local name=""
    mkdir -p ${dst_dir}
    for src_path in $(find ${src_dir} -mindepth 1 -maxdepth 1)
    do
        name=$(realpath ${src_path} --relative-base ${src_dir})
        dst_path=${dst_dir}/${name}
        deploy ${src_path} ${dst_path}
    done
}

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

DOT_DEPLOY_PATH=${DOT_PATH}/home
DOT_CONFIG_PATH=${DOT_DEPLOY_PATH}/config
DOT_FONTS_PATH=${DOT_DEPLOY_PATH}/fonts

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
link_children ${DOT_CONFIG_PATH} ${XDG_CONFIG_HOME}

########################################
# font
########################################
link_children ${DOT_FONTS_PATH} ${HOME}/.local/share/fonts
