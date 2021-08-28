#!/bin/bash
#ClamAVによるリアルタイムスキャンでウイルス検出時に実行するスクリプト

LOGDIR="/var/log/clamav-scan-log"
REALTIME_SCAN_LOG="${LOGDIR}/realtime.`date +%Y%m%d%H%M%S`.$$.log"

# メッセージの生成
MESSAGE="Virus Found: $CLAM_VIRUSEVENT_VIRUSNAME in $CLAM_VIRUSEVENT_FILENAME"
echo "${MESSAGE}" > "${REALTIME_SCAN_LOG}"


