@echo off
REM 版权所有 (c) 老何的AIGC研究室
REM 本脚本用于启动 n8n 服务

echo.
echo ===========================================
echo   老何的AIGC研究室 - n8n 版本更新脚本
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

powershell -ExecutionPolicy Bypass -File "Update-N8nVersion-Simple.ps1"

docker pull lunare/n8n-chinese
pause