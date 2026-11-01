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

基于 Alpine、Debian 和 Rocky Linux 构建的标准化 vsftpd 容器镜像，具备灵活的 entrypoint 初始化系统、多架构支持及统一的环境变量配置模式。

## 概述

vsftpd 容器镜像提供：

- **标准化 Dockerfile**，遵循 OCI 规范与最佳实践
- **灵活的 entrypoint 系统**，支持自定义初始化脚本
- **统一的环境变量配置**，跨所有发行版变体保持一致
- **多架构支持**，适配多样化的硬件平台
- **用户/组管理**，支持 PUID/PGID 权限处理
- **三种发行版变体**：Alpine（轻量级）、Debian（默认/高兼容性）、Rocky（企业级）

## 快速上手

```bash
# 拉取并运行默认 Debian 变体
docker pull snowdreamtech/vsftpd:debian
docker run -d --name=vsftpd -p 20:20 -p 21:21 -e TZ=Asia/Shanghai snowdreamtech/vsftpd:debian

# 或使用 docker compose
docker compose up -d
```

## 发行版变体

### Debian（默认）

推荐用于大多数场景，提供广泛的兼容性和丰富的软件包生态。

```bash
docker run -d \
  --name=vsftpd \
  -p 20:20 \
  -p 21:21 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/vsftpd:debian
```

**支持的架构**：amd64, arm32v7, arm64, ppc64le, riscv64, s390x

**基础镜像**：`snowdreamtech/debian:13.6.0`

### Alpine

经过轻量化优化的变体，具有极小的镜像体积和极快的启动速度。

```bash
docker run -d \
  --name=vsftpd \
  -p 20:20 \
  -p 21:21 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/vsftpd:alpine
```

**支持的架构**：386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x

**基础镜像**：`snowdreamtech/alpine:3.24.1`

### Rocky

基于 Rocky Linux 的企业级变体，适合需要 RHEL 生态兼容性的生产环境。

```bash
docker run -d \
  --name=vsftpd \
  -p 20:20 \
  -p 21:21 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/vsftpd:rocky
```

**支持的架构**：amd64, arm64, ppc64le, s390x

**基础镜像**：`snowdreamtech/rocky:10.2.0`

## 构建说明

### 单架构本地构建

```bash
# 构建 Debian 变体
docker build -t snowdreamtech/vsftpd:debian ./docker/debian/

# 构建 Alpine 变体
docker build -t snowdreamtech/vsftpd:alpine ./docker/alpine/

# 构建 Rocky 变体
docker build -t snowdreamtech/vsftpd:rocky ./docker/rocky/
```

### 多架构构建

使用 `docker buildx` 为多种 CPU 架构构建镜像：

```bash
# 创建并启用 buildx 构建器
docker buildx create --use --name build --node build --driver-opt network=host

# 为 Debian 构建多架构镜像
docker buildx build \
  --platform=linux/amd64,linux/arm/v7,linux/arm64,linux/riscv64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/vsftpd:debian \
  ./docker/debian/ \
  --push

# 为 Alpine 构建多架构镜像
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/vsftpd:alpine \
  ./docker/alpine/ \
  --push

# 为 Rocky 构建多架构镜像
docker buildx build \
  --platform=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/vsftpd:rocky \
  ./docker/rocky/ \
  --push
```

## 环境变量

所有发行版变体均支持以下环境变量：

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| `KEEPALIVE` | `1` | 保持容器持续运行（1=启用，0=禁用） |
| `CAP_NET_BIND_SERVICE` | `0` | 允许绑定特权端口（<1024） |
| `LANG` | `C.UTF-8` | 区域语言设置，支持 UTF-8 字符 |
| `UMASK` | `022` | 默认文件创建权限掩码 |
| `DEBUG` | `false` | 启用 entrypoint 脚本的调试日志输出 |
| `PGID` | `0` | 自定义用户的组 ID |
| `PUID` | `0` | 自定义用户的用户 ID |
| `USER` | `root` | 自定义用户的用户名 |
| `WORKDIR` | `/root` | 容器工作目录路径 |
| `TZ` | - | 时区（例如：`Asia/Shanghai`、`America/New_York`） |
| `FTP_ROOT_PWD` | - | FTP root 用户的密码 |
| `FTP_USER` | - | 自定义 FTP 用户名 |
| `FTP_PASS` | - | 自定义 FTP 用户密码 |
| `FTP_MODE` | - | FTP 运行模式（`anonymous`、`user` 或 `virtual`） |
| `PASV_ADDRESS` | - | 被动模式下的公网/外网 IP 地址 |
| `PASV_MIN_PORT` | - | 被动模式最小端口 |
| `PASV_MAX_PORT` | - | 被动模式最大端口 |

**Debian 专属变量**：

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian 软件包安装模式 |

### 自定义用户创建

在构建时创建指定 UID/GID 的非 root 用户：

```bash
docker build \
  --build-arg PUID=1000 \
  --build-arg PGID=1000 \
  --build-arg USER=appuser \
  -t snowdreamtech/vsftpd:debian-custom \
  ./docker/debian/
```

或在运行时通过环境变量指定：

```bash
docker run -d \
  --name=vsftpd \
  -e PUID=1000 \
  -e PGID=1000 \
  -e USER=appuser \
  snowdreamtech/vsftpd:debian
```

**注意**：仅当 `PUID≠0`、`PGID≠0` 且 `USER≠root` 时，才会触发自定义用户创建逻辑。

## Docker Compose 示例

### 基础配置

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

### 高级配置

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

## 语义化版本标签

镜像严格遵循语义化版本命名规范，格式为：`{major}.{minor}.{patch}-{variant}`

示例：

- `snowdreamtech/vsftpd:3.0.5-debian`
- `snowdreamtech/vsftpd:3.0.5-alpine`
- `snowdreamtech/vsftpd:3.0.5-rocky`

支持的标签类型：

- **精确版本锁定**：`<version>-debian`（如 `3.0.5-debian`）
- **变体最新标签**：`latest-debian`（追踪 Debian 最新版本）
- **全局最新标签**：`latest`（追踪整体最新版本，默认指向 Debian）

## 架构支持

各发行版变体支持的 CPU 架构如下：

| 发行版变体 | 支持架构 |
|------------|----------|
| **Debian** | amd64, arm32v7, arm64, ppc64le, riscv64, s390x |
| **Alpine** | 386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x |
| **Rocky** | amd64, arm64, ppc64le, s390x |

拉取镜像时，Docker 会自动根据运行平台选择匹配的架构。

## Entrypoint 初始化系统

镜像内置灵活的 entrypoint 机制，在启动主应用程序前自动按序执行自定义初始化脚本。

### 工作原理

1. 容器启动时运行 `docker-entrypoint.sh` 脚本
2. 按字典序遍历并执行 `/usr/local/bin/entrypoint.d/` 目录下所有可执行脚本
3. 每个脚本均会接收到容器的启动命令行参数
4. 任何脚本执行失败都将导致容器退出（Fail-Fast 机制）

### 添加自定义初始化逻辑

在基于本镜像派生的 Dockerfile 中添加自定义脚本：

```dockerfile
FROM snowdreamtech/vsftpd:debian

# 添加自定义初始化脚本
COPY my-init.sh /usr/local/bin/entrypoint.d/20-my-init.sh
RUN chmod +x /usr/local/bin/entrypoint.d/20-my-init.sh

# 应用程序配置
COPY app /app
CMD ["/app/start.sh"]
```

### 调试模式

通过开启 `DEBUG` 环境变量排查 entrypoint 执行过程：

```bash
docker run -e DEBUG=true snowdreamtech/vsftpd:debian
```

## 联系方式 (备注：vsftpd)

* 邮箱：<sn0wdr1am@qq.com>
* QQ：3217680847
* QQ 群：949022145
* 微信/微信群：sn0wdr1am

## 许可证

MIT
