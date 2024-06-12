FROM snowdreamtech/alpine:3.20.0

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV FTP_ROOT_PASSWORD= \
    FTP_USER= \
    FTP_PASS= \
    PASV_ADDRESS= \
    PASV_MIN_PORT= \
    PASV_MAX_PORT=


RUN apk add --no-cache vsftpd

EXPOSE 21 20

COPY vsftpd/* /etc/vsftpd/

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]