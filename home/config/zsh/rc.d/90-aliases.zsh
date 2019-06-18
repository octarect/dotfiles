case ${OSTYPE} in
    linux*)
        alias ls="ls --color=auto --show-control-chars"
        alias grep="grep -a"
        alias pbcopy="xsel --clipboard --input"
        ;;
    darwin*)
        alias ls="gls --color=auto --show-control-chars"
        ;;
esac
