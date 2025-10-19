# n8n 中文版 Docker 镜像自动构建项目

[![Build Status](https://github.com/msola-ht/n8n-i18n-chinese-docker/workflows/Build%20n8n%20Chinese%20Editor-UI%20Docker%20Image/badge.svg)](https://github.com/msola-ht/n8n-i18n-chinese-docker/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/lunare/n8n-chinese.svg)](https://hub.docker.com/r/lunare/n8n-chinese)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

🚀 **自动化构建包含完整中文语言包和 FFmpeg 的 n8n Docker 镜像**

本项目是基于 [hotwa/n8n-i18n-chinese-docker](https://github.com/hotwa/n8n-i18n-chinese-docker) 的改进版本，自动同步上游 [other-blowsnow/n8n-i18n-chinese](https://github.com/other-blowsnow/n8n-i18n-chinese) 仓库的最新 Release，构建包含中文语言包和 FFmpeg 支持的 n8n Docker 镜像并发布到 Docker Hub。

## ✨ 特性

- 🔄 **自动同步**: 每小时检查上游更新，自动构建最新版本
- 🐳 **优化构建**: 多阶段 Docker 构建，镜像体积更小
- 🇨🇳 **完整中文**: 集成完整中文语言包，支持中文界面
- 🎬 **FFmpeg 支持**: 预装 FFmpeg，支持视频、音频处理工作流
- 🚀 **生产就绪**: 包含完整的 PostgreSQL 集成配置
- 📦 **多版本支持**: 同时发布版本标签和 latest 标签

## 📦 Docker 镜像

### 镜像信息

- **仓库名称**: `lunare/n8n-chinese`
- **标签策略**:
  - `lunare/n8n-chinese:1.94.1` - 对应具体 n8n 版本
  - `lunare/n8n-chinese:latest` - 最新版本

### 快速使用

```bash
# 拉取最新镜像
docker pull lunare/n8n-chinese:latest

# 拉取指定版本
docker pull lunare/n8n-chinese:1.94.1

# 运行容器（基础版本）
docker run -d -p 5678:5678 lunare/n8n-chinese:latest

# 运行容器（包含中文环境变量）
docker run -d \
  -p 5678:5678 \
  -e N8N_DEFAULT_LOCALE=zh-CN \
  -e GENERIC_TIMEZONE=Asia/Shanghai \
  lunare/n8n-chinese:latest
```

## 🚀 生产环境部署

### 使用 Docker Compose（推荐）

```bash
# 克隆项目
git clone https://github.com/msola-ht/n8n-i18n-chinese-docker.git
cd n8n-i18n-chinese-docker/docker

# 修改配置文件
nano docker-compose.yml

# 启动服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f n8n
```

### 必需的环境变量

```yaml
environment:
  # 中文界面配置
  - N8N_DEFAULT_LOCALE=zh-CN          # 设置默认语言为中文
  - GENERIC_TIMEZONE=Asia/Shanghai     # 设置时区为上海

  # 数据库配置（生产环境强烈推荐使用 PostgreSQL）
  - DB_TYPE=postgresdb
  - DB_POSTGRESDB_HOST=postgres
  - DB_POSTGRESDB_DATABASE=n8n
  - DB_POSTGRESDB_USER=n8n
  - DB_POSTGRESDB_PASSWORD=<secure_password>

  # 安全配置
  - N8N_BASIC_AUTH_ACTIVE=true         # 启用基础认证
  - N8N_BASIC_AUTH_USER=<username>     # 认证用户名
  - N8N_BASIC_AUTH_PASSWORD=<secure_password>  # 认证密码
  - N8N_ENCRYPTION_KEY=<32_char_hex_key>       # 加密密钥

  # 生产环境配置
  - NODE_ENV=production
  - N8N_HOST=yourdomain.com            # 您的域名
  - WEBHOOK_URL=https://yourdomain.com
  - N8N_CONCURRENCY_PRODUCTION_LIMIT=5
  - N8N_LOG_LEVEL=info
```

## 🔧 开发环境

### 本地开发

```bash
# 进入 Docker 配置目录
cd docker

# 启动开发环境
docker-compose up -d

# 停止服务
docker-compose down

# 重新构建并启动
docker-compose up -d --build
```

### 手动触发构建

在 GitHub 仓库的 Actions 页面手动触发 "Build n8n Chinese Editor-UI Docker Image" 工作流。

## 📋 项目结构

```
n8n-i18n-chinese-docker/
├── .github/
│   └── workflows/
│       └── build.yml              # GitHub Actions CI/CD 工作流
├── docker/
│   └── docker-compose.yml         # 生产环境 Docker Compose 配置
├── CLAUDE.md                      # AI 助手项目指南
├── README.md                      # 本文件
└── .gitignore                     # Git 忽略文件配置
```

## 🔄 自动化流程

### 构建触发

1. **定时触发**: 每小时自动检查上游更新
2. **手动触发**: 在 GitHub Actions 页面手动执行
3. **API 检测**: 通过 GitHub API 检测新 Release

### 构建步骤

1. **版本检测**: 获取上游最新 Release 标签
2. **资源下载**: 下载中文语言包 dist 文件
3. **多阶段构建**:
   - Stage 1: Alpine 镜像持有中文文件
   - Stage 2: 基于官方 n8n 镜像集成中文包
4. **镜像发布**: 推送到 Docker Hub

## 🛠️ 技术栈

- **Docker**: 容器化技术
- **GitHub Actions**: CI/CD 自动化
- **Docker Compose**: 多容器编排
- **PostgreSQL**: 数据库存储
- **FFmpeg**: 多媒体处理框架
- **Alpine Linux**: 轻量级基础镜像

## 📊 监控和维护

- **GitHub Actions**: 构建日志和状态监控
- **Docker Hub**: 镜像下载统计
- **上游监控**: 定期检查上游仓库更新
- **告警机制**: 构建失败自动通知

## 🔗 相关链接

- [n8n 官网](https://n8n.io/)
- [n8n GitHub](https://github.com/n8n-io/n8n)
- [上游中文项目](https://github.com/other-blowsnow/n8n-i18n-chinese)
- [原始项目](https://github.com/hotwa/n8n-i18n-chinese-docker)
- [Docker Hub 镜像](https://hub.docker.com/r/lunare/n8n-chinese)

## ⚠️ 注意事项

1. **上游依赖**: 依赖上游仓库的稳定性和更新频率
2. **安全更新**: 定期更新基础镜像的安全补丁
3. **版本兼容**: 确保中文包与官方版本的兼容性
4. **数据备份**: 生产环境请务必配置数据备份
5. **FFmpeg 功能**: 本镜像包含 FFmpeg，可用于视频、音频处理工作流

## 🆚 与原项目的区别

本项目基于 [hotwa/n8n-i18n-chinese-docker](https://github.com/hotwa/n8n-i18n-chinese-docker) 进行了以下改进：

### ✅ 新增功能
- **FFmpeg 支持**: 预装 FFmpeg 多媒体处理工具
- **增强的工作流**: 支持视频转码、音频处理、媒体文件操作等节点

### 🔄 保持的功能
- **自动同步**: 完整保留上游自动同步机制
- **中文语言**: 完整的中文界面支持
- **多阶段构建**: 优化的 Docker 构建流程
- **生产就绪**: PostgreSQL 集成和安全配置

### 📋 使用场景
新增的 FFmpeg 支持使您可以在 n8n 工作流中：
- 转换视频格式 (MP4, AVI, MOV 等)
- 提取音频轨道
- 压缩视频文件
- 生成视频缩略图
- 处理音频文件
- 批量媒体处理

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目！

## 📞 支持

如果您在使用过程中遇到问题，请：

1. 查看 [GitHub Issues](https://github.com/msola-ht/n8n-i18n-chinese-docker/issues)
2. 提交新的 Issue 描述您的问题
3. 参考上游项目的文档和支持

---

⭐ 如果这个项目对您有帮助，请给个 Star 支持一下！
