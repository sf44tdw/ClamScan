# ClamScan
# clamavを使用したスキャン用スクリプト

yum -y install bzip2-devel

#リアルタイムスキャンを使いたい場合のみ。
yum -y install clamav clamd clamav-update

#リアルタイムスキャンを使いたい場合のみ。
#/usr/lib/systemd/system/clamd@.serviceの[Service]に以下を追記する。
#CPUQuota=50%

#リアルタイムスキャンを使いたい場合のみ。
systemctl daemon-reload


#リアルタイムスキャン不要な場合のみ。
yum -y install clamav clamav-update

#共通
cd && git clone https://github.com/sf44tdw/ClamScanRunner.git
cd ClamScanRunner
./initfreshclam.sh
./clamscan_allow_selinux.sh
./registrationtodaily.sh
echo '/dev/' > /etc/clamscan.exclude
echo '/proc/' >> /etc/clamscan.exclude
echo '/sys/' >> /etc/clamscan.exclude
chmod 644 /etc/clamscan.exclude

#リアルタイムスキャンを使いたい場合のみ。
./initclamd.sh

sesearch -b antivirus_can_scan_system -AC

#リアルタイムスキャンを使いたい場合のみ。
./clamscand_allow_selinux.sh
#リアルタイムスキャンを使いたい場合のみ。
./setrealtimescan.sh


#スキャン結果ディレクトリを必要なユーザのホームにリンク。
./clamscanrunner
#ここで必要なユーザに遷移
cd ~/ && ln -s /var/log/clamav-scan-log
