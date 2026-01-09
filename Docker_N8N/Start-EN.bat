@echo off
chcp 65001 >nul
REM Copyright (c) HeGenAI Research Lab
REM This script is used to start the n8n service

echo.
echo ===========================================
echo   HeGenAI - n8n Service Startup Script
echo ===========================================
echo.

REM Author Information
echo ===========================================
echo   This integrated package is created by: HeGenAI
echo   Author: HeGenAI
echo   E-mail: hesgenai@gmail.com
echo   Telegram: @hegenai
echo   YouTube: @lunare-mcn
echo ===========================================
echo.

REM Usage Disclaimer
echo ===========================================
echo   Usage Disclaimer:
echo   Please refer to official project and model pages for licensing information.
echo   This integrated package is for experience, academic, and research use only.
echo ===========================================
echo.

REM Change to the directory where this batch file is located
cd /d "%~dp0"

echo Starting n8n service...
docker-compose -f docker-compose-en.yml up -d

if %errorlevel% equ 0 (
    echo.
    echo ===========================================
    echo   n8n service started successfully!
    echo   n8n should be available at http://127.0.0.1:5678
    echo ===========================================
) else (
    echo.
    echo ===========================================
    echo   Error: n8n service failed to start
    echo ===========================================
)

echo.
pause