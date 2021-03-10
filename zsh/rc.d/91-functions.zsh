pcd() {
    local project_dir=$(ghq list --full-path | peco --query "${LBUFFER}" --layout=bottom-up)
    if [[ -n "${project_dir}" ]]; then
        cd "${project_dir}"
    fi
}

fcd() {
    if [[ -n "$1" ]]; then
        base_dir="$1"
    else
        base_dir=$(PWD)
    fi
    target_dir=$(find ${base_dir} -type d | peco --query "${LBUFFER}" --layout=bottom-up | xargs realpath)
    if [[ -n "${target_dir}" ]]; then
        cd ${target_dir}
        print -s "cd ${target_dir}"
    fi
}
