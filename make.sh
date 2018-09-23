#!/bin/sh
EXEC=/bin/sh

# get absolute path to dir of the dotfiles' repo
REPO_DIR=$(cd $(dirname $0) && pwd)

# load convenient functions
. ${REPO_DIR}/sh/util.sh

makesh() {
  _cmd=$1
  _op=$2
  script=${REPO_DIR}/inst/${_cmd}/make.sh
  if [ -e $script ]; then
    log info "${script} ${_cmd} ${_op}"
    $EXEC $script $_op
  else
    log fail "$script not found."
  fi
}

# available: install, clean
if [ -z $1 ]; then
  op=install
else
  op=$1
fi

if [ ! -z $2 ]; then
  makesh $2 $op
  exit 0
fi

# put git hooks for the future updates
makesh git-hooks $op

# install or clean configulations in $XDG_CONFIG_HOME
makesh config $op

# font
makesh font $op

# execute command-specific installations
targets=$(find ${REPO_DIR}/inst/* -maxdepth 0 -type d)
for target in $targets
do
  cmd=$(basename $target)
  if has $cmd; then
    makesh $cmd $op
  fi
done
