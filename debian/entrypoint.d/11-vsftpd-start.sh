#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [vsftpd] Starting vsftpd..."; fi

# start vsftpd
/usr/sbin/vsftpd "$FTP_CONFIG_PATH"

if [ "$DEBUG" = "true" ]; then echo "→ [vsftpd] Vsftpd started."; fi
