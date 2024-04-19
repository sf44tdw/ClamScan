# ClamScan
# clamavを使用したスキャン用スクリプト

1.アーカイブファイルスキャン前提パッケージインストール。
```
yum -y install bzip2-devel
```

2.リアルタイムスキャンを使いたい場合のみ。
```
yum -y install clamav clamd clamav-update

#/usr/lib/systemd/system/clamd@.serviceの[Service]に以下を追記する。
#CPUQuota=50%

systemctl daemon-reload
```

3.リアルタイムスキャン不要な場合のみ。
```
yum -y install clamav clamav-update
```

4.共通
```
cd && git clone https://github.com/sf44tdw/ClamScanRunner.git
cd ClamScanRunner
./initfreshclam.sh
./clamscan_allow_selinux.sh
./registrationtodaily.sh
echo '/dev/' > /etc/clamscan.exclude
echo '/proc/' >> /etc/clamscan.exclude
echo '/sys/' >> /etc/clamscan.exclude
chmod 644 /etc/clamscan.exclude
```

5.共通
```
sesearch -b antivirus_can_scan_system -AC
mkdir -m 644 -p /var/clamav-isolate-file 
semanage fcontext -a -t antivirus_tmp_t '/var/clamav-isolate-file/'
restorecon -v '/var/clamav-isolate-file/'
```

6.リアルタイムスキャンを使いたい場合のみ。
```
./clamscand_allow_selinux.sh
./setrealtimescan.sh
```
