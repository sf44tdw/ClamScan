# ClamScan
clamavを使用したスキャン用スクリプト

yum -y install bzip2-devel
yum -y --enablerepo=epel install clamav clamd clamav-update

cd && git clone https://github.com/sf44tdw/ClamScanRunner.git
cd ClamScanRunner

./initclamd.sh

./registrationtodaily.sh

sesearch -b antivirus_can_scan_system -AC

./allowselinux.sh

./setrealtimescan.sh



