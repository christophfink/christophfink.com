#!/bin/bash

set +m -euo pipefail
IFS=$'\n\t '

declare SRC="$(dirname $0)/src/"
declare BUILD="$(dirname $0)/build/"
declare REMOTE_DEVELOPMENT="christoph@[fdcf::1]:/var/www/dev.christophfink.com/htdocs-secure/"
declare REMOTE_PRODUCTION="christoph@[fdcf::1]:/var/www/christophfink.com/htdocs-secure/"

declare REMOTE="${REMOTE_DEVELOPMENT}"

if [[ "${1-}" == "--production" ]]; then
    echo "Upload to production requested"
    read -r -p "Proceed? [y/N] " response
    response=${response,,}    # tolower
    if [[ "$response" =~ ^(yes|y)$ ]]; then
        REMOTE="${REMOTE_PRODUCTION}"
    fi
fi

if [[ "${1-}" == "--build-only" ]]; then
    REMOTE=""
fi

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
if [[ ! -z "$REMOTE" ]]; then
    rsync \
        --archive \
        --info=progress2 \
        --exclude="blog" \
        --exclude="urbanage-ttm-ui" \
        --exclude="urbanage-ttm" \
        --exclude=".well-known" \
        --delete \
        "${BUILD}" \
        "${REMOTE}"
fi
