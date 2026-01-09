@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
echo =================================
echo 导入Docker镜像脚本
REM Docker Compose 启动脚本
REM 版权所有 (c) 老何的AIGC研究室
echo =================================
echo.

:: 切换到脚本所在目录
cd /d "%~dp0"

echo 当前目录: %cd%
echo.

:: 检查Docker是否运行
echo 检查Docker状态...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：Docker未运行或未安装！
    echo 请先启动Docker Desktop
    pause
    exit /b 1
)
echo  Docker已运行
echo.

:: 查找当前目录下的所有镜像文件
echo =================================
echo 扫描当前目录的镜像文件...
echo =================================
echo.

set count=0

:: 遍历所有 .tar 和 .tar.gz 文件
for %%f in (*.tar *.tar.gz) do (
    set /a count+=1
    echo 发现镜像文件: %%f
)

echo.
echo 共找到 %count% 个镜像文件
echo.

:: 如果没有找到镜像文件，退出
if %count%==0 (
    echo 警告：当前目录下没有找到任何 .tar 或 .tar.gz 镜像文件！
    echo 请确保镜像文件位于: %cd%
    pause
    exit /b 1
)

echo =================================
echo 开始导入镜像...
echo =================================
echo.

set success=0
set failed=0

:: 导入所有镜像文件
for %%f in (*.tar *.tar.gz) do (
    echo -----------------------------------
    echo 正在导入: %%f
    echo -----------------------------------
    docker load -i "%%f"

    if !errorlevel! equ 0 (
        echo  %%f 导入成功
        set /a success+=1
    ) else (
        echo  %%f 导入失败
        set /a failed+=1
    )
    echo.
)

:: 显示导入统计
echo =================================
echo 导入统计
echo =================================
echo  成功: %success% 个
echo  失败: %failed% 个
echo  总计: %count% 个
echo.

echo =================================
echo 导入完成！
echo =================================
echo.
echo 现在可以使用 docker-compose up -d 启动服务

echo.
echo 启动完毕.按任意键退出.
echo 版权所有 (c) 老何的AIGC研究室
pause