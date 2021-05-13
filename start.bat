@echo off
echo ���ɱ��ݽű�...

set PYTHON=".\venv\Scripts\pythonw.exe"
set GENERATE_SCRIPT=".\generate-script.py"
set SIMPLIFY_LOG_SCRIPT=".\simplify-log.py"
set BACKUP_SCRIPT=".\backup.bat"
set LOG_DIR=".\log"
set LOG="%LOG_DIR%\backup.log"

%PYTHON% %GENERATE_SCRIPT%
if %ERRORLEVEL% EQU 0 (
    choice /c YN /m "�Ѹ��� \"config.yml\" ���ɱ��ݽű�. ȷ��ִ�б����� "
    if ERRORLEVEL 2 (
        echo ���ݱ�ȡ��.
        del %BACKUP_SCRIPT%
        pause
        exit
    )
    echo ������...
    if not exist %LOG_DIR% (
        mkdir %LOG_DIR%
    )else if exist %LOG% (
        del %LOG%
    )
    %BACKUP_SCRIPT%
    echo �������.
    del %BACKUP_SCRIPT%
    echo ����־.
    %PYTHON% %SIMPLIFY_LOG_SCRIPT%
    pause
) else (
    del %BACKUP_SCRIPT%
    echo ���ݽű�����ʧ��!
    pause
)