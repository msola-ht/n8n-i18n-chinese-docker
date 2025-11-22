[根目录](../CLAUDE.md) > **docker-win**

# docker-win 模块文档

## 模块职责

Windows 优化部署模块，提供 n8n 中文版在 Windows 环境下的简化部署方案，包含一键启动脚本和双语言配置文件。

## 入口与启动

### 核心启动脚本
- `Start-ZH.bat` - 中文环境启动脚本（推荐中文用户）
- `Start-EN.bat` - 英文环境启动脚本
- `Stop.bat` - 停止服务脚本

### 启动流程
1. 自动检查 Docker Desktop 状态
2. 检查 .env 配置文件（可选但推荐）
3. 提供启动选项：
   - 直接启动服务（快速）
   - 更新镜像后启动（推荐定期更新）
4. 自动拉取最新镜像并启动 n8n 服务

## 对外接口

### Docker Compose 配置
- `docker-compose-cn.yml` - 中文环境配置，自动设置中文界面
- `docker-compose-en.yml` - 英文环境配置

### 核心配置
- **服务端口**: 5678 (Web UI)
- **数据持久化**: Docker 匿名卷映射到 `/home/node/.n8n`
- **文件操作目录**:
  - `./input` → `/home/node/input` (输入文件)
  - `./output` → `/home/node/output` (输出文件)

## 关键依赖与配置

### 环境变量
```yaml
# 中文环境预设
- N8N_DEFAULT_LOCALE=zh-CN     # 设置默认语言为中文
- TZ=Asia/Shanghai             # 设置时区为上海
- N8N_SECURE_COOKIE=false      # 开发环境设置
- N8N_RUNNERS_ENABLED=true     # 启用外部 Runner
- N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true  # 增强安全性
```

### 工作流数据清理
```yaml
- EXECUTIONS_DATA_PRUNE=true   # 启用自动清理
- EXECUTIONS_DATA_MAX_AGE=48   # 数据保留 48 小时
- EXECUTIONS_DATA_MAX_COUNT=15 # 每个工作流保留 15 条记录
```

### 代理配置（可选）
在需要代理的环境下，可取消注释以下配置：
```yaml
- HTTP_PROXY=http://${PROXY_HTTP_HOST}:${PROXY_HTTP_PORT}
- HTTPS_PROXY=http://${PROXY_HTTPS_HOST}:${PROXY_HTTPS_PORT}
- NO_PROXY=${NO_PROXY_LIST}
```

## 数据模型

本模块主要为配置和部署脚本，不包含数据模型。

## 测试与质量

### 预检查机制
- Docker Desktop 状态检查
- .env 文件存在性检查（可选但推荐）
- 服务启动状态验证

### 错误处理
- 详细的 Windows 环境错误提示
- 常见问题解决方案指引
- 网络连接和权限检查

## 常见问题 (FAQ)

### Q: 启动脚本提示 Docker Desktop 未运行
**A**: 请确保 Docker Desktop 已启动并正常运行，可以在任务栏查看 Docker 图标状态。

### Q: 找不到 .env 文件是否影响启动？
**A**: .env 文件主要用于代理配置等高级设置，不影响基本功能。但建议创建该文件以获得更好的配置管理。

### Q: 如何更改端口映射？
**A**: 修改 `docker-compose-*.yml` 文件中的 `ports` 部分，将 `"5678:5678"` 改为 `"您的端口:5678"`。

### Q: 如何备份数据？
**A**: n8n 数据存储在 Docker 匿名卷中，可通过以下命令备份：
```bash
docker volume ls  # 查看 n8n 卷名
docker run --rm -v n8n_volume_name:/data -v %cd%:/backup alpine tar czf /backup/n8n-backup.tar.gz -C /data .
```

## 相关文件清单

### 配置文件
- `docker-compose-cn.yml` - 中文环境 Docker Compose 配置
- `docker-compose-en.yml` - 英文环境 Docker Compose 配置

### 启动脚本
- `Start-ZH.bat` - 中文启动脚本
- `Start-EN.bat` - 英文启动脚本
- `Stop.bat` - 停止服务脚本

### 工具脚本
- `Update-N8nVersion-Simple.ps1` - PowerShell 版本更新脚本
- `Update-And-Pull.bat` - 批处理版本更新脚本

### 目录结构（需手动创建）
- `input/` - 输入文件目录（n8n 工作流读取）
- `output/` - 输出文件目录（n8n 工作流输出）

## 变更记录 (Changelog)

### 2025-11-22
- 创建模块级文档
- 详细说明配置项和使用方法
- 添加常见问题解答