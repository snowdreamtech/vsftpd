#!/bin/sh
set -e

FTP_CONFIG_PATH=/etc/vsftpd/vsftpd.conf

if [ -n "$FTP_MODE" ]; then
    if [ "$FTP_MODE" == "anonymous" ]; then
        FTP_CONFIG_PATH=/etc/vsftpd/vsftpd_anonymous.conf
    elif [ "$FTP_MODE" == "user" ]; then
        FTP_CONFIG_PATH=/etc/vsftpd/vsftpd_user.conf
    elif [ "$FTP_MODE" == "virtual" ]; then
        FTP_CONFIG_PATH=/etc/vsftpd/vsftpd_virtual.conf
    else
        FTP_CONFIG_PATH=/etc/vsftpd/vsftpd.conf
    fi
else
    FTP_CONFIG_PATH=/etc/vsftpd/vsftpd.conf
fi

# change the password for root
if [ -n "$FTP_ROOT_PASSWORD" ]; then
    echo "root:$FTP_ROOT_PASSWORD" | chpasswd >/dev/null 2>&1
fi

# adduser for vsftp
if [ -n "$FTP_USER" ] && [ -n "$FTP_PASS" ]; then
    if id -u $FTP_USER >/dev/null 2>&1 ; then
        echo "$FTP_USER:$FTP_PASS" | chpasswd >/dev/null 2>&1
    else
        echo -e "$FTP_PASS\n$FTP_PASS" | adduser -h /home/$FTP_USER -s /sbin/nologin $FTP_USER
    fi
fi

# passive
# pasv_address
if [ -n "$PASV_ADDRESS" ]; then
    sed -i "/pasv_address/d" $FTP_CONFIG_PATH
    echo -e "\npasv_address=$PASV_ADDRESS" >>$FTP_CONFIG_PATH
fi

# pasv_min_port
if [ -n "$PASV_MIN_PORT" ]; then
    sed -i "/pasv_min_port/d" $FTP_CONFIG_PATH
    echo -e "\npasv_min_port=$PASV_MIN_PORT" >>$FTP_CONFIG_PATH
fi

# pasv_max_port
if [ -n "$PASV_MAX_PORT" ]; then
    sed -i "/pasv_max_port/d" $FTP_CONFIG_PATH
    echo -e "\npasv_max_port=$PASV_MAX_PORT" >>$FTP_CONFIG_PATH
fi

# start vsftpd
/usr/sbin/vsftpd $FTP_CONFIG_PATH

# wait
wait
