# vsftpd

[![CI Pipeline](https://img.shields.io/github/actions/workflow/status/snowdreamtech/vsftpd/ci.yml?branch=main&label=CI%20Pipeline)](https://github.com/snowdreamtech/vsftpd/actions/workflows/ci.yml)
[![CD Pipeline](https://img.shields.io/github/actions/workflow/status/snowdreamtech/vsftpd/cd.yml?branch=main&label=CD%20Pipeline)](https://github.com/snowdreamtech/vsftpd/actions/workflows/cd.yml)
[![CodeQL](https://img.shields.io/github/actions/workflow/status/snowdreamtech/vsftpd/codeql.yml?branch=main&label=CodeQL&logo=github)](https://github.com/snowdreamtech/vsftpd/actions/workflows/codeql.yml)
[![Security Audit](https://img.shields.io/badge/Security-Zizmor%20%7C%20Trivy%20%7C%20Gitleaks-brightgreen)](https://github.com/snowdreamtech/vsftpd/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/license/MIT)
![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/vsftpd)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/vsftpd/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/vsftpd)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/vsftpd)

[English](README.md) | [简体中文](README_zh-CN.md)

Docker image for vsftpd providing standardized container foundations with flexible entrypoint systems, multi-architecture support, and consistent configuration patterns across Alpine, Debian, and Rocky Linux distributions.

## Overview

The vsftpd container provides:

- **Standardized Dockerfiles** with OCI annotations and best practices
- **Flexible entrypoint system** supporting custom initialization scripts
- **Consistent environment variable configuration** across all variants
- **Multi-architecture support** for diverse hardware platforms
- **User/group management** with PUID/PGID support for permission handling
- **Three distribution variants**: Alpine (lightweight), Debian (default/widely-compatible), Rocky (enterprise)

## Quick Start

```bash
# Pull and run the default Debian variant
docker pull snowdreamtech/vsftpd:debian
docker run -d --name=vsftpd -p 20:20 -p 21:21 -e TZ=Asia/Shanghai snowdreamtech/vsftpd:debian

# Or use docker compose
docker compose up -d
```

## Distribution Variants

### Debian (Default)

The recommended variant for most use cases, providing wide compatibility and extensive package availability.

```bash
docker run -d \
  --name=vsftpd \
  -p 20:20 \
  -p 21:21 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/vsftpd:debian
```

**Supported Architectures**: amd64, arm32v7, arm64, ppc64le, riscv64, s390x

**Base Image**: `snowdreamtech/debian:13.6.0`

### Alpine

Lightweight variant optimized for minimal image size and fast startup times.

```bash
docker run -d \
  --name=vsftpd \
  -p 20:20 \
  -p 21:21 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/vsftpd:alpine
```

**Supported Architectures**: 386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x

**Base Image**: `snowdreamtech/alpine:3.24.1`

### Rocky

Enterprise-focused variant based on Rocky Linux, ideal for production environments requiring RHEL compatibility.

```bash
docker run -d \
  --name=vsftpd \
  -p 20:20 \
  -p 21:21 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/vsftpd:rocky
```

**Supported Architectures**: amd64, arm64, ppc64le, s390x

**Base Image**: `snowdreamtech/rocky:10.2.0`

## Build Instructions

### Single Architecture Build

```bash
# Build Debian variant
docker build -t snowdreamtech/vsftpd:debian ./docker/debian/

# Build Alpine variant
docker build -t snowdreamtech/vsftpd:alpine ./docker/alpine/

# Build Rocky variant
docker build -t snowdreamtech/vsftpd:rocky ./docker/rocky/
```

### Multi-Architecture Build

Build images for multiple architectures using `docker buildx`:

```bash
# Create and use a buildx builder
docker buildx create --use --name build --node build --driver-opt network=host

# Build Debian for multiple architectures
docker buildx build \
  --platform=linux/amd64,linux/arm/v7,linux/arm64,linux/riscv64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/vsftpd:debian \
  ./docker/debian/ \
  --push

# Build Alpine for multiple architectures
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/vsftpd:alpine \
  ./docker/alpine/ \
  --push

# Build Rocky for multiple architectures
docker buildx build \
  --platform=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/vsftpd:rocky \
  ./docker/rocky/ \
  --push
```

## Environment Variables

All variants support the following environment variables for runtime configuration:

| Variable | Default | Description |
|----------|---------|-------------|
| `KEEPALIVE` | `1` | Keep container running (1=enabled, 0=disabled) |
| `CAP_NET_BIND_SERVICE` | `0` | Enable binding to privileged ports (<1024) |
| `LANG` | `C.UTF-8` | Locale setting for UTF-8 character support |
| `UMASK` | `022` | Default file creation mask |
| `DEBUG` | `false` | Enable debug output in entrypoint scripts |
| `PGID` | `0` | Primary group ID for custom user creation |
| `PUID` | `0` | User ID for custom user creation |
| `USER` | `root` | Username for custom user creation |
| `WORKDIR` | `/root` | Working directory path |
| `TZ` | - | Timezone (e.g., `Asia/Shanghai`, `America/New_York`) |
| `FTP_ROOT_PWD` | - | Password for root FTP user |
| `FTP_USER` | - | Username for custom FTP user |
| `FTP_PASS` | - | Password for custom FTP user |
| `FTP_MODE` | - | FTP running mode (`anonymous`, `user`, or `virtual`) |
| `PASV_ADDRESS` | - | Public/external IP address for passive mode |
| `PASV_MIN_PORT` | - | Minimum port for passive mode |
| `PASV_MAX_PORT` | - | Maximum port for passive mode |

**Debian-specific**:

| Variable | Default | Description |
|----------|---------|-------------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian package installation mode |

### Custom User Creation

Create a non-root user with specific UID/GID at build time:

```bash
docker build \
  --build-arg PUID=1000 \
  --build-arg PGID=1000 \
  --build-arg USER=appuser \
  -t snowdreamtech/vsftpd:debian-custom \
  ./docker/debian/
```

Or at runtime:

```bash
docker run -d \
  --name=vsftpd \
  -e PUID=1000 \
  -e PGID=1000 \
  -e USER=appuser \
  snowdreamtech/vsftpd:debian
```

**Note**: User creation only occurs when `PUID≠0`, `PGID≠0`, and `USER≠root`.

## Docker Compose Examples

### Simple Configuration

```yaml
services:
  vsftpd:
    image: snowdreamtech/vsftpd:debian
    container_name: vsftpd
    ports:
      - "20:20"
      - "21:21"
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped
```

### Advanced Configuration

```yaml
services:
  vsftpd:
    image: snowdreamtech/vsftpd:debian
    container_name: vsftpd
    ports:
      - "20:20"
      - "21:21"
      - "21100-21110:21100-21110"
    environment:
      - TZ=Asia/Shanghai
      - DEBUG=true
      - KEEPALIVE=1
      - FTP_USER=ftpuser
      - FTP_PASS=ftp_secret_password
      - FTP_MODE=user
      - PASV_ADDRESS=127.0.0.1
      - PASV_MIN_PORT=21100
      - PASV_MAX_PORT=21110
    volumes:
      - /path/to/data:/home/ftpuser
    restart: unless-stopped
```

## Semantic Versioning Tags

Images follow semantic versioning with the format: `{major}.{minor}.{patch}-{variant}`

Examples:

- `snowdreamtech/vsftpd:3.0.5-debian`
- `snowdreamtech/vsftpd:3.0.5-alpine`
- `snowdreamtech/vsftpd:3.0.5-rocky`

This format allows:

- **Full version pinning**: `<version>-debian` (exact version)
- **Variant latest tag**: `latest-debian` (tracks most recent release for Debian)
- **Global latest tag**: `latest` (tracks most recent release, defaults to Debian)

## Architecture Support

Each distribution variant supports multiple CPU architectures for deployment across diverse hardware platforms:

| Variant | Architectures |
|---------|---------------|
| **Debian** | amd64, arm32v7, arm64, ppc64le, riscv64, s390x |
| **Alpine** | 386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x |
| **Rocky** | amd64, arm64, ppc64le, s390x |

Docker automatically selects the appropriate architecture for your platform when pulling images.

## Entrypoint System

The base template includes a flexible entrypoint system that executes custom initialization scripts before starting your application.

### How It Works

1. The `docker-entrypoint.sh` script runs at container startup
2. It executes all executable scripts in `/usr/local/bin/entrypoint.d/` in lexical order
3. Each script receives the container's command-line arguments
4. If any script fails, the container stops (fail-fast behavior)

### Adding Custom Initialization

Create custom initialization scripts in your derived Dockerfile:

```dockerfile
FROM snowdreamtech/vsftpd:debian

# Add your custom initialization script
COPY my-init.sh /usr/local/bin/entrypoint.d/20-my-init.sh
RUN chmod +x /usr/local/bin/entrypoint.d/20-my-init.sh

# Your application setup
COPY app /app
CMD ["/app/start.sh"]
```

### Debug Mode

Enable debug output to troubleshoot entrypoint execution:

```bash
docker run -e DEBUG=true snowdreamtech/vsftpd:debian
```

## Contact (备注：vsftpd)

* Email: <sn0wdr1am@qq.com>
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## License

MIT
