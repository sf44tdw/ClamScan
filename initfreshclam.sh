FRESHCLAM_CONFIG_FILE_NAME="/etc/freshclam.conf"

cp -a ${FRESHCLAM_CONFIG_FILE_NAME}{,.$(date +%Y%m%d%H%M%S).bak} || exit 1
sed -i '/^Example/s/^/#/' ${FRESHCLAM_CONFIG_FILE_NAME}
sed -i 's/^#NotifyClamd \/path\/to\/clamd.conf/NotifyClamd \/etc\/clamd.d\/scan.conf/g' ${FRESHCLAM_CONFIG_FILE_NAME}
freshclam
