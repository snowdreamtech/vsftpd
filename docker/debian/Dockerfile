# Base Image (Debian Variant)
# Extends snowdreamtech/debian with additional tooling and configuration.

FROM ghcr.io/snowdreamtech/debian:13.6.0 AS builder

USER root
WORKDIR /root

RUN apt-get update -qqy \
    && apt-get install -qqy --no-install-recommends \
    build-essential \
    libpam0g-dev \
    git \
    && git clone https://git.tiwe.de/libpam-pwdfile.git \
    && cd libpam-pwdfile \
    && make \
    && cp pam_pwdfile.so /root

FROM ghcr.io/snowdreamtech/debian:13.6.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    DEBIAN_FRONTEND=noninteractive \
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
    VSFTPD_VERSION=3.0.5-0.2

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Vsftpd Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for Vsftpd on Debian. (amd64, arm32v7, arm64, ppc64le, riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/vsftpd" \
    org.opencontainers.image.base.name="snowdreamtech/debian:13.6.0" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/vsftpd" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="${VERSION}" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/vsftpd"

# Runtime Environment Configuration
ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND} \
    KEEPALIVE=${KEEPALIVE} \
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
    && DEBIAN_FRONTEND=noninteractive apt-get update -qqy \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qqy --no-install-recommends \
    vim \
    vsftpd=${VSFTPD_VERSION} \
    && apt-get autoremove -qqy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY pam.d/* /etc/pam.d/
COPY vsftpd/* /etc/vsftpd/
COPY --from=builder /root/pam_pwdfile.so /lib/security/

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
