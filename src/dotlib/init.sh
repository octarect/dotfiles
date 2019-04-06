#!/usr/bin/env bash

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
script_files=$(find ${script_dir} -type f -not -name "init.sh")

for file in "${script_files}"
do
    source ${file}
done
