# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个自动化构建工具项目，专门用于为 n8n 工作流自动化平台构建包含中文语言包的 Docker 镜像。项目自动同步上游 `other-blowsnow/n8n-i18n-chinese` 仓库的最新 Release，构建中文版 n8n 镜像并发布到 Docker Hub。

## 核心架构

### 自动化构建流程
- **GitHub Actions**: `.github/workflows/build.yml` - 每小时检查上游更新，自动构建发布
- **多阶段 Docker 构建**: 使用 Alpine 轻量级镜像作为中间阶段，优化最终镜像大小
- **上游集成**: 通过 GitHub API 自动检测版本更新并下载中文语言包

### 主要组件
1. **CI/CD 工作流**: 完整的自动化构建、测试、发布流程
2. **Docker 配置**: 生产就绪的容器化部署配置
3. **上游同步机制**: 自动化版本检测和资源下载

## 常用开发命令

### 本地开发环境启动
```bash
# 进入 Docker 配置目录
cd docker

# 启动 n8n 服务和数据库
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f n8n
```

### 镜像使用
```bash
# 拉取最新镜像
docker pull hotwa/n8n-chinese:latest

# 拉取指定版本
docker pull hotwa/n8n-chinese:1.94.1

# 运行容器（基础版本）
docker run -d -p 5678:5678 hotwa/n8n-chinese:latest

# 运行容器（包含中文环境变量）
docker run -d \
  -p 5678:5678 \
  -e N8N_DEFAULT_LOCALE=zh-CN \
  -e GENERIC_TIMEZONE=Asia/Shanghai \
  hotwa/n8n-chinese:latest
```

### 手动触发构建
在 GitHub 仓库的 Actions 页面手动触发 "Build n8n Chinese Editor-UI Docker Image" 工作流。

## 关键配置说明

### 必需的环境变量
```bash
# 中文界面配置
N8N_DEFAULT_LOCALE=zh-CN
GENERIC_TIMEZONE=Asia/Shanghai

# 数据库配置（生产环境推荐）
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=postgres
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_PASSWORD=<secure_password>

# 安全配置
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=<username>
N8N_BASIC_AUTH_PASSWORD=<secure_password>
N8N_ENCRYPTION_KEY=<32_char_hex_key>
```

### Docker 镜像标签策略
- **版本标签**: `hotwa/n8n-chinese:1.94.1` - 对应具体 n8n 版本
- **latest 标签**: `hotwa/n8n-chinese:latest` - 始终指向最新构建的版本

## 项目结构

```
.
├── .github/
│   └── workflows/
│       └── build.yml              # GitHub Actions CI/CD 工作流
├── docker/
│   └── docker-compose.yml         # 生产环境 Docker Compose 配置
├── README.md                      # 项目说明文档
└── CLAUDE.md                      # 本文件
```

## 上游依赖

- **上游仓库**: `other-blowsnow/n8n-i18n-chinese`
- **检测频率**: 每小时检查一次新 Release
- **版本格式**: `n8n@1.115.3` → 提取为 `1.115.3`

## 构建过程

1. **版本检测**: 通过 GitHub API 获取上游最新 Release
2. **资源下载**: 自动下载 editor-ui dist 文件包
3. **多阶段构建**:
   - Stage 1: Alpine 镜像持有中文 dist 文件
   - Stage 2: 基于官方 n8n 镜像，集成中文语言包
4. **镜像发布**: 推送到 Docker Hub，打上版本和 latest 标签

## 生产部署注意事项

- 使用 PostgreSQL 数据库而非默认 SQLite
- 配置适当的安全认证和加密密钥
- 设置正确的域名和 webhook URL
- 启用工作流历史记录功能
- 配置数据持久化卷

## 监控和维护

- GitHub Actions 提供构建日志和状态监控
- Docker Hub 提供镜像下载统计
- 定期检查上游仓库更新情况
- 监控构建失败告警