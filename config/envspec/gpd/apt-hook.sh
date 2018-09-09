#!/bin/sh

current_dir=$(pwd)
script_dir=$(cd $(dirname $0) && pwd)
repo_dir=${script_dir}/../../..
respin_dir=/tmp/gpd-pocket-ubuntu-respin
update_cmd="${respin_dir}/update.sh bionicbeaver"
update_kernel_cmd="${respin_dir}/update-kernel.sh"

# load convenient functions
. ${repo_dir}/sh/util.sh

git clone https://github.com/stockmind/gpd-pocket-ubuntu-respin ${respin_dir}

${update_cmd}
${update_kernel_cmd}

sed -e 's/\(GRUB_CMDLINE_LINUX\)\(_DEFAULT\)*=\"i915/\1\2=\"resume=\/dev\/mmcblk0p2 i915/' /etc/default/grub --in-place=.bak

update-grub

rm -rf ${respin_dir}
