#!/usr/bin/env bash

set -e

run_init_scripts() {
    echo "aaa"
}

init_scripts() {
    local init_script_dir="${DOT_PATH}/etc/init"
    echo $(find ${init_script_dir} -mindepth 1 -maxdepth 1 -type f)
}

source_all() {
    local script_paths="$1"
    for file in "$(init_scripts)"
    do
        source "${file}"
    done
}

if [ -z ${DOT_PATH} ]; then
    echo '$DOT_PATH is required.' >&2
    exit 1
fi

# Global variables
DOT_TMP_PATH=${DOT_PATH}/tmp

source ${DOT_PATH}/src/dotlib/init.sh

source_all $(init_scripts)
