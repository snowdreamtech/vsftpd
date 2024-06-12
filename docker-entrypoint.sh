#!/bin/sh
set -e

# change the password for root
if [ -n "$FTP_ROOT_PASSWORD" ]; then
    echo "root:$FTP_ROOT_PASSWORD" | chpasswd > /dev/null 2>&1
fi

# passive
# pasv_address
if [ -n "$PASV_ADDRESS" ]; then
    sed -i "/pasv_address/d" /etc/vsftpd/vsftpd.conf
    echo -e "\npasv_address=$PASV_ADDRESS" >> /etc/vsftpd/vsftpd.conf
fi

# pasv_min_port
if [ -n "$PASV_MIN_PORT" ]; then
    sed -i "/pasv_min_port/d" /etc/vsftpd/vsftpd.conf
    echo -e "\npasv_min_port=$PASV_MIN_PORT" >> /etc/vsftpd/vsftpd.conf
fi

# pasv_max_port
if [ -n "$PASV_MAX_PORT" ]; then
    sed -i "/pasv_max_port/d" /etc/vsftpd/vsftpd.conf
    echo -e "\npasv_max_port=$PASV_MAX_PORT" >> /etc/vsftpd/vsftpd.conf
fi

# start vsftpd
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

# wait
wait