#!/bin/bash

#ロックファイルを消去するコマンドを入れる。
#毎日1回、全域のスキャンを行い、感染したファイルを削除するように設定する。

source ./pathes

#ロックファイル消去設定
#root:rootかつ644に変更。
chown root:root "${ROCKFILE_ERASER_SRC}"
chmod 755 "${ROCKFILE_ERASER_SRC}"
cp -pf "${ROCKFILE_ERASER_SRC}" "${ROCKFILE_ERASER_SCRIPT_DEST}"
echo "@reboot sleep 60 && ${ROCKFILE_ERASER_SCRIPT_DEST} ${SCRIPT}" >"${ROCKFILE_ERASER_DEST}"
chown root:root "${ROCKFILE_ERASER_DEST}"
chmod 644 "${ROCKFILE_ERASER_DEST}"

#root:rootかつ755変更。
chown root:root ${SCRIPT_SRC}
chmod 755 ${SCRIPT_SRC}

#コピー先に既にある場合は上書きする。
cp -pf ${SCRIPT_SRC} ${DAILY_TARGET_DIR}

ls -l "${DAILY_DEST}" "${ROCKFILE_ERASER_SCRIPT_DEST}" "${ROCKFILE_ERASER_DEST}"
