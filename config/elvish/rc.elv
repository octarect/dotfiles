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
fn ls [@a]{ e:ls --color $@a }

# Completion
edit:-matcher[''] = [p]{ edit:match-prefix &smart-case $p }
