# Set aliases to bin/_*
alias gcd='source _gcd'

case ${OSTYPE} in
    linux*)
        alias ls="ls --color=auto --show-control-chars"
        alias grep="grep -a"
        alias pbcopy="xsel --clipboard --input"
        ;;
    darwin*)
        alias readlink="greadlink"
        alias ls="gls --color=auto --show-control-chars"
        alias sed="gsed"
        alias awk="gawk"
        alias date="gdate"
        ;;
esac
