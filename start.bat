@echo ���ɱ��ݽű�...
@.\venv\Scripts\pythonw.exe generate-script.py
@if %ERRORLEVEL% EQU 0 (
    choice /c YN /m "�Ѹ��� \"root.cfg\"\"dirs.cfg\" ���ɱ��ݽű�. ȷ��ִ�б����� "
    if ERRORLEVEL 2 (
        echo ���ݱ�ȡ��.
        del backup.bat
        pause
        exit
    )
    echo ������...
    if not exist log (
        mkdir log
    )
    @powershell -command ".\backup.bat | tee log\backup.log"
    @if %ERRORLEVEL% NEQ 0 (
        backup.bat > log\backup.log
    )
    echo �������.
    del backup.bat
    echo ����־.
    .\venv\Scripts\pythonw.exe simplify-log.py
    pause
) else (
    del backup.bat
    echo ���ݽű�����ʧ��!
    pause
)