#!/bin/bash

set -e

source $HOME/.dotenv

# Manage a package and its dependencies in the version-specific directory
[[ -z "$PKG_NAME" ]] && echo "Please set PKG_NAME" && exit 1
pkg_name="$PKG_NAME"
pkg_version="${PKG_VERSION:-latest}"

pkg_path="${DOT_CACHE_DIR}/pip/$pkg_name/${pkg_version}"

cmd="${CMD:-$pkg_name}"

if [[ ! -d "$pkg_path" || "$PKG_UPDATE" = "true" ]]; then
    if [ "$pkg_version" == "latest" ]; then
        pkg_spec=$pkg_name
    else
        pkg_spec="$pkg_name==$pkg_version"
    fi
    pip install -U pip
    pip install -U -t $pkg_path $pkg_spec
fi

env PYTHONPATH=$pkg_path $pkg_path/bin/$cmd $@
