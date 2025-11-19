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
- 🗄️ **轻量级存储**: 使用 SQLite 数据库，无需额外数据库配置
- 🚀 **开箱即用**: Windows 一键启动，零配置部署
- 📦 **多版本支持**: 同时发布版本标签和 latest 标签

## 📦 Docker 镜像

### 镜像信息

- **仓库名称**: `lunare/n8n-chinese`
- **标签策略**:
  - `lunare/n8n-chinese:1.120.4` - 对应具体 n8n 版本（自动同步至最新构建版本）
  - `lunare/n8n-chinese:latest` - 最新版本

### 快速使用

```bash
# 拉取最新镜像
docker pull lunare/n8n-chinese:latest

# 拉取指定版本（版本号与 README 中的示例保持同步）
docker pull lunare/n8n-chinese:1.120.4

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

### Windows 环境（推荐）

本项目为 Windows 用户提供了简化的部署方案，包含一键启动脚本和双语言配置：

#### 🖥️ Windows 快速部署

```bash
# 克隆项目
git clone https://github.com/msola-ht/n8n-i18n-chinese-docker.git
cd n8n-i18n-chinese-docker/docker-win

# 使用中文脚本启动（推荐中文用户）
Start-ZH.bat

# 或使用英文脚本启动
Start-EN.bat

# 停止服务
Stop.bat
```

#### 📁 Windows 目录结构

```
docker-win/
├── docker-compose-cn.yml     # 中文环境配置（自动设置中文界面）
├── docker-compose-en.yml     # 英文环境配置
├── Start-ZH.bat              # 中文启动脚本
├── Start-EN.bat              # 英文启动脚本
├── Stop.bat                  # 停止服务脚本
├── .env                      # 环境变量配置文件（需要创建）
├── input/                    # 输入文件目录
└── output/                   # 输出文件目录
```

#### 🎯 Windows 启动脚本功能

**Start-ZH.bat / Start-EN.bat**：
- ✅ 自动检查 Docker Desktop 状态
- ✅ 检查 .env 配置文件
- ✅ 提供两种启动选项：
  1. 直接启动服务（快速）
  2. 更新镜像后启动（推荐定期更新）
- ✅ 自动拉取最新镜像
- ✅ 启动 n8n 服务
- ✅ 详细的错误提示和状态检查

**Stop.bat**：
- ✅ 停止并清理 n8n 服务
- ✅ 支持多配置文件清理

### Linux/Mac 环境

```bash
# 克隆项目
git clone https://github.com/msola-ht/n8n-i18n-chinese-docker.git
cd n8n-i18n-chinese-docker/docker-win

# 创建 .env 文件（可选）
cp .env.example .env

# 启动服务（中文版本）
docker-compose -f docker-compose-cn.yml up -d

# 或启动英文版本
docker-compose -f docker-compose-en.yml up -d

# 查看服务状态
docker-compose -f docker-compose-cn.yml ps

# 查看日志
docker-compose -f docker-compose-cn.yml logs -f n8n

# 停止服务
docker-compose -f docker-compose-cn.yml down
```

### 环境变量配置

#### 基础配置（docker-compose-cn.yml 已预设）

```yaml
environment:
  # 中文界面配置（中文版本自动设置）
  - N8N_DEFAULT_LOCALE=zh-CN          # 设置默认语言为中文
  - TZ=Asia/Shanghai                  # 设置时区为上海

  # 基础功能配置
  - N8N_SECURE_COOKIE=false           # 开发环境设置，生产环境建议为 true
  - N8N_RUNNERS_ENABLED=true          # 启用外部 Runner 功能
  - N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true  # 增强安全性

  # 工作流执行数据清理
  - EXECUTIONS_DATA_PRUNE=true        # 启用自动清理
  - EXECUTIONS_DATA_MAX_AGE=48        # 数据保留 48 小时
  - EXECUTIONS_DATA_MAX_COUNT=15      # 每个工作流保留 15 条记录
```

#### 代理配置（可选）

如果您的网络环境需要代理，请进行以下配置：

**步骤 1：创建 .env 文件**

```bash
# 在 docker-win 目录下创建 .env 文件
touch .env
```

**步骤 2：配置代理参数**

```env
# 代理服务器配置
PROXY_HTTP_HOST=proxy.example.com
PROXY_HTTP_PORT=8080
PROXY_HTTPS_HOST=proxy.example.com
PROXY_HTTPS_PORT=8080
NO_PROXY_LIST=localhost,127.0.0.1
```

**步骤 3：启用代理配置**

在 `docker-compose-cn.yml` 文件中，找到以下被注释的代理配置行：

```yaml
# --- 代理配置 (如果需要，请取消注释并从 .env 文件中获取值) ---
#- HTTP_PROXY=http://${PROXY_HTTP_HOST}:${PROXY_HTTP_PORT} # 配置 HTTP 代理地址。
#- HTTPS_PROXY=http://${PROXY_HTTPS_HOST}:${PROXY_HTTPS_PORT} # 配置 HTTPS 代理地址。
#- NO_PROXY=${NO_PROXY_LIST} # 指定不走代理的主机或域名列表。
```

**取消注释**（删除行首的 `#`）：

```yaml
# --- 代理配置 (如果需要，请取消注释并从 .env 文件中获取值) ---
- HTTP_PROXY=http://${PROXY_HTTP_HOST}:${PROXY_HTTP_PORT} # 配置 HTTP 代理地址。
- HTTPS_PROXY=http://${PROXY_HTTPS_HOST}:${PROXY_HTTPS_PORT} # 配置 HTTPS 代理地址。
- NO_PROXY=${NO_PROXY_LIST} # 指定不走代理的主机或域名列表。
```

> ⚠️ **注意**：修改配置后需要重新启动服务才能生效。

## 🔧 开发环境

### Windows 开发环境

```bash
# 进入 Windows 配置目录
cd docker-win

# 使用脚本快速启动
Start-ZH.bat

# 或手动启动（中文版本）
docker-compose -f docker-compose-cn.yml up -d

# 查看实时日志
docker-compose -f docker-compose-cn.yml logs -f n8n

# 停止服务
docker-compose -f docker-compose-cn.yml down

# 重新构建并启动
docker-compose -f docker-compose-cn.yml up -d --force-recreate
```

### Linux/Mac 开发环境

```bash
# 进入配置目录
cd docker-win

# 启动开发环境（中文版本）
docker-compose -f docker-compose-cn.yml up -d

# 查看实时日志
docker-compose -f docker-compose-cn.yml logs -f n8n

# 停止服务
docker-compose -f docker-compose-cn.yml down

# 重新构建并启动
docker-compose -f docker-compose-cn.yml up -d --force-recreate
```

### 文件目录操作

Windows 版本预设了文件输入输出目录：

```bash
# 访问挂载的目录
docker-win/input/     # 供 n8n 工作流读取的文件目录
docker-win/output/    # n8n 工作流输出文件的目录

# 在 n8n 中访问路径
/home/node/input/     # 容器内输入文件路径
/home/node/output/    # 容器内输出文件路径
```

### 手动触发构建

在 GitHub 仓库的 Actions 页面手动触发 "Build n8n Chinese Editor-UI Docker Image" 工作流。

## 📋 项目结构

```
n8n-i18n-chinese-docker/
├── .github/
│   └── workflows/
│       └── build.yml              # GitHub Actions CI/CD 工作流
├── docker-win/                    # Windows 优化配置目录
│   ├── docker-compose-cn.yml      # 中文环境配置（自动设置中文界面）
│   ├── docker-compose-en.yml      # 英文环境配置
│   ├── Start-ZH.bat               # 中文启动脚本
│   ├── Start-EN.bat               # 英文启动脚本
│   ├── Stop.bat                   # 停止服务脚本
│   ├── input/                     # 输入文件目录（需手动创建）
│   └── output/                    # 输出文件目录（需手动创建）
├── CLAUDE.md                      # AI 助手项目指南
├── README.md                      # 本文件
└── .gitignore                     # Git 忽略文件配置
```

## 🆚 Windows 版本特点

### ✅ Windows 专属功能
- **一键启动脚本**: 双击即可启动 n8n 服务
- **双语言支持**: 中文/英文启动脚本和配置
- **Docker Desktop 集成**: 自动检测和集成 Docker Desktop
- **文件目录预设**: 预配置 input/output 目录用于文件操作
- **错误友好提示**: 详细的 Windows 环境错误提示和解决方案

### 🎯 使用场景对比

| 功能 | 原版本 | Windows 版本 |
|------|--------|-------------|
| 启动方式 | 手动命令 | 一键脚本 |
| 语言支持 | 需手动配置 | 预设中文/英文 |
| 文件操作 | 需手动配置卷 | 预设 input/output 目录 |
| 错误处理 | 基础提示 | 详细 Windows 错误诊断 |
| 适合用户 | 开发者 | 所有用户（包括非技术用户） |

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
- **轻量级部署**: SQLite 数据库，开箱即用

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
