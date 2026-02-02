# n8n 中文版 Docker 镜像

[![Build Status](https://github.com/msola-ht/n8n-i18n-chinese-docker/workflows/%E6%9E%84%E5%BB%BA%20n8n%20%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA%E7%89%88%E5%92%8C%E4%BC%81%E4%B8%9A%E7%89%88%20Docker%20%E9%95%9C%E5%83%8F/badge.svg)](https://github.com/msola-ht/n8n-i18n-chinese-docker/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/lunare/n8n-chinese.svg)](https://hub.docker.com/r/lunare/n8n-chinese)
[![Docker Pulls CN](https://img.shields.io/docker/pulls/lunare/n8n-chinese-cn.svg)](https://hub.docker.com/r/lunare/n8n-chinese-cn)
[![Docker Pulls Enterprise](https://img.shields.io/docker/pulls/lunare/n8n-chinese-enterprise.svg)](https://hub.docker.com/r/lunare/n8n-chinese-enterprise)

自动构建包含完整中文语言包的 n8n Docker 镜像

**当前版本**: `2.6.3`

## 特性

- 🇨🇳 完整中文界面
- 🏦 企业版支持（仅供学习测试）
- 🇨🇳 国内源优化版本（国内用户推荐）
- 📦 提供离线镜像下载
- 🏗️ 多架构支持（linux/amd64, linux/arm64）

## 快速使用

### 社区版（官方源）

适用于国际用户或不需要国内源优化的场景。

```bash
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -e N8N_DEFAULT_LOCALE=zh-CN \
  -e GENERIC_TIMEZONE=Asia/Shanghai \
  -v n8n_data:/home/node/.n8n \
  lunare/n8n-chinese:latest
```

### 社区版（国内源）🇨🇳

**国内用户推荐使用**，使用国内 npm 镜像源构建，构建和运行更稳定。

```bash
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -e N8N_DEFAULT_LOCALE=zh-CN \
  -e GENERIC_TIMEZONE=Asia/Shanghai \
  -v n8n_data:/home/node/.n8n \
  lunare/n8n-chinese-cn:latest
```

### 企业版

包含所有企业功能，仅供学习和测试使用。

```bash
docker run -d \
  --name n8n-enterprise \
  -p 5678:5678 \
  -e N8N_DEFAULT_LOCALE=zh-CN \
  -e GENERIC_TIMEZONE=Asia/Shanghai \
  -v n8n_data:/home/node/.n8n \
  lunare/n8n-chinese-enterprise:latest
```

访问 http://127.0.0.1:5678

## 镜像信息

| 镜像 | 标签 | Docker Hub | 适用场景 |
|------|------|------------|----------|
| 社区版（官方源） | `latest` 或 `2.6.3` | [lunare/n8n-chinese](https://hub.docker.com/r/lunare/n8n-chinese) | 国际用户 |
| 社区版（国内源）🇨🇳 | `latest` 或 `2.6.3` | [lunare/n8n-chinese-cn](https://hub.docker.com/r/lunare/n8n-chinese-cn) | 国内用户（推荐） |
| 企业版 | `latest` 或 `2.6.3` | [lunare/n8n-chinese-enterprise](https://hub.docker.com/r/lunare/n8n-chinese-enterprise) | 学习测试 |

## 镜像说明

### 社区版（官方源 vs 国内源）

两个版本功能完全相同，区别仅在于构建时使用的 npm 源：

- **官方源版本**：使用 `registry.npmjs.org`，适合国际用户
- **国内源版本**：使用 `registry.npmmirror.com`（淘宝镜像），国内用户推荐

### 企业版功能

企业版包含所有企业功能（高级权限、LDAP/SAML、源代码控制、变量管理等），**仅供学习和测试使用，请勿用于生产环境**。

## 离线下载

从 [GitHub Releases](https://github.com/msola-ht/n8n-i18n-chinese-docker/releases) 下载镜像文件：

- 社区版：`n8n-chinese-2.6.3.tar.gz`
- 企业版：`n8n-chinese-enterprise-2.6.3.tar.gz`

国内源版本的镜像可在 [GitHub Actions Artifacts](https://github.com/msola-ht/n8n-i18n-chinese-docker/actions) 中下载。

导入镜像：
```bash
docker load -i n8n-chinese-2.6.3.tar.gz
```

## 相关链接

- [上游中文项目](https://github.com/other-blowsnow/n8n-i18n-chinese)
- [GitHub Issues](https://github.com/msola-ht/n8n-i18n-chinese-docker/issues)

## 许可证

MIT License
