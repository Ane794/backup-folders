@echo off
echo 生成备份脚本...

set PYTHON=".\venv\Scripts\pythonw.exe"
set GENERATE_SCRIPT=".\generate-script.py"
set SIMPLIFY_LOG_SCRIPT=".\simplify-log.py"
set BACKUP_SCRIPT=".\backup.bat"
set LOG_DIR=".\log"
set LOG="%LOG_DIR%\backup.log"

%PYTHON% %GENERATE_SCRIPT%
if %ERRORLEVEL% EQU 0 (
    choice /c YN /m "已根据 \"config.yml\" 生成备份脚本. 确定执行备份吗 "
    if ERRORLEVEL 2 (
        echo 备份被取消.
        del %BACKUP_SCRIPT%
        pause
        exit
    )
    echo 备份中...
    if not exist %LOG_DIR% (
        mkdir %LOG_DIR%
    )else if exist %LOG% (
        del %LOG%
    )
    %BACKUP_SCRIPT%
    echo 备份完成.
    del %BACKUP_SCRIPT%
    echo 简化日志.
    %PYTHON% %SIMPLIFY_LOG_SCRIPT%
    pause
) else (
    del %BACKUP_SCRIPT%
    echo 备份脚本生成失败!
    pause
)