
#多重起動防止機講
# 同じ名前のプロセスが起動していたら起動しない。
_lockfile="/tmp/`basename $0`.lock"
ln -s /dummy ${_lockfile} 2> /dev/null || { echo 'Cannot run multiple instance.'; exit 9; }
trap "rm ${_lockfile}; exit" 1 2 3 15


CLAMD_CONFIG_FILE_NAME="/etc/clamd.d/scan.conf"
cp -a ${CLAMD_CONFIG_FILE_NAME}{,.`date +%Y%m%d%H%M%S`.bak} || exit 1

#通知用スクリプトを配置する。
chown root:root ./foundvirus.sh
chmod 755 ./foundvirus.sh
cp -pf ./foundvirus.sh /usr/local/bin/

#通知用スクリプトを設定する。
sed -i '/^VirusEvent.*\//d' ${CLAMD_CONFIG_FILE_NAME}
echo '' >> "${CLAMD_CONFIG_FILE_NAME}"
echo 'VirusEvent /usr/local/bin/foundvirus.sh' >> "${CLAMD_CONFIG_FILE_NAME}"

#監視先を設定する。
#監視対象のディレクトリもしくはサブディレクトリでGUIアプリケーション(例:Eclipse)を実行すると非常に大きな負荷がかかる。(CPU使用率がほぼ100%まで行くこともある。)
sed -i '/^OnAccessIncludePath.*\//d' ${CLAMD_CONFIG_FILE_NAME}
echo '' >> "${CLAMD_CONFIG_FILE_NAME}"
echo 'OnAccessIncludePath /home' >> "${CLAMD_CONFIG_FILE_NAME}"
echo 'OnAccessIncludePath /var/cache' >> "${CLAMD_CONFIG_FILE_NAME}"
echo 'OnAccessIncludePath /mnt' >> "${CLAMD_CONFIG_FILE_NAME}"
echo 'OnAccessIncludePath /media' >> "${CLAMD_CONFIG_FILE_NAME}"

sed -i '/^OnAccessExtraScanning.*/d' ${CLAMD_CONFIG_FILE_NAME}
echo '' >> "${CLAMD_CONFIG_FILE_NAME}"
echo 'OnAccessExtraScanning yes' >> "${CLAMD_CONFIG_FILE_NAME}"

#二重検知防止のため、clamdscanはrootプロセスを監視しない。
#監視すると、clamdscanもしくはclamscanコマンドをrootユーザーで実行する際、コマンドによるスキャンにリアルタイムスキャンが反応する?。
sed -i '/^OnAccessExcludeRootUID .*/d' ${CLAMD_CONFIG_FILE_NAME}
echo '' >> "${CLAMD_CONFIG_FILE_NAME}"
echo 'OnAccessExcludeRootUID yes' >> "${CLAMD_CONFIG_FILE_NAME}"

#怪しいファイルへのアクセスを阻害する。
sed -i '/^OnAccessPrevention  .*/d' ${CLAMD_CONFIG_FILE_NAME}
echo '' >> "${CLAMD_CONFIG_FILE_NAME}"
echo 'OnAccessPrevention yes' >> "${CLAMD_CONFIG_FILE_NAME}"

systemctl enable clamd@scan
systemctl restart clamd@scan
systemctl status clamd@scan
systemctl enable clamonacc
systemctl restart clamonacc
systemctl status clamonacc

rm ${_lockfile}

