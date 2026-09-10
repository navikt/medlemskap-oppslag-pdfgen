#!/bin/bash

CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PDFGENRS_IMAGE="$(grep '^FROM ' "$CURRENT_PATH/Dockerfile" | head -n 1 | awk '{print $2}')"
PDFGENRS_PLATFORM="${PDFGENRS_PLATFORM:-linux/amd64}"

run_container() {
    docker run \
        --platform "$PDFGENRS_PLATFORM" \
        -v "$CURRENT_PATH/templates:/app/templates" \
        -v "$CURRENT_PATH/data:/app/data" \
        -v "$CURRENT_PATH/fonts:/app/fonts" \
        -v "$CURRENT_PATH/resources:/app/resources" \
        -p 8080:8080 \
        -e DEV_MODE=true \
        --rm \
        "$PDFGENRS_IMAGE" &
    CONTAINER_PID=$!
}

get_hash() {
    if command -v md5sum >/dev/null 2>&1; then
        find "$CURRENT_PATH/templates" "$CURRENT_PATH/data" "$CURRENT_PATH/fonts" "$CURRENT_PATH/resources" \
            -type f -exec md5sum {} \; 2>/dev/null | sort | md5sum
    elif command -v md5 >/dev/null 2>&1; then
        find "$CURRENT_PATH/templates" "$CURRENT_PATH/data" "$CURRENT_PATH/fonts" "$CURRENT_PATH/resources" \
            -type f -exec md5 -r {} \; 2>/dev/null | sort | md5 -q
    else
        echo "Missing hash tool: install md5sum (coreutils) or use a shell with md5" >&2
        return 1
    fi
}

trap 'kill $CONTAINER_PID 2>/dev/null; exit' INT TERM

docker pull "$PDFGENRS_IMAGE"
run_container
LAST_HASH=$(get_hash)

while true; do
    sleep 1
    CURRENT_HASH=$(get_hash)
    if [ "$CURRENT_HASH" != "$LAST_HASH" ]; then
        echo "File change detected, restarting..."
        kill $CONTAINER_PID 2>/dev/null
        wait $CONTAINER_PID 2>/dev/null
        run_container
        LAST_HASH=$CURRENT_HASH
    fi
done
