@echo off
chcp 65001


REM Docker Compose 停止脚本


REM 版权所有 (c) 老何的AIGC研究室

echo 老何的AIGC研究室

echo Docker 服务管理

echo.

echo 正在停止中文版服务...
docker-compose -f docker-compose-cn.yml down
if %errorlevel% equ 0 (
    echo 中文版服务已停止
) else (
    echo 中文版服务停止失败
)

echo.
echo Stopping English version service...
docker-compose -f docker-compose-en.yml down
if %errorlevel% equ 0 (
    echo English service stopped successfully
) else (
    echo Failed to stop English service
)

echo.
echo 所有服务操作完成

echo 按任意键关闭

echo 版权所有 (c) 老何的AIGC研究室

echo.
echo All service operations completed
echo Press any key to close
echo Copyright (c) HeGenAI AIGC Research Lab

pause