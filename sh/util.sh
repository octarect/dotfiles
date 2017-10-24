#!/bin/sh

to_upper() {
  echo $(echo $1 | awk '{print toupper($0)}')
}

has() {
  type $1 &> /dev/null
  test $? = 0
}

log() {
  echo "[$(to_upper $1)] $2"
}

