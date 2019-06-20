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


source ${HOME}/.dotenv
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

DOTMAP_JSON="$(cat ${DOT_DIR}/dotmap.json)"

set -o noglob
for src in $(echo "${DOTMAP_JSON}" | jq -r "keys[]")
do
  dst="$(echo "${DOTMAP_JSON}" | jq -r ".[\"${src}\"]")"
  dst="$(eval echo "${dst}")"

  if [[ "${src}" =~ /\*$ ]]; then
    link_children $(dirname ${src}) $(dirname ${dst})
  else
    deploy ${src} ${dst}
  fi
done
set +o noglob
