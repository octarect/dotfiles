#!/bin/bash -e

ANSIBLE_HOME="${ANSIBLE_HOME:-./tmp/ansible}"
ANSIBLE_VERSION="${ANSIBLE_VERSION:-2.7.8}"

COMMAND_NAME="$1"
shift

ansible_lib_path="${ANSIBLE_HOME}/${ANSIBLE_VERSION}"
ansible_bin_path="${ansible_lib_path}/bin"

if [ ! -e "${ansible_lib_path}" ]; then
    mkdir -p ${ansible_lib_path}
    pip install -t ${ansible_lib_path} ansible==${ANSIBLE_VERSION}
fi


env PYTHONPATH=${ansible_lib_path} ${ansible_bin_path}/${COMMAND_NAME} $@
