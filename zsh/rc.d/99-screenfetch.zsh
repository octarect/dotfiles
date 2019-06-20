declare _screenfetch=""

if __dotlib::util::has_cmd neofetch; then
    _screenfetch=neofetch
elif __dotlib::util::has_cmd screenfetch; then
    _screenfetch=screenfetch
fi

if [[ ! -z "${_screenfetch}" ]]; then
    if [[ -e ${HOME}/.${_screenfetch} ]]; then
        source ${HOME}/.${_screenfetch}
    else
        ${_screenfetch} -E
    fi
fi
