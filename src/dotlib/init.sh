#!/usr/bin/env bash

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)

for file in $(find ${script_dir} -type f -not -name "init.sh")
do
    source ${file}
done
