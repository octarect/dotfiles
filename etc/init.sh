#!/usr/bin/env bash

set -e

greet() {
cat << 'EOS'

 /\ \        /\ \__  /'___\ __ /\_ \
 \_\ \    ___\ \ ,_\/\ \__//\_\\//\ \      __    ____
 /'_` \  / __`\ \ \/\ \ ,__\/\ \ \ \ \   /'__`\ /',__\
/\ \L\ \/\ \L\ \ \ \_\ \ \_/\ \ \ \_\ \_/\  __//\__, `\
\ \___,_\ \____/\ \__\\ \_\  \ \_\/\____\ \____\/\____/
 \/__,_ /\/___/  \/__/ \/_/   \/_/\/____/\/____/\/___/

EOS
}

init_scripts() {
    local init_script_dir="${DOT_DIR}/etc/init"
    echo -e "$(find ${init_script_dir} -mindepth 1 -maxdepth 1 -type f | sort)"
}

source_all() {
    for file in $@
    do
        echo ${file}
        source ${file}
    done
}

greet

source ${HOME}/.dotenv
mkdir -p ${DOT_CACHE_DIR}

if [[ -z ${DOT_DIR} ]]; then
    echo '$DOT_DIR is required. Pleace make sure that ~/.dotenv exists.' >&2
    exit 1
fi

source ${DOT_DIR}/lib/dotlib/init.sh

name="$1"

if [[ -z "${name}" ]]; then
    source_all $(init_scripts)
else
    source $(echo -e "$(init_scripts)" | grep -E "${name}.sh")
fi
