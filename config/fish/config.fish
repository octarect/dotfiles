#!/usr/bin/fish

set REPO_DIR $HOME/dotfiles
set ENVFILE $REPO_DIR/env.sh
set -x SHELL fish

for line in (cat $ENVFILE)
  if test -n $line
    eval (echo $line | awk 'BEGIN { FS="=" } $2 ~ /`.+`/ { sub(/`/, "(", $2); sub(/`/, ")", $2) } { print "set -x " $1 " " $2 }')
  end
end

set -x PATH $PATH $GOPATH/bin

source $REPO_DIR/init.sh
