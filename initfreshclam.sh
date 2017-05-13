cp -a /etc/freshclam.conf{,.`date +%Y%m%d%H%M%S`.bak}
sed -i '/^Example/s/^/#/' /etc/freshclam.conf
freshclam
