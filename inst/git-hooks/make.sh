#!/bin/sh

RM="rm -f"
CP="cp"
EXE="/bin/sh -cx"

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..
. ${repo_dir}/sh/util.sh

git_hook_dir="${repo_dir}/.git/hooks"
hooks=$(ls -1 ${dir} | grep -E "^(pre|post|apply|commit|update)-")

if [ "$1" = "install" ]; then
  echo "${hooks}" | while read hook
  do
    cmd="${CP} ${dir}/${hook} ${git_hook_dir}/${hook}"
    log INFO "${cmd}"
    ${cmd}
  done
elif [ "$1" = "clean" ]; then
  echo "${hooks}" | while read hook
  do
    cmd="${RM} ${git_hook_dir}/${hook}"
    log INFO "${cmd}"
    ${cmd}
  done
fi
