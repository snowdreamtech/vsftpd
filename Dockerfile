FROM snowdreamtech/alpine:3.20.0

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV FTP_ROOT_PASSWORD=

RUN apk add --no-cache vsftpd

EXPOSE 21

COPY vsftpd.conf /etc/vsftpd/

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]