@echo off
setlocal
color 0F
title forza-painter FH6
set "PYTHONDONTWRITEBYTECODE=1"

cd /d "%~dp0"
set "ARG1=%~1"
set "VENV_PYTHON=%CD%\.venv\Scripts\python.exe"

IF NOT "%ARG1%" == "" GOTO Dragged

set /p ARG1="[MANUAL MODE] Paste the image path: "

:Dragged
call scripts\ensure_venv.bat
if errorlevel 1 (
    pause
    exit /b 1
)

"%VENV_PYTHON%" src\app.py "%ARG1%"
cls
color 0F
echo FINISHED!
pause
exit /b %errorlevel%
