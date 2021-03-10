@echo 生成备份脚本...
@.\venv\Scripts\pythonw.exe generate-script.py
@if %ERRORLEVEL% == 0 (
    choice /c YN /m "已根据 \"root.cfg\"\"dirs.cfg\" 生成备份脚本. 确定执行备份吗 "
    if ERRORLEVEL 2 (
        echo 备份被取消.
        del backup.bat
        pause
        exit
    )
    echo 备份中...
    if not exist log (
        mkdir log
    )
    backup.bat > log/backup.log
    echo 备份完成.
    del backup.bat
    echo 简化日志.
    .\venv\Scripts\pythonw.exe simplify-log.py
    pause
) else (
    echo 备份脚本生成失败!
    pause
)