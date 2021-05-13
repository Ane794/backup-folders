@echo off

set GENERATE_SCRIPT=".\generate-script.py"
set SIMPLIFY_LOG_SCRIPT=".\simplify-log.py"
set BACKUP_SCRIPT=".\backup.bat"
set LOG_DIR=".\log"
set LOG="%LOG_DIR%\backup.log"

call:generateScript
if %ERRORLEVEL% NEQ 0 (
  goto end
)

choice /c YN /m "�����ɱ��ݽű�. ȷ��ִ�б����� "
if ERRORLEVEL 2 (
  echo ���ݱ�ȡ��.
  goto end
)

call:initLog

call:backupFolders
if %ERRORLEVEL% NEQ 0 (
  goto end
)

call:simplifyLog

:end
if exist %BACKUP_SCRIPT% (
  del %BACKUP_SCRIPT%
)
pause
exit /b


:generateScript
  echo ���� "config.yml" ���ɱ��ݽű�...
  echo ����������Ŀ¼:
  python %GENERATE_SCRIPT%

  if %ERRORLEVEL% NEQ 0 (
    echo ���ݽű�����ʧ��! �����Ƿ���������Ч�� Python ��������, ����װ�˳��������ģ��.
    exit /b 1
  )

  if not exist %BACKUP_SCRIPT% ( :: �Ϸ���Ϊ 0, generate-script.py �����ɱ��ݽű�.
    echo �����ںϷ��ı�����! ���� conf\config.yml �ļ�������.
    exit /b 1
  )
goto:eof

:initLog
  echo ��ʼ����־...
  if not exist %LOG_DIR% (
    mkdir %LOG_DIR%
  )else if exist %LOG% (
    del %LOG%
  )
goto:eof

:backupFolders
  echo ������...
  call %BACKUP_SCRIPT%
  if %ERRORLEVEL% EQU -1 (
    echo ���ݱ��û��ж�.
    exit /b -1
  ) else (
    echo �������.
  )
goto:eof

:simplifyLog
  if exist %LOG% (
    echo ����־...
    python %SIMPLIFY_LOG_SCRIPT%
  )
goto:eof
