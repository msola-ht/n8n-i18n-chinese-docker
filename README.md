# n8n 中文版 Docker 镜像

[![Build Status](https://github.com/msola-ht/n8n-i18n-chinese-docker/workflows/%E6%9E%84%E5%BB%BA%20n8n%20%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA%E7%89%88%E5%92%8C%E4%BC%81%E4%B8%9A%E7%89%88%20Docker%20%E9%95%9C%E5%83%8F/badge.svg)](https://github.com/msola-ht/n8n-i18n-chinese-docker/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/lunare/n8n-chinese.svg)](https://hub.docker.com/r/lunare/n8n-chinese)
[![Docker Pulls Enterprise](https://img.shields.io/docker/pulls/lunare/n8n-chinese-enterprise.svg)](https://hub.docker.com/r/lunare/n8n-chinese-enterprise)

自动构建包含完整中文语言包的 n8n Docker 镜像

## 特性

- 🇨🇳 完整中文界面
- 🏦 企业版支持（仅供学习测试）
- 📦 提供离线镜像下载
- 🏗️ 多架构支持（linux/amd64, linux/arm64）

## 快速使用

### 社区版

```bash
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -e N8N_DEFAULT_LOCALE=zh-CN \
  -e GENERIC_TIMEZONE=Asia/Shanghai \
  -v n8n_data:/home/node/.n8n \
  lunare/n8n-chinese:latest
```

### 企业版

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

| 镜像 | 标签 | Docker Hub |
|------|------|------------|
| 社区版 | `latest` 或版本号 | [lunare/n8n-chinese](https://hub.docker.com/r/lunare/n8n-chinese) |
| 企业版 | `latest` 或版本号 | [lunare/n8n-chinese-enterprise](https://hub.docker.com/r/lunare/n8n-chinese-enterprise) |

## 离线下载

从 [GitHub Releases](https://github.com/msola-ht/n8n-i18n-chinese-docker/releases) 下载镜像文件：

- 社区版：`n8n-chinese-{version}.tar.gz`
- 企业版：`n8n-chinese-enterprise-{version}.tar.gz`

导入镜像：
```bash
docker load -i n8n-chinese-{version}.tar.gz
```

## 企业版功能

企业版包含所有企业功能（高级权限、LDAP/SAML、源代码控制、变量管理等），**仅供学习和测试使用，请勿用于生产环境**。

## 相关链接

- [上游中文项目](https://github.com/other-blowsnow/n8n-i18n-chinese)
- [GitHub Issues](https://github.com/msola-ht/n8n-i18n-chinese-docker/issues)

## 许可证

MIT License
