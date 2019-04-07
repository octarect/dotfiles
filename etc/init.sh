#!/usr/bin/env bash

set -e

init_scripts() {
    local init_script_dir="${DOT_PATH}/etc/init"
    echo $(find ${init_script_dir} -mindepth 1 -maxdepth 1 -type f | sort)
}

source_all() {
    echo $@
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

# Global variables
DOT_TMP_PATH=${DOT_PATH}/tmp

source ${DOT_PATH}/src/dotlib/init.sh

source_all $(init_scripts)
