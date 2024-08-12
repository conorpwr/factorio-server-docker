#!/bin/bash
set -euxo pipefail

SAVE_GAME="/opt/factorio-data/game.zip"

if [ ! -f ${SAVE_GAME} ]; then
        echo "Creating new save"
        /opt/factorio/bin/x64/factorio --create ${SAVE_GAME}
fi

echo "Starting factorio using ${SAVE_GAME}"

/opt/factorio/bin/x64/factorio --start-server ${SAVE_GAME}
