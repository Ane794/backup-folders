@echo off
echo ���� "config.yml" ���ɱ��ݽű�...
echo ����������Ŀ¼:

set GENERATE_SCRIPT=".\generate-script.py"
set SIMPLIFY_LOG_SCRIPT=".\simplify-log.py"
set BACKUP_SCRIPT=".\backup.bat"
set LOG_DIR=".\log"
set LOG="%LOG_DIR%\backup.log"

python %GENERATE_SCRIPT%
if %ERRORLEVEL% EQU 0 ( :: generate-script.py ����ִ�����.
    if not exist %BACKUP_SCRIPT% ( :: �Ϸ���Ϊ 0, generate-script.py �����ɱ��ݽű�.
        echo �����ںϷ��ı�����! ���� conf\config.yml �ļ�������.
        goto end
    )
    choice /c YN /m "�����ɱ��ݽű�. ȷ��ִ�б����� "
    if ERRORLEVEL 2 (
        echo ���ݱ�ȡ��.
        goto end
    )
    echo ������...
    if not exist %LOG_DIR% (
        mkdir %LOG_DIR%
    )else if exist %LOG% (
        del %LOG%
    )
    %BACKUP_SCRIPT%
    echo �������.
    if exist %LOG% (
        echo ����־...
        python %SIMPLIFY_LOG_SCRIPT%
    )
) else (
    echo ���ݽű�����ʧ��! �����Ƿ���������Ч�� Python ��������, ����װ�˳��������ģ��.
)

:end
if exist %BACKUP_SCRIPT% (
    del %BACKUP_SCRIPT%
)
pause