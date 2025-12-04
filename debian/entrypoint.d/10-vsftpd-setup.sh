#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [vsftpd] Setting up vsftpd..."; fi


FTP_CONFIG_PATH=/etc/vsftpd/vsftpd.conf
FTP_PASSWD_PATH=/etc/vsftpd/.passwd
FTP_VIRTUAL_HOME=/home/virtual

if [ -n "$FTP_MODE" ]; then
    if [ "$FTP_MODE" == "anonymous" ]; then
        FTP_CONFIG_PATH=/etc/vsftpd/vsftpd_anonymous.conf
    elif [ "$FTP_MODE" == "user" ]; then
        FTP_CONFIG_PATH=/etc/vsftpd/vsftpd_user.conf

        # adduser for vsftp
        if [ -n "$FTP_USER" ] && [ -n "$FTP_PASS" ]; then
            if id -u $FTP_USER >/dev/null 2>&1; then
                echo "$FTP_USER:$FTP_PASS" | chpasswd >/dev/null 2>&1
            else
                echo -e "$FTP_PASS\n$FTP_PASS" | adduser -h /home/$FTP_USER -s /sbin/nologin $FTP_USER >/dev/null 2>&1
            fi
        fi
    elif [ "$FTP_MODE" == "virtual" ]; then
        FTP_CONFIG_PATH=/etc/vsftpd/vsftpd_virtual.conf

        # adduser for virtual
        if ! id -u "virtual" >/dev/null 2>&1; then
            adduser -D -h $FTP_VIRTUAL_HOME -s /sbin/nologin virtual >/dev/null 2>&1
        fi

        # change the password for root
        if [ -n "$FTP_ROOT_PWD" ]; then
            sed -i "/^root:/d" $FTP_PASSWD_PATH
            HASHED_FTP_ROOT_PWD=$(echo -e "$FTP_ROOT_PWD" | openssl passwd -1 -stdin)
            echo "root:$HASHED_FTP_ROOT_PWD" >>$FTP_PASSWD_PATH

            if [ ! -d $FTP_VIRTUAL_HOME/root ]; then
                mkdir -p $FTP_VIRTUAL_HOME/root
                chown -R virtual:virtual $FTP_VIRTUAL_HOME/root
            fi
        fi

        # adduser for vsftp
        if [ -n "$FTP_USER" ] && [ -n "$FTP_PASS" ]; then
            sed -i "/^$FTP_USER:/d" $FTP_PASSWD_PATH
            HASHED_FTP_USER_PASSWORD=$(echo -e "$FTP_PASS" | openssl passwd -1 -stdin)
            echo "$FTP_USER:$HASHED_FTP_USER_PASSWORD" >>$FTP_PASSWD_PATH

            if [ ! -d $FTP_VIRTUAL_HOME/$FTP_USER ]; then
                mkdir -p $FTP_VIRTUAL_HOME/$FTP_USER
                chown -R virtual:virtual $FTP_VIRTUAL_HOME/$FTP_USER
            fi
        fi
    else
        FTP_CONFIG_PATH=/etc/vsftpd/vsftpd.conf
    fi
else
    FTP_CONFIG_PATH=/etc/vsftpd/vsftpd.conf
fi

# change the password for root
if [ -n "$FTP_ROOT_PWD" ]; then
    echo "root:$FTP_ROOT_PWD" | chpasswd >/dev/null 2>&1
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

if [ "$DEBUG" = "true" ]; then echo "→ [vsftpd] Vsftpd has been set up."; fi    
