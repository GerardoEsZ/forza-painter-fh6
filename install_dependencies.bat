@echo off
setlocal
cd /d "%~dp0"
set "PYTHONDONTWRITEBYTECODE=1"
call scripts\ensure_venv.bat
if errorlevel 1 (
    pause
    exit /b 1
)
pause
exit /b 0
