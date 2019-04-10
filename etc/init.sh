#!/usr/bin/env bash

set -e

init_scripts() {
    local init_script_dir="${DOT_PATH}/etc/init"
    echo $(find ${init_script_dir} -mindepth 1 -maxdepth 1 -type f | sort)
}

source_all() {
    for file in $@
    do
        echo ${file}
        source ${file}
    done
}

if [ -z ${DOT_PATH} ]; then
    echo '$DOT_PATH is required.' >&2
    exit 1
fi

source ${DOT_PATH}/lib/dotlib/init.sh

source ${HOME}/.dotenv
mkdir -p ${DOT_CACHE_DIR}

source_all $(init_scripts)
