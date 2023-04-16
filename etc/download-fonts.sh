#!/bin/bash

set -xe

CICA_RELEASES_URL="https://api.github.com/repos/miiton/Cica/releases"
if [ "$(uname)" = "Darwin" ]; then
    cica_font_path="${HOME}/Library/Fonts"
else
    cica_font_path="${HOME}/.local/share/fonts"
fi

curl -sfL "${CICA_RELEASES_URL}" | jq -r '.[0].assets | .[].browser_download_url' | grep -v without_emoji.zip | head -n1 | xargs -I{} curl -fL -o cica.zip "{}"
unzip -d $cica_font_path cica.zip Cica-Regular.ttf Cica-RegularItalic.ttf Cica-Bold.ttf Cica-BoldItalic.ttf
rm cica.zip

fc-cache -v
