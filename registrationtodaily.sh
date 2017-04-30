#!/bin/bash

THIS_DIR=$(cd $(dirname $0);pwd)
SCRIPT="clamscanrunner"
SRC=${THIS_DIR}/${SCRIPT}

TARGET_DIR="/etc/cron.daily"
DEST=${TARGET_DIR}/${SCRIPT}

#コピー先に既にある場合は上書きする。
cp -f ${SRC} ${TARGET_DIR}

#root:rootかつ644に変更。
chown root:root ${DEST}
chmod 755 ${DEST}

ls -l ${TARGET_DIR}
