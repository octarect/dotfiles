#!/usr/bin/env bash

__dotlib::log() {
    local level="${1^^}"; shift
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
