@echo off
REM 版权所有 (c) 老何的AIGC研究室
REM 本脚本用于启动 n8n 服务

echo.
echo ===========================================
echo   老何的AIGC研究室 - n8n 服务启动脚本
echo ===========================================
echo.

REM 作者信息
echo ===========================================
echo   作者：何老师的AIGC
echo   微信：hlsaigc
echo   社交平台：B站、抖音、小红书: @何老师的AIGC
echo   YouTube: @lunare-mcn
echo ===========================================
echo.

REM 使用声明
echo ===========================================
echo   使用声明：
echo   请自行查阅官方项目及模型页面了解授权许可
echo   整合包仅用于体验、学术、研究使用
echo ===========================================
echo.

REM 切换到当前批处理文件所在的目录
cd /d "%~dp0"

echo -------------------------------------------
echo   正在准备启动 n8n 服务...
echo -------------------------------------------
echo.

REM 检查 Docker Desktop 是否正在运行
echo 1. 正在检查 Docker Desktop 状态...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo 错误：Docker Desktop 或 Docker 服务未运行。
    echo 请确保 Docker Desktop 已启动并正常运行，然后重试。
    echo.
    pause
    exit /b 1
)
echo Docker Desktop 正在运行。
echo.

REM 检查 .env 文件是否存在
echo 2. 正在检查 .env 配置文件...
if not exist .env (
    echo.
    echo 警告：未找到 .env 文件！
    echo Docker Compose 将无法加载环境变量，服务可能无法正常启动。
    echo 请在当前目录创建或确认 .env 文件是否存在，并配置好所需的环境变量。
    echo 强烈建议您创建此文件以确保服务正常运行。
    echo.
    pause
    REM 不退出，让用户决定是否继续
) else (
    echo .env 文件已找到。
)
echo.

REM 新增：用户选择操作
echo -------------------------------------------
echo   请选择操作：
echo   1. 直接启动 n8n 服务 (如果镜像已是最新，启动会更快)
echo   2. 更新 n8n 镜像到最新版并启动 (推荐定期更新，确保功能最新)
echo -------------------------------------------
echo.

choice /c 12 /m "请输入您的选择 (1 或 2)："

if %errorlevel% equ 1 goto :START_SERVICE_DIRECTLY
if %errorlevel% equ 2 goto :UPDATE_AND_START_SERVICE

:START_SERVICE_DIRECTLY
echo.
echo 3. 您选择了直接启动 n8n 服务。
echo    正在执行 docker-compose up -d 启动 n8n 服务...
echo    (此过程可能需要一些时间)
echo.
docker-compose -f docker-compose-cn.yml up -d
goto :CHECK_STATUS

:UPDATE_AND_START_SERVICE
echo.
echo 3. 您选择了更新 n8n 镜像并启动。
echo    正在拉取 n8n 最新镜像...
echo    (此过程可能需要一些时间，取决于网络状况和镜像大小)
echo.
docker-compose -f docker-compose-cn.yml pull
if %errorlevel% neq 0 (
    echo.
    echo 错误：拉取 n8n 镜像失败。
    echo 请检查网络连接、Docker 配置或 Docker Hub 访问权限。
    echo.
    pause
    exit /b 1
)
echo n8n 镜像已更新到最新版。
echo.
echo 4. 正在执行 docker-compose up -d 启动 n8n 服务...
echo    (此过程可能需要一些时间)
echo.
docker-compose -f docker-compose-cn.yml up -d
goto :CHECK_STATUS

:CHECK_STATUS
if %errorlevel% equ 0 (
    echo.
    echo ===========================================
    echo   n8n 服务启动成功！
    echo   n8n 应该在 http://127.0.0.1:5678 上可用。
    echo   请在浏览器中访问此地址。
    echo ===========================================
) else (
    echo.
    echo ===========================================
    echo   错误：n8n 服务启动失败。
    echo   请检查上述错误信息，或查看 Docker Compose 日志以解决问题。
    echo   常见问题：端口冲突、镜像下载失败、.env 配置错误。
    echo ===========================================
)

echo.
echo -------------------------------------------
echo   脚本执行完毕。
echo -------------------------------------------
echo.
pause
