@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion
REM Docker Compose 镜像更新脚本
REM 版权所有 (c) 何老师的AIGC研究室

REM 设置错误时暂停
set ERROR_PAUSE=1

echo 何老师的AIGC研究室 - Docker服务管理
echo.

REM 检测并更新 n8n 版本号
echo ========================================
echo 正在检测 n8n-i18n-chinese 最新版本...
echo ========================================
echo.

REM 使用 PowerShell 调用 GitHub API 获取最新 release（带重试机制）
set RETRY_COUNT=0
set MAX_RETRIES=3

:GET_VERSION_RETRY
echo $ProgressPreference = 'SilentlyContinue' > get_version.ps1
echo try { >> get_version.ps1
echo   $headers = @{'User-Agent' = 'n8n-update-script'} >> get_version.ps1
echo   $response = Invoke-RestMethod -Uri 'https://api.github.com/repos/other-blowsnow/n8n-i18n-chinese/releases/latest' -Headers $headers -TimeoutSec 10 >> get_version.ps1
echo   $tag = $response.tag_name >> get_version.ps1
echo   if ($tag -like 'n8n@*') { $tag = $tag -replace 'n8n@', '' } >> get_version.ps1
echo   Write-Output $tag >> get_version.ps1
echo } catch { >> get_version.ps1
echo   Write-Output '' >> get_version.ps1
echo } >> get_version.ps1

for /f "tokens=*" %%i in ('powershell -ExecutionPolicy Bypass -File get_version.ps1 2^>nul') do set LATEST_VERSION=%%i
del get_version.ps1 2>nul

REM 检查是否获取成功
if "%LATEST_VERSION%"=="" (
    set /a RETRY_COUNT+=1
    if !RETRY_COUNT! leq %MAX_RETRIES% (
        echo 获取版本号失败，正在重试 ^(!RETRY_COUNT!/%MAX_RETRIES%^)...
        timeout /t 2 /nobreak >nul
        goto GET_VERSION_RETRY
    ) else (
        echo.
        echo 警告：已重试 %MAX_RETRIES% 次，仍无法获取最新版本号
        echo 可能的原因：网络连接问题或 GitHub API 访问受限
        echo.
        goto SKIP_VERSION_CHECK
    )
)

echo GitHub 最新版本: %LATEST_VERSION%

REM 从 .ENV 文件读取当前版本号
for /f "tokens=1,2 delims==" %%a in ('type .env ^| findstr /B "N8N_VERSION="') do (
    set CURRENT_VERSION=%%b
)

echo .ENV 当前版本: %CURRENT_VERSION%
echo.

REM 比较版本号
if "%LATEST_VERSION%"=="%CURRENT_VERSION%" (
    echo ✓ 版本号一致，无需更新
    echo.
) else (
    echo ⚠ 发现新版本，正在更新 .ENV 文件...
    echo.

    REM 使用 PowerShell 更新 .env 文件（指定UTF-8编码）
    powershell -Command "[System.IO.File]::ReadAllText('.env', [System.Text.Encoding]::UTF8) -replace 'N8N_VERSION=%CURRENT_VERSION%', 'N8N_VERSION=%LATEST_VERSION%' | ForEach-Object { [System.IO.File]::WriteAllText('.env', $_, [System.Text.Encoding]::UTF8) }"

    if errorlevel 1 (
        echo 警告：更新 .env 文件时出现错误
    ) else (
        echo ✓ 已将 .ENV 中的版本从 %CURRENT_VERSION% 更新为 %LATEST_VERSION%
    )
    echo.
)

:SKIP_VERSION_CHECK
echo ========================================
echo.

if exist docker-compose.yml (
    set COMPOSE_FILE=docker-compose-cn.yml
) else if exist docker-compose-cn.yml (
    set COMPOSE_FILE=docker-compose-cn.yml
) else (
    echo 错误：未找到 docker-compose 配置文件
    pause
    exit /b 1
)

echo 正在启动服务...

REM 启动服务并立即显示日志（不会在后台运行）
docker-compose -f %COMPOSE_FILE% pull
if errorlevel 1 (
    echo.
    echo 警告：docker-compose 执行过程中出现错误
    echo 错误代码：!errorlevel!
)

REM 当用户按Ctrl+C后，脚本会执行到这里
echo.
echo 启动完毕.按任意键退出.
echo 版权所有 (c) 何老师的AIGC研究室
pause

