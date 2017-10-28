#!/bin/sh

RM="rm -rf"
EXE="/bin/sh -cx"

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..
. ${repo_dir}/sh/util.sh

gopath=$(go env GOPATH)

if [ "$1" = "install" ]; then
  ${EXE} "go get github.com/motemen/ghq"
  ${EXE} "go get github.com/Songmu/ghg/cmd/ghg"
  ghgpath=$(ghg bin)

  ${EXE} "ghg get peco/peco"
  ${EXE} "mv ${ghgpath}/peco ${gopath}/bin/peco"

elif [ "$1" = "clean" ]; then
  ${EXE} "${RM} ${gopath}/bin/peco"

  ${EXE} "${RM} $(ghq list -p -e ghg)"
  ${EXE} "${RM} ${gopath}/bin/ghg"
  ${EXE} "${RM} $(ghq list -p -e ghq)"
  ${EXE} "${RM} ${gopath}/bin/ghq"
fi
