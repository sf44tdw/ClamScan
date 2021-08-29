#多重起動防止機講
# 同じ名前のプロセスが起動していたら起動しない。
_lockfile="/tmp/`basename $0`.lock"
ln -s /dummy ${_lockfile} 2> /dev/null || { echo 'Cannot run multiple instance.'; exit 9; }
trap "rm ${_lockfile}; exit" 1 2 3 15

PATH_EXCLISIVE_LOG="/tmp/path_check_failure.`date +%Y%m%d%H%M%S`.$$"

#ウイルス対策ソフトによるスキャンの許可
setsebool -P antivirus_can_scan_system on

#clamdscanのSELinuxのアクセス許可を行う。
#(アクセス違反のログを使うので、1回実行する。)
clamdscan / > "${PATH_EXCLISIVE_LOG}" 2>&1

#clamdが拒否されたもの全許可。
cd /tmp
ausearch -c 'clamd' --raw | audit2allow -M my-clamd
semodule -X 300 -i my-clamd.pp

#File path check failure: Permission denied. ERRORが頻発するパスを列挙する。
#除外したい場合は手動でclamdの除外パスに設定する。

PATH_EXCLISIVE_RECOMMEND="${HOME}/clamd_exclusive_recommend.conf"
echo "" > "${PATH_EXCLISIVE_RECOMMEND}"
sed -e 's/^[^\/].*//g' -e 's/: File path check failure.*$//g' -e 's/^.*FOUND.*$//g' "${PATH_EXCLISIVE_LOG}" | xargs dirname | sort -u > "${PATH_EXCLISIVE_RECOMMEND}"

rm ${_lockfile}
