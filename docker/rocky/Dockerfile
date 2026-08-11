# Base Image (Rocky Variant)
# Extends snowdreamtech/rocky with additional tooling and configuration.

FROM ghcr.io/snowdreamtech/rocky:10.2.0 AS builder

USER root
WORKDIR /root

RUN dnf makecache \
    && dnf -y install \
    make \
    gcc \
    pam-devel \
    git \
    && git clone https://git.tiwe.de/libpam-pwdfile.git \
    && cd libpam-pwdfile \
    && make \
    && cp pam_pwdfile.so /root

FROM ghcr.io/snowdreamtech/rocky:10.2.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    KEEPALIVE=1 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root \
    VSFTPD_VERSION=3.0.5

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Vsftpd Image Based On Rocky" \
    org.opencontainers.image.description="Docker Images for Vsftpd on Rocky. (amd64, arm64, ppc64le, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/vsftpd" \
    org.opencontainers.image.base.name="snowdreamtech/rocky:10.2.0" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/vsftpd" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="${VERSION}" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/vsftpd"

# Runtime Environment Configuration
ENV KEEPALIVE=${KEEPALIVE} \
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PASSWORDLESS_SUDO=${PASSWORDLESS_SUDO} \
    PGID=${PGID} \
    PUID=${PUID} \
    USER=${USER} \
    WORKDIR=${WORKDIR} \
    VSFTPD_VERSION=${VSFTPD_VERSION} \
    FTP_ROOT_PWD= \
    FTP_USER= \
    FTP_PASS= \
    FTP_MODE= \
    PASV_ADDRESS= \
    PASV_MIN_PORT= \
    PASV_MAX_PORT=

# Additional tooling and configuration for Base image
RUN set -eux \
    && dnf install -y \
    vim \
    vsftpd-${VSFTPD_VERSION} \
    && dnf clean all \
    && rm -rf /var/cache/dnf/*

COPY pam.d/* /etc/pam.d/
COPY vsftpd/* /etc/vsftpd/
COPY --from=builder /root/pam_pwdfile.so /lib64/security/

# Container Orchestration Files
COPY entrypoint.d /usr/local/bin/entrypoint.d

RUN chmod +x /usr/local/bin/entrypoint.d/*

EXPOSE 21 20

# Standard Healthcheck (Verification of core system responsiveness)
HEALTHCHECK NONE

# Process Execution
USER root
WORKDIR /root
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
