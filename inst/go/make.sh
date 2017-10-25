#!/bin/sh

RM="rm -rf"

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..

if [ "$1" = "install" ]; then
  go get github.com/motemen/ghq

  ghq get peco/peco
elif [ "$1" = "clean" ]; then
  gopath=$(go env GOPATH)

  ${RM} $(ghq list -p -e peco)
  ${RM} ${gopath}/bin/peco

  ${RM} $(ghq list -p -e ghq)
  ${RM} ${gopath}/bin/ghq
fi
