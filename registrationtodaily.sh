#!/bin/bash

#毎日1回、全域のスキャンを行い、感染したファイルを削除するように設定する。

THIS_DIR=$(cd $(dirname $0);pwd)
SCRIPT="clamscanrunner"
SRC=${THIS_DIR}/${SCRIPT}

TARGET_DIR="/etc/cron.daily"
DEST=${TARGET_DIR}/${SCRIPT}

#root:rootかつ644に変更。
chown root:root ${SRC}
chmod 755 ${SRC}

#コピー先に既にある場合は上書きする。
cp -pf ${SRC} ${TARGET_DIR}

ls -l ${TARGET_DIR}
