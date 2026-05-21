@echo off
setlocal
cd /d "%~dp0"
set "PYTHONDONTWRITEBYTECODE=1"
set "VENV_PYTHON=%CD%\.venv\Scripts\python.exe"
call scripts\ensure_venv.bat
if errorlevel 1 (
    pause
    exit /b 1
)
"%VENV_PYTHON%" src\app.py
pause
exit /b %errorlevel%
