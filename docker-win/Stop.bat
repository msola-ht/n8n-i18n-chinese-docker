@echo off
REM 版权所有 (c) 老何的AIGC研究室
REM 本脚本用于停止并移除 n8n 服务

echo.
echo ===========================================
echo   老何的AIGC研究室 - n8n 服务停止脚本
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

echo.
echo ===========================================
echo   正在停止并移除 n8n 服务...
echo ===========================================
echo.

REM 定义要操作的 Docker Compose 文件
REM 注意：这里同时指定了 docker-compose-cn.yml 和 docker-compose-en.yml
REM 如果您的服务只由其中一个文件定义，可能需要调整
set "COMPOSE_FILES=-f docker-compose-cn.yml -f docker-compose-en.yml"
set "STOP_OPTIONS=" REM 停止选项，目前为空，即默认停止行为

REM 检查 Docker Desktop 是否正在运行
echo 正在检查 Docker Desktop 状态...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo 错误：Docker Desktop 或 Docker 服务未运行。
    echo 无法停止服务。
    echo.
    pause
    exit /b 1
)
echo Docker Desktop 正在运行。

echo.
echo -------------------------------------------
echo   将停止的服务文件: docker-compose-cn.yml, docker-compose-en.yml
echo   停止选项: %STOP_OPTIONS%
echo -------------------------------------------
echo.

REM !!! 添加这一行来显示当前工作目录 !!!
echo 当前工作目录: %cd%
echo.

echo 正在执行 docker-compose %COMPOSE_FILES% down %STOP_OPTIONS% ...
docker-compose %COMPOSE_FILES% down %STOP_OPTIONS%

if %errorlevel% equ 0 (
    echo.
    echo ===========================================
    echo   服务已成功停止并移除。
    echo ===========================================
) else (
    echo.
    echo ===========================================
    echo   错误：停止服务失败。
    echo   请检查上述错误信息以解决问题。
    echo ===========================================
)

echo.
echo 按任意键退出...
pause
