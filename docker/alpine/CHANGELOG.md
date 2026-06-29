# Changelog

## [3.0.5](https://github.com/snowdreamtech/vsftpd/compare/alpine-v3.0.5...alpine-v3.0.5) (2026-06-29)


### 🐛 Bug Fixes

* **alpine:** add empty line to trigger release pipeline test ([6f32fb1](https://github.com/snowdreamtech/vsftpd/commit/6f32fb1c9fae9bcd4e86beb2e3013a0138784372))
* **docker:** fix shellcheck errors and make entrypoint scripts executable ([7cc7314](https://github.com/snowdreamtech/vsftpd/commit/7cc73148c23746978b69b65eec98d9cf8837693b))
* resolve package install order and smoke test behavior with KEEPALIVE=1 ([60aa539](https://github.com/snowdreamtech/vsftpd/commit/60aa53949c2ad9f747c0e9aded456dd0d5fb0350))
* use ghcr.io for base images to avoid rate limits ([9f1d73a](https://github.com/snowdreamtech/vsftpd/commit/9f1d73a75a61f2f368f5572c4bd28f4c92ef8fd5))


### 🛠 Refactoring

* apply consistent two-space indentation across all vsftpd setup entrypoint scripts ([32753c9](https://github.com/snowdreamtech/vsftpd/commit/32753c975c96db27005c41f19c5b5729be0f7381))
* **docker:** align Dockerfiles with base image structure ([232574f](https://github.com/snowdreamtech/vsftpd/commit/232574fed8418f8c7f257d001e951361dfa467a0))
* **docker:** align Dockerfiles with vsftpd structure and restore frontend env ([dffc250](https://github.com/snowdreamtech/vsftpd/commit/dffc250a08bccb279e07936e157b1bc48b89c2a0))
* remove redundant docker-entrypoint.sh files ([87c576b](https://github.com/snowdreamtech/vsftpd/commit/87c576b27731ad11c5bc0ebc661e07c5a09ff1c1))
* reorganize distribution variants into docker directory ([67a8c91](https://github.com/snowdreamtech/vsftpd/commit/67a8c911e21801bf12b3e83d02e22f3b3f59a2ba))


### 📖 Documentation

* add detailed comments to entrypoint initialization scripts ([f42cbaa](https://github.com/snowdreamtech/vsftpd/commit/f42cbaab6edfbc5c38c2a636dfd8651fea900940))
* update references from base to vsftpd in documentation ([505a8c7](https://github.com/snowdreamtech/vsftpd/commit/505a8c7d1ff593174c454f2761f2bc00b7a6aa67))


### ♻️ Miscellaneous Chores

* **deps:** bump base images to alpine 3.24.0, debian 13.5.0, rocky 10.2.0 ([1688969](https://github.com/snowdreamtech/vsftpd/commit/168896956d2f4c7f91309c4c98ffef36ca7e8546))
* format Dockerfile version labels as standalone instructions ([2099c9c](https://github.com/snowdreamtech/vsftpd/commit/2099c9cf56906bb45b12d381d232648b39fba703))
* release main ([f66597a](https://github.com/snowdreamtech/vsftpd/commit/f66597a5feae95e8853f4cc730c81e93e172f6ca))
* release main ([b3a5cc9](https://github.com/snowdreamtech/vsftpd/commit/b3a5cc9ef0a64a7bc04ed7c2acf0cca5327c5c26))
* release main ([deb8454](https://github.com/snowdreamtech/vsftpd/commit/deb8454df7518d56939ab3851245a4cd7b03d709))
* release main ([d87cb81](https://github.com/snowdreamtech/vsftpd/commit/d87cb815685ad9b5b43d4b9a195c68dee2fd8065))
* release main ([78328d2](https://github.com/snowdreamtech/vsftpd/commit/78328d20bd3697d48ea90aee8d0eaa6af4ccc09c))
* release main ([b720ad5](https://github.com/snowdreamtech/vsftpd/commit/b720ad57dd1691d8ae07dcac7d46d0bd257af3a0))
* release main ([32dd84d](https://github.com/snowdreamtech/vsftpd/commit/32dd84de4be973395d0867b5d527d528948a35df))
* release main ([725c69f](https://github.com/snowdreamtech/vsftpd/commit/725c69fdcc222b5b83d0690629ce213a68c586ab))
* release main ([070b694](https://github.com/snowdreamtech/vsftpd/commit/070b694a702763b60fc6b057a81418320418cafa))
* release main ([36d1211](https://github.com/snowdreamtech/vsftpd/commit/36d1211036847a8c6aaa01a21a1c695a47b71d45))
* release main ([9ad4f94](https://github.com/snowdreamtech/vsftpd/commit/9ad4f9490832efdc310f2ebbd8c77f3404daf07f))
* release main ([b0684a3](https://github.com/snowdreamtech/vsftpd/commit/b0684a32a652e83506451e6056168cfec8b9142c))
* release main ([495e18a](https://github.com/snowdreamtech/vsftpd/commit/495e18a4babcb06a12c2f5aec9ea571d97cb32e3))
* release main ([d4a3a34](https://github.com/snowdreamtech/vsftpd/commit/d4a3a34b00a6b9f381cd5d556749c257516b2f08))
* release main ([28d9426](https://github.com/snowdreamtech/vsftpd/commit/28d94263f4374017274707faef7183917b689be9))
* **release:** deduplicate CHANGELOG headers ([82be3d5](https://github.com/snowdreamtech/vsftpd/commit/82be3d5576b65b7f69b1a9afb8604f2c8f0e47f7))
* **release:** deduplicate CHANGELOG headers ([d47fb44](https://github.com/snowdreamtech/vsftpd/commit/d47fb44cb105b368722d7d0e210a27b525f82d87))
* **release:** deduplicate CHANGELOG headers ([e795177](https://github.com/snowdreamtech/vsftpd/commit/e79517795d98b9f8292ef956586a6dc03932d03c))
* **release:** deduplicate CHANGELOG headers ([27919e4](https://github.com/snowdreamtech/vsftpd/commit/27919e4baf4aab5b2a2bf32a7d437b05a717c11b))
* **release:** deduplicate CHANGELOG headers ([438190d](https://github.com/snowdreamtech/vsftpd/commit/438190d297c151c75eca4912fdc22c285d5ec1ea))
* **release:** deduplicate CHANGELOG headers ([256f043](https://github.com/snowdreamtech/vsftpd/commit/256f04311b2344f2648ca5bcf407146f8c690258))
* **release:** deduplicate CHANGELOG headers ([d263aae](https://github.com/snowdreamtech/vsftpd/commit/d263aae7b223103a01dd0e114430381c5d863dd7))
* **release:** deduplicate CHANGELOG headers ([133954e](https://github.com/snowdreamtech/vsftpd/commit/133954e95cfae85cbba2fb9c1ac5acbc677ca39d))
* **release:** deduplicate CHANGELOG headers ([1d82410](https://github.com/snowdreamtech/vsftpd/commit/1d82410d6038be22d7741f1519826f30023b0f3e))
* **release:** deduplicate CHANGELOG headers ([5e1a539](https://github.com/snowdreamtech/vsftpd/commit/5e1a5390319933b48d20ad993714587d826c0aa7))
* **release:** implement automatic changelog deduplication step ([282c220](https://github.com/snowdreamtech/vsftpd/commit/282c22081e1ad7a1a010a7f297d20bc7c9b416a7))

## [3.24.0](https://github.com/snowdreamtech/vsftpd/compare/alpine-v3.24.0...alpine-v3.24.0) (2026-06-29)


### 🐛 Bug Fixes

* use ghcr.io for base images to avoid rate limits ([9f1d73a](https://github.com/snowdreamtech/vsftpd/commit/9f1d73a75a61f2f368f5572c4bd28f4c92ef8fd5))


### ♻️ Miscellaneous Chores

* release main ([b3a5cc9](https://github.com/snowdreamtech/vsftpd/commit/b3a5cc9ef0a64a7bc04ed7c2acf0cca5327c5c26))

## [3.23.4](https://github.com/snowdreamtech/vsftpd/compare/alpine-v3.23.4...alpine-v3.23.4) (2026-04-29)


### 🛠 Refactoring

* **docker:** align Dockerfiles with base image structure ([232574f](https://github.com/snowdreamtech/vsftpd/commit/232574fed8418f8c7f257d001e951361dfa467a0))
* remove redundant docker-entrypoint.sh files ([87c576b](https://github.com/snowdreamtech/vsftpd/commit/87c576b27731ad11c5bc0ebc661e07c5a09ff1c1))
* reorganize distribution variants into docker directory ([67a8c91](https://github.com/snowdreamtech/vsftpd/commit/67a8c911e21801bf12b3e83d02e22f3b3f59a2ba))


### 📖 Documentation

* add detailed comments to entrypoint initialization scripts ([f42cbaa](https://github.com/snowdreamtech/vsftpd/commit/f42cbaab6edfbc5c38c2a636dfd8651fea900940))


### ♻️ Miscellaneous Chores

* **main:** release 0.14.0 ([043d2a4](https://github.com/snowdreamtech/vsftpd/commit/043d2a4202505e42c645e899c6731f5fb8f52c8e))
* release 0.6.1 ([f6fc042](https://github.com/snowdreamtech/vsftpd/commit/f6fc042cad7d1c4991a20657655bc4b6b339d0d9))
* release 0.7.1 ([5535492](https://github.com/snowdreamtech/vsftpd/commit/5535492160f3525dff06ff9f0c6d78147467bed3))
* **release:** v0.4.0 - Fix Dependabot docker-compose detection ([e91f7d8](https://github.com/snowdreamtech/vsftpd/commit/e91f7d882f3c7b23260f4da02f0e5e53d6399968))
