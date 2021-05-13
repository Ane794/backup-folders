@echo off
echo 根据 "config.yml" 生成备份脚本...
echo 将备份以下目录:

set GENERATE_SCRIPT=".\generate-script.py"
set SIMPLIFY_LOG_SCRIPT=".\simplify-log.py"
set BACKUP_SCRIPT=".\backup.bat"
set LOG_DIR=".\log"
set LOG="%LOG_DIR%\backup.log"

python %GENERATE_SCRIPT%
if %ERRORLEVEL% EQU 0 ( :: generate-script.py 正常执行完成.
    if not exist %BACKUP_SCRIPT% ( :: 合法项为 0, generate-script.py 不生成备份脚本.
        echo 不存在合法的备份项! 请检查 conf\config.yml 文件的配置.
        goto end
    )
    choice /c YN /m "已生成备份脚本. 确定执行备份吗 "
    if ERRORLEVEL 2 (
        echo 备份被取消.
        goto end
    )
    echo 备份中...
    if not exist %LOG_DIR% (
        mkdir %LOG_DIR%
    )else if exist %LOG% (
        del %LOG%
    )
    %BACKUP_SCRIPT%
    echo 备份完成.
    if exist %LOG% (
        echo 简化日志...
        python %SIMPLIFY_LOG_SCRIPT%
    )
) else (
    echo 备份脚本生成失败! 请检查是否配置了有效的 Python 环境变量, 并安装了程序所需的模块.
)

:end
if exist %BACKUP_SCRIPT% (
    del %BACKUP_SCRIPT%
)
pause