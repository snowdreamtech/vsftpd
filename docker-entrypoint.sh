#!/bin/sh
set -e

# change the password for root
echo "root:$FTP_ROOT_PASSWORD" | chpasswd > /dev/null 2>&1

# start vsftpd
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

# wait
wait