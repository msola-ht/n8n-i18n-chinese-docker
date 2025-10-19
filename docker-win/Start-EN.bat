@echo off
REM Copyright (c) Lao He's AIGC Research Lab
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

echo -------------------------------------------
echo   Preparing to start n8n service...
echo -------------------------------------------
echo.

REM Check if Docker Desktop is running
echo 1. Checking Docker Desktop status...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo Error: Docker Desktop or Docker service is not running.
    echo Please ensure Docker Desktop is started and running correctly, then try again.
    echo.
    pause
    exit /b 1
)
echo Docker Desktop is running.
echo.

REM Check if .env file exists
echo 2. Checking .env configuration file...
if not exist .env (
    echo.
    echo Warning: .env file not found!
    echo Docker Compose will not be able to load environment variables, and the service may not start correctly.
    echo Please create or confirm the .env file in the current directory and configure the necessary environment variables.
    echo It is strongly recommended to create this file to ensure proper service operation.
    echo.
    pause
    REM Do not exit, let the user decide whether to continue
) else (
    echo .env file found.
)
echo.

REM New: User chooses action
echo -------------------------------------------
echo   Please select an action:
echo   1. Start n8n service directly (faster if image is already up-to-date)
echo   2. Update n8n image to the latest version and start (recommended for regular updates)
echo -------------------------------------------
echo.

choice /c 12 /m "Enter your choice (1 or 2):"

if %errorlevel% equ 1 goto :START_SERVICE_DIRECTLY
if %errorlevel% equ 2 goto :UPDATE_AND_START_SERVICE

:START_SERVICE_DIRECTLY
echo.
echo 3. You chose to start the n8n service directly.
echo    Executing docker-compose up -d to start n8n service...
echo    (This process may take some time)
echo.
docker-compose -f docker-compose-cn.yml up -d
goto :CHECK_STATUS

:UPDATE_AND_START_SERVICE
echo.
echo 3. You chose to update the n8n image and start.
echo    Pulling the latest n8n image...
echo    (This process may take some time, depending on network conditions and image size)
echo.
docker-compose -f docker-compose-en.yml pull
if %errorlevel% neq 0 (
    echo.
    echo Error: Failed to pull n8n image.
    echo Please check your network connection, Docker configuration, or Docker Hub access.
    echo.
    pause
    exit /b 1
)
echo n8n image has been updated to the latest version.
echo.
echo 4. Executing docker-compose up -d to start n8n service...
echo    (This process may take some time)
echo.
docker-compose -f docker-compose-en.yml up -d
goto :CHECK_STATUS

:CHECK_STATUS
if %errorlevel% equ 0 (
    echo.
    echo ===========================================
    echo   n8n service started successfully!
    echo   n8n should be available at http://127.0.0.1:5678.
    echo   Please visit this address in your browser.
    echo ===========================================
) else (
    echo.
    echo ===========================================
    echo   Error: n8n service failed to start.
    echo   Please check the error messages above, or review Docker Compose logs to resolve the issue.
    echo   Common issues: port conflicts, image download failure, .env configuration errors.
    echo ===========================================
)

echo.
echo -------------------------------------------
echo   Script execution finished.
echo -------------------------------------------
echo.
pause
