#!/bin/bash

#rootのcrontabに起動設定を書くなどして、rootで動くようにしないとログが残らない。

PATH=/usr/bin:/bin

LOGDIR=/var/log/clamav-scan-log/

LOGFILE=${LOGDIR}`date +%Y%m%d%H%M%S`.log

if [ ! -e ${LOGDIR} ]; then
`mkdir ${LOGDIR}`
fi

touch ${LOGFILE}

# #今の時間(何時?)
# NowHour=`date +%k`
# #割る数
# Dev=4
# mod=$(( ${NowHour} % ${Dev} ))
# #割る数で割り切れない時間なら起動しない。
# if [ ! "0" -eq ${mod} ]; then  
#   echo ${NowHour} " は、" ${Dev}"で割り切れる時間ではありません。">> ${LogFile}
#   exit 1
# fi


#多重起動防止機講
# 同じ名前のプロセスが起動していたら起動しない。
_lockfile="/tmp/`basename $0`.lock"
ln -s /dummy $_lockfile 2> /dev/null || { echo 'Cannot run multiple instance.'  >>${LOGFILE}; exit 9; }
trap "rm $_lockfile; exit" 1 2 3 15


# ファイル更新日時が10日を越えたログファイルを削除
PARAM_DATE_NUM=10
find ${LOGDIR} -name "*.log" -type f -mtime +${PARAM_DATE_NUM} -exec rm -f {} \;

# DB update
# CentOS(epelからインストール)の場合、freshclamのインストール時に、3時間ごとの自動更新が登録されるのであまり意味が無いが、念のため。
freshclam >> ${LOGFILE} 2>&1

# virus scan
#感染したファイルのみログに記載する。
clamscan / -r --infected --remove --exclude-dir='/sys|/proc' >> ${LOGFILE} 2>&1

#ログファイルの内容を表示
cat ${LOGFILE}

#ログファイルの読み込みは全員可能にする。
chmod o+r ${LOGFILE}

rm $_lockfile