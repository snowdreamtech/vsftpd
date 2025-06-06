FROM snowdreamtech/build-essential:3.21.3-alpine3.21 AS builder

# Switch to the user
USER root

# Set the workdir
WORKDIR /root

ENV LIBPAM_PWDFILE_VERSION 1.0

RUN apk add --no-cache linux-pam-dev  \ 
    && wget https://github.com/tiwe-de/libpam-pwdfile/archive/refs/tags/v${LIBPAM_PWDFILE_VERSION}.tar.gz  \ 
    && tar zxvf v${LIBPAM_PWDFILE_VERSION}.tar.gz  \ 
    && cd libpam-pwdfile-${LIBPAM_PWDFILE_VERSION}  \ 
    && make \
    && cp pam_pwdfile.so /root


    
FROM snowdreamtech/alpine:3.21.3

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Vsftpd Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Vsftpd on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/vsftpd" \
    org.opencontainers.image.base.name="snowdreamtech/vsftpd:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/vsftpd" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="3.21.0" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/vsftpd"

# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ENV KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0 

ENV VSFTPD_VERSION=3.0.5-r2 \
    FTP_ROOT_PASSWORD= \
    FTP_USER= \
    FTP_PASS= \
    FTP_MODE= \
    PASV_ADDRESS= \
    PASV_MIN_PORT= \
    PASV_MAX_PORT=

ARG GID=1000 \
    UID=1000  \
    USER=root \
    WORKDIR=/root

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h /home/${USER} -u ${UID} -g ${USER} -G ${USER} -s /bin/sh -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

# Enable CAP_NET_BIND_SERVICE
RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    apk add --no-cache libcap; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi

COPY --chown=${USER}:${USER} pam.d/* /etc/pam.d/

COPY --chown=${USER}:${USER} vsftpd/* /etc/vsftpd/
    
RUN apk add --no-cache \
    vsftpd=${VSFTPD_VERSION}

COPY --chown=${USER}:${USER} --from=builder /root/pam_pwdfile.so /lib/security/

# Switch to the user
USER ${USER}

# Set the workdir
WORKDIR ${WORKDIR}

EXPOSE 21 20

COPY --chown=${USER}:${USER} docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]