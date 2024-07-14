FROM snowdreamtech/build-essential:3.20.0 AS builder

ENV LIBPAM_PWDFILE_VERSION 1.0

RUN mkdir /workspace
WORKDIR /workspace
RUN apk add --no-cache linux-pam-dev  \ 
    && wget https://github.com/tiwe-de/libpam-pwdfile/archive/refs/tags/v${LIBPAM_PWDFILE_VERSION}.tar.gz  \ 
    && tar zxvf v${LIBPAM_PWDFILE_VERSION}.tar.gz  \ 
    && cd libpam-pwdfile-${LIBPAM_PWDFILE_VERSION}  \ 
    && make \
    && cp pam_pwdfile.so ../


FROM snowdreamtech/alpine:3.20.0

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV FTP_ROOT_PASSWORD= \
    FTP_USER= \
    FTP_PASS= \
    FTP_MODE= \
    PASV_ADDRESS= \
    PASV_MIN_PORT= \
    PASV_MAX_PORT=

RUN apk add --no-cache vsftpd=3.0.5-r2 \
    openssl

COPY --from=builder /workspace/pam_pwdfile.so /lib/security/

EXPOSE 21 20

COPY pam.d/* /etc/pam.d/

COPY vsftpd/* /etc/vsftpd/

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]