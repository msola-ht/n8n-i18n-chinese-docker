@echo off
REM ��Ȩ���� (c) �Ϻε�AIGC�о���
REM ���ű��������� n8n ����

echo.
echo ===========================================
echo   �Ϻε�AIGC�о��� - n8n ���������ű�
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

echo -------------------------------------------
echo   ����׼������ n8n ����...
echo -------------------------------------------
echo.

REM ��� Docker Desktop �Ƿ���������
echo 1. ���ڼ�� Docker Desktop ״̬...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ����Docker Desktop �� Docker ����δ���С�
    echo ��ȷ�� Docker Desktop ���������������У�Ȼ�����ԡ�
    echo.
    pause
    exit /b 1
)
echo Docker Desktop �������С�
echo.

REM ��� .env �ļ��Ƿ����
echo 2. ���ڼ�� .env �����ļ�...
if not exist .env (
    echo.
    echo ���棺δ�ҵ� .env �ļ���
    echo Docker Compose ���޷����ػ�����������������޷�����������
    echo ���ڵ�ǰĿ¼������ȷ�� .env �ļ��Ƿ���ڣ������ú�����Ļ���������
    echo ǿ�ҽ������������ļ���ȷ�������������С�
    echo.
    pause
    REM ���˳������û������Ƿ����
) else (
    echo .env �ļ����ҵ���
)
echo.

REM �������û�ѡ�����
echo -------------------------------------------
echo   ��ѡ�������
echo   1. ֱ������ n8n ���� (��������������£����������)
echo   2. ���� n8n �������°沢���� (�Ƽ����ڸ��£�ȷ����������)
echo -------------------------------------------
echo.

choice /c 12 /m "����������ѡ�� (1 �� 2)��"

if %errorlevel% equ 1 goto :START_SERVICE_DIRECTLY
if %errorlevel% equ 2 goto :UPDATE_AND_START_SERVICE

:START_SERVICE_DIRECTLY
echo.
echo 3. ��ѡ����ֱ������ n8n ����
echo    ����ִ�� docker-compose up -d ���� n8n ����...
echo    (�˹��̿�����ҪһЩʱ��)
echo.
docker-compose -f docker-compose-cn.yml up -d
goto :CHECK_STATUS

:UPDATE_AND_START_SERVICE
echo.
echo 3. ��ѡ���˸��� n8n ����������
echo    ������ȡ n8n ���¾���...
echo    (�˹��̿�����ҪһЩʱ�䣬ȡ��������״���;����С)
echo.
docker-compose -f docker-compose-cn.yml pull
if %errorlevel% neq 0 (
    echo.
    echo ������ȡ n8n ����ʧ�ܡ�
    echo �����������ӡ�Docker ���û� Docker Hub ����Ȩ�ޡ�
    echo.
    pause
    exit /b 1
)
echo n8n �����Ѹ��µ����°档
echo.
echo 4. ����ִ�� docker-compose up -d ���� n8n ����...
echo    (�˹��̿�����ҪһЩʱ��)
echo.
docker-compose -f docker-compose-cn.yml up -d
goto :CHECK_STATUS

:CHECK_STATUS
if %errorlevel% equ 0 (
    echo.
    echo ===========================================
    echo   n8n ���������ɹ���
    echo   n8n Ӧ���� http://127.0.0.1:5678 �Ͽ��á�
    echo   ����������з��ʴ˵�ַ��
    echo ===========================================
) else (
    echo.
    echo ===========================================
    echo   ����n8n ��������ʧ�ܡ�
    echo   ��������������Ϣ����鿴 Docker Compose ��־�Խ�����⡣
    echo   �������⣺�˿ڳ�ͻ����������ʧ�ܡ�.env ���ô���
    echo ===========================================
)

echo.
echo -------------------------------------------
echo   �ű�ִ����ϡ�
echo -------------------------------------------
echo.
pause
