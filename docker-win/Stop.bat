@echo off
REM ��Ȩ���� (c) �Ϻε�AIGC�о���
REM ���ű�����ֹͣ���Ƴ� n8n ����

echo.
echo ===========================================
echo   �Ϻε�AIGC�о��� - n8n ����ֹͣ�ű�
echo ===========================================
echo.

REM ������Ϣ
echo ===========================================
echo   ���ߣ�����ʦ��AIGC
echo   ΢�ţ�hlsaigc
echo   �罻ƽ̨��Bվ��������С����: @����ʦ��AIGC
echo   YouTube: @lunare-mcn
echo ===========================================
echo.

REM ʹ������
echo ===========================================
echo   ʹ��������
echo   �����в��Ĺٷ���Ŀ��ģ��ҳ���˽���Ȩ���
echo   ���ϰ����������顢ѧ�����о�ʹ��
echo ===========================================
echo.

REM �л�����ǰ�������ļ����ڵ�Ŀ¼
cd /d "%~dp0"

echo.
echo ===========================================
echo   ����ֹͣ���Ƴ� n8n ����...
echo ===========================================
echo.

REM ����Ҫ������ Docker Compose �ļ�
REM ע�⣺����ͬʱָ���� docker-compose-cn.yml �� docker-compose-en.yml
REM ������ķ���ֻ������һ���ļ����壬������Ҫ����
set "COMPOSE_FILES=-f docker-compose-cn.yml -f docker-compose-en.yml"
set "STOP_OPTIONS=" REM ֹͣѡ�ĿǰΪ�գ���Ĭ��ֹͣ��Ϊ

REM ��� Docker Desktop �Ƿ���������
echo ���ڼ�� Docker Desktop ״̬...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ����Docker Desktop �� Docker ����δ���С�
    echo �޷�ֹͣ����
    echo.
    pause
    exit /b 1
)
echo Docker Desktop �������С�

echo.
echo -------------------------------------------
echo   ��ֹͣ�ķ����ļ�: docker-compose-cn.yml, docker-compose-en.yml
echo   ֹͣѡ��: %STOP_OPTIONS%
echo -------------------------------------------
echo.

REM !!! �����һ������ʾ��ǰ����Ŀ¼ !!!
echo ��ǰ����Ŀ¼: %cd%
echo.

echo ����ִ�� docker-compose %COMPOSE_FILES% down %STOP_OPTIONS% ...
docker-compose %COMPOSE_FILES% down %STOP_OPTIONS%

if %errorlevel% equ 0 (
    echo.
    echo ===========================================
    echo   �����ѳɹ�ֹͣ���Ƴ���
    echo ===========================================
) else (
    echo.
    echo ===========================================
    echo   ����ֹͣ����ʧ�ܡ�
    echo   ��������������Ϣ�Խ�����⡣
    echo ===========================================
)

echo.
echo ��������˳�...
pause
