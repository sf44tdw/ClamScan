# ClamScan
# clamavを使用したスキャン用スクリプト

yum -y install bzip2-devel

yum -y install clamav clamd clamav-update

cd && git clone https://github.com/sf44tdw/ClamScanRunner.git

cd ClamScanRunner


#/usr/lib/systemd/system/clamd@.serviceの[Service]に以下を追記する。
#CPUQuota=50%

systemctl daemon-reload

./initclamd.sh

./registrationtodaily.sh

echo '/dev' > /etc/clamscan.exclude
echo '/proc' >> /etc/clamscan.exclude
echo '/sys' >> /etc/clamscan.exclude
chmod 644 /etc/clamscan.exclude

sesearch -b antivirus_can_scan_system -AC

./allowselinux.sh

./setrealtimescan.sh

