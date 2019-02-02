#!/usr/bin/env zsh

function en2ja() {
  eval "trans {en=ja} \"$@\""
}

function ja2en() {
  eval "trans {ja=en} \"$@\""
}

function transfer() {
  curl --upload-file ./$1 https://transfer.sh/$1
}

function checkout() {
  mkdir -p $1
  cd $1
}

function mkproj() {
  project_name=$1
  namespace=$2
  if [ -z "${namespace}" ]; then
    namespace="localhost"
  fi
  checkout $DEVPATH/src/${namespace}/${project_name}
  if [ ! -e .git ]; then
    git init
  fi
}

function gh() {
  if [ $# -eq 1 ]; then
    echo "https://github.com/$1.git"
  else
    echo "https://github.com/$1/$2.git"
  fi
}

function has() {
  builtin command -v $1 > /dev/null
}

function sedesc() {
  echo $(echo $1 | sed -e 's/[]\/\=\&\?$*.^[]/\\&/g')
}

if [ `has ghq` -a `has peco` ]; then
  function peco-src() {
    local src=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
      cd "$src"
    fi
  }
  alias pcd='peco-src'
fi

if has peco; then
  function peco-fast-cd() {
    local R
    if [ "$1" = "" -o ! -e $1 ]; then
      R=$PWD
    else
      R=$1
    fi
    local d=$(find $R -type d | peco --query "$LBUFFER" --layout=bottom-up | xargs realpath)
    if [ -n "$d" ]; then
      cd $d
      print -s "cd $d"
    fi
  }
  alias fcd='peco-fast-cd'

  if has ghq; then
    function peco-src() {
      local src=$(ghq list --full-path | peco --query "$LBUFFER" --layout=bottom-up)
      if [ -n "$src" ]; then
        cd "$src"
        print -s "cd $src"
      fi
    }
    alias pcd='peco-src'
  fi
fi
