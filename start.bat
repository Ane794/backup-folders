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

choice /c YN /m "已生成备份脚本. 确定执行备份吗 "
if ERRORLEVEL 2 (
  echo 备份被取消.
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
  echo 根据 "config.yml" 生成备份脚本...
  echo 将备份以下目录:
  python %GENERATE_SCRIPT%

  if %ERRORLEVEL% NEQ 0 (
    echo 备份脚本生成失败! 请检查是否配置了有效的 Python 环境变量, 并安装了程序所需的模块.
    exit /b 1
  )

  if not exist %BACKUP_SCRIPT% ( :: 合法项为 0, generate-script.py 不生成备份脚本.
    echo 不存在合法的备份项! 请检查 conf\config.yml 文件的配置.
    exit /b 1
  )
goto:eof

:initLog
  echo 初始化日志...
  if not exist %LOG_DIR% (
    mkdir %LOG_DIR%
  )else if exist %LOG% (
    del %LOG%
  )
goto:eof

:backupFolders
  echo 备份中...
  call %BACKUP_SCRIPT%
  if %ERRORLEVEL% EQU -1 (
    echo 备份被用户中断.
    exit /b -1
  ) else (
    echo 备份完成.
  )
goto:eof

:simplifyLog
  if exist %LOG% (
    echo 简化日志...
    python %SIMPLIFY_LOG_SCRIPT%
  )
goto:eof
