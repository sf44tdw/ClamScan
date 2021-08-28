clamdscan /

setsebool -P antivirus_can_scan_system on

cd /tmp
ausearch -c 'clamd' --raw | audit2allow -M my-clamd
semodule -X 300 -i my-clamd.pp


