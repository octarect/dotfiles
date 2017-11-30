paths = [/usr/local/bin $@paths $E:HOME/.local $E:HOME/.bin]

# Environment variables
E:LANG   = en_US.UTF-8
E:EDITOR = nvim
E:VISUAL = nvim
E:FCEDIT = nvim
E:PAGER  = less
E:TERM   = xterm-256color


E:XDG_CONFIG_HOME = $E:HOME/.config
E:GOPATH          = $E:HOME/code
E:DEVPATH         = $E:GOPATH
E:GOROOT          = (go env GOROOT)

paths = [$@paths $E:GOPATH/bin]

# Alias
if (==s (uname | tr "[A-Z]" "[a-z]") "darwin") {
  fn ls [@a]{ e:gls --color=auto --show-control-chars }
  fn readlink [@a]{ e:greadlink }
}

# Completion
edit:-matcher[''] = [p]{ edit:match-prefix &smart-case $p }

# Start up
paths = [$E:HOME/.anyenv/bin $@paths]
# exec ""(anyenv init -)""
screenfetch -E -A "Unix"
