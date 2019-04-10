#!/usr/bin/env bash

__dotlib::log() {
    if [ "${SHELL}" = "bash" ]; then
        local level="${1^^}"; shift
    else
        local level="$(tr '[a-z]' '[A-Z]' <<< $1)"
    fi
    local body="$@"
    local msg="[${level}] ${body}"

    case "${level}" in
        DEBUG)
            if [ "${DEBUG}" = 1 ]; then
                echo "${msg}" >&1
            fi
            ;;
        INFO)
            echo "${msg}" >&1
            ;;
        ERROR)
            echo "${msg}" >&2
            ;;
    esac

    return 0
}
