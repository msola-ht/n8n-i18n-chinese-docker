# n8n 中文版 Docker 镜像

[![Build Status](https://github.com/msola-ht/n8n-i18n-chinese-docker/workflows/%E6%9E%84%E5%BB%BA%20n8n%20%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA%E7%89%88%E5%92%8C%E4%BC%81%E4%B8%9A%E7%89%88%20Docker%20%E9%95%9C%E5%83%8F/badge.svg)](https://github.com/msola-ht/n8n-i18n-chinese-docker/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/lunare/n8n-chinese.svg)](https://hub.docker.com/r/lunare/n8n-chinese)
[![Docker Pulls Enterprise](https://img.shields.io/docker/pulls/lunare/n8n-chinese-enterprise.svg)](https://hub.docker.com/r/lunare/n8n-chinese-enterprise)

🚀 自动构建包含完整中文语言包和 FFmpeg 的 n8n Docker 镜像

## 🌟 特性

- 🇨🇳 **完整中文支持** - 开箱即用的简体中文界面
- 🔄 **自动更新** - 每小时检查上游更新，自动构建最新版本
- 🎬 **FFmpeg 支持** - 预装 FFmpeg，支持视频、音频处理工作流
- 💻 **Windows 友好** - 提供一键启动脚本
- 🏢 **企业版支持** - 同时提供社区版和企业版镜像
- 🗄️ **轻量部署** - 使用 SQLite 数据库，无需额外配置

## 🚀 快速开始

### Windows 一键部署（推荐）

```bash
git clone https://github.com/msola-ht/n8n-i18n-chinese-docker.git
cd n8n-i18n-chinese-docker/docker-win

# 中文环境启动
Start-ZH.bat

# 访问 http://127.0.0.1:5678
```

### Docker 命令部署

```bash
# 社区版
docker run -d \
  -p 5678:5678 \
  -e N8N_DEFAULT_LOCALE=zh-CN \
  -e GENERIC_TIMEZONE=Asia/Shanghai \
  lunare/n8n-chinese:1.121.2latest

# 企业版
docker run -d \
  -p 5678:5678 \
  -e N8N_DEFAULT_LOCALE=zh-CN \
  -e GENERIC_TIMEZONE=Asia/Shanghai \
  lunare/n8n-chinese-enterprise:1.121.2latest
```

## 📦 镜像信息

### 社区版
- **镜像**: `lunare/n8n-chinese`
- **版本**: `1.120.4` / `latest`
- **标签**: `docker pull lunare/n8n-chinese:1.121.2`

### 企业版
- **镜像**: `lunare/n8n-chinese-enterprise`
- **版本**: `1.120.4` / `latest`
- **标签**: `docker pull lunare/n8n-chinese-enterprise:1.121.2`

## 📁 项目结构

```
n8n-i18n-chinese-docker/
├── .github/
│   └── workflows/
│       └── build-enterprise.yml      # 企业版构建工作流
├── docker-win/                        # Windows 优化配置目录
│   ├── docker-compose-cn.yml          # 中文环境配置
│   ├── docker-compose-en.yml          # 英文环境配置
│   ├── Start-ZH.bat                   # 中文启动脚本
│   ├── Start-EN.bat                   # 英文启动脚本
│   ├── Stop.bat                       # 停止服务脚本
│   ├── Update-And-Pull.bat            # 更新脚本
│   ├── Update-N8nVersion-Simple.ps1   # PowerShell 更新脚本
│   ├── .env                           # 环境变量配置
│   └── CLAUDE.md                      # 模块文档
├── CLAUDE.md                          # 项目 AI 指南
├── README.md                          # 本文件
├── Dockerfile.community               # 社区版构建配置
└── .gitignore                         # Git 忽略配置
```

## ⚙️ 环境变量

```yaml
environment:
  - N8N_DEFAULT_LOCALE=zh-CN          # 中文界面
  - TZ=Asia/Shanghai                  # 时区
  - N8N_SECURE_COOKIE=false           # Cookie 设置
  - EXECUTIONS_DATA_PRUNE=true        # 数据清理
  - EXECUTIONS_DATA_MAX_AGE=48        # 保留时间
  - EXECUTIONS_DATA_MAX_COUNT=15      # 保留数量
```

## 🔧 Docker Compose 使用方法

### 基本使用

```bash
# 进入配置目录
cd docker-win

# 启动中文环境服务
docker-compose -f docker-compose-cn.yml up -d

# 查看服务状态
docker-compose -f docker-compose-cn.yml ps

# 查看实时日志
docker-compose -f docker-compose-cn.yml logs -f n8n

# 停止服务
docker-compose -f docker-compose-cn.yml down

# 重启服务
docker-compose -f docker-compose-cn.yml restart
```

### 端口修改

如果需要修改端口（例如改为 8080），请编辑 `docker-compose-cn.yml` 文件：

```yaml
# 找到 ports 部分，修改端口号
ports:
  - "8080:5678"  # 将 5678 改为你想要的端口
```

### 代理配置

如果你的网络环境需要代理，请按以下步骤配置：

#### 1. 修改 .env 文件

编辑 `docker-win/.env` 文件，修改代理配置：

```env
# 代理服务器配置
PROXY_HTTP_HOST=host.docker.internal  # 你的代理地址
PROXY_HTTP_PORT=7897                  # 你的代理端口
PROXY_HTTPS_HOST=host.docker.internal # HTTPS 代理地址
PROXY_HTTPS_PORT=7897                 # HTTPS 代理端口
NO_PROXY_LIST=localhost,127.0.0.1,n8n.local,172.16.0.0/12,10.0.0.0/8,192.168.0.0/16,.local
```

#### 2. 启用代理配置

编辑 `docker-compose-cn.yml` 文件，找到代理配置部分，**取消注释**（删除行首的 `#`）：

```yaml
# --- 代理配置 (如果需要，请取消注释并从 .env 文件中获取值) ---
- HTTP_PROXY=http://${PROXY_HTTP_HOST}:${PROXY_HTTP_PORT}    # 删除行首的 #
- HTTPS_PROXY=http://${PROXY_HTTPS_HOST}:${PROXY_HTTPS_PORT}  # 删除行首的 #
- NO_PROXY=${NO_PROXY_LIST}                                    # 删除行首的 #
```

#### 3. 重新启动服务

```bash
# 停止当前服务
docker-compose -f docker-compose-cn.yml down

# 重新启动服务
docker-compose -f docker-compose-cn.yml up -d
```

### 文件目录使用

项目配置了文件操作目录，你可以将文件放在以下位置：

```bash
docker-win/
├── input/     # 放置要处理的文件，n8n 可通过 /home/node/input 访问
└── output/    # n8n 输出文件会保存到这里，对应容器内 /home/node/output
```

### 企业版配置

如需使用企业版，请修改 `docker-compose-cn.yml` 中的镜像：

```yaml
services:
  n8n:
    image: lunare/n8n-chinese-enterprise:1.121.2latest  # 改为企业版镜像
```

## ❓ 常见问题

**Q: 如何更换端口？**
A: 修改 `docker-compose*.yml` 中的 `"5678:5678"` 为 `"你的端口:5678"`

**Q: 数据存储在哪里？**
A: 数据存储在 Docker 匿名卷中，重启不会丢失

**Q: 如何备份数据？**
A: 参考 [备份指南](docs/backup.md)

**Q: 忘记密码怎么办？**
A: 停止容器，删除数据卷，重新启动

## 🔗 相关链接

- [n8n 官网](https://n8n.io/)
- [上游中文项目](https://github.com/other-blowsnow/n8n-i18n-chinese)
- [Docker Hub 镜像](https://hub.docker.com/r/lunare/n8n-chinese)
- [GitHub Issues](https://github.com/msola-ht/n8n-i18n-chinese-docker/issues)

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

⭐ 如果这个项目对您有帮助，请给个 Star 支持一下！