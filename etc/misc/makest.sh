#!/bin/bash

set -ex

WORK_DIR=${DOT_CACHE_DIR}/st

rm -rf ${WORK_DIR}
cp -r ${DOT_DIR}/etc/st ${WORK_DIR}

cur_dir=$(pwd)
cd ${WORK_DIR}
makepkg -si
cd ${cur_dir}
rm -rf ${WORK_DIR}
