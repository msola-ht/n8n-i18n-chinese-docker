@echo off
chcp 65001


REM Docker Compose 启动脚本


REM 版权所有 (c) 何老师的AIGC研究室

echo 何老师的AIGC研究室 - Docker服务管理
echo  作者：何老师的AIGC
echo  微信：hlsaigc
echo  社交平台：B站、小红书：@何老师的AIGC
echo  YouTube: @lunare-mcn
echo.

if exist docker-compose-cn.yml (
    set COMPOSE_FILE=docker-compose-cn.yml
) else if exist docker-compose.yaml (
    set COMPOSE_FILE=docker-compose-cn.yaml
) else (
    echo 错误：未找到 docker-compose 配置文件
    pause
    exit /b 1
)

echo 使用声明：

echo  请参考官方项目和模型页面了解许可信息。

echo  本整合包仅供体验、学术和研究使用。

echo.

echo 正在启动服务...

REM 启动服务并立即显示日志（不会在后台运行）
docker-compose -f %COMPOSE_FILE% up -d

REM 当用户按Ctrl+C后，脚本会执行到这里
echo.
echo 启动完毕.按任意键退出.
echo 版权所有 (c) 何老师的AIGC研究室
pause
