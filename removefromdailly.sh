#!/bin/bash

SCRIPT="clamscan"
TARGET_DIR="/etc/cron.daily"
DEST="${TARGET_DIR}/${SCRIPT}"

rm -f ${DEST}

ls -l ${TARGET_DIR}
