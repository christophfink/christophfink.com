#!/bin/bash

set +m -euo pipefail
IFS=$'\n\t '

declare SRC="$(dirname $0)/src/"
declare BUILD="$(dirname $0)/build/"
declare REMOTE="christoph@[fdcf::1]:/var/www/dev.christophfink.com/htdocs-secure/"

# 1. sync to build dir and generate css from sass
rsync \
    --archive \
    --info=progress2 \
    --delete \
    --copy-unsafe-links \
    --exclude="assets/sass/" \
    "${SRC}" \
    "${BUILD}"

mkdir -p "${BUILD}/assets/css/"

sassc \
    --sass \
    --style compressed \
    "${SRC}/assets/sass/christophfink.com.sass" \
    "${BUILD}/assets/css/christophfink.com.css"

# 2. sync to server
rsync \
    --archive \
    --info=progress2 \
    --exclude="urbanage-ttm-ui" \
    --exclude="urbanage-ttm" \
    --delete \
    "${BUILD}" \
    "${REMOTE}"
