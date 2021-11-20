#!/bin/bash

#起動時にロックファイルを消去する設定を入れる。
#毎日1回、全域のスキャンを行い、感染したファイルを削除するように設定する。

source ./pathes

#ロックファイル消去設定
echo '@reboot rm -f /tmp/clamscanrunner*' > "${ROCKFILE_ERASER_DEST}"

#root:rootかつ644に変更。
chown root:root ${SCRIPT_SRC}
chmod 755 ${SCRIPT_SRC}

#コピー先に既にある場合は上書きする。
cp -pf ${SCRIPT_SRC} ${DAILY_TARGET_DIR}

ls -l ${DAILY_DEST}


