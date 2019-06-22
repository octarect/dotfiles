#!/bin/bash

set -xe

CICA_RELEASES_URL="https://api.github.com/repos/miiton/Cica/releases"

curl -sfL "${CICA_RELEASES_URL}" | jq -r '.[0].assets | .[].browser_download_url' | grep with_emoji.zip | xargs -I{} curl -fL -o cica.zip "{}"
unzip -d ~/.local/share/fonts cica.zip Cica-Regular.ttf Cica-RegularItalic.ttf Cica-Bold.ttf Cica-BoldItalic.ttf
rm cica.zip

fc-cache -v
