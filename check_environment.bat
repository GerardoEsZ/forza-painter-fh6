@echo off
setlocal
cd /d "%~dp0"
set "PYTHONDONTWRITEBYTECODE=1"
set "VENV_PYTHON=%CD%\.venv\Scripts\python.exe"

if not exist "%VENV_PYTHON%" (
    echo Project virtual environment was not found.
    echo Run install_dependencies.bat first.
    pause
    exit /b 1
)

echo Using project Python: "%VENV_PYTHON%"
"%VENV_PYTHON%" -c "import sys, psutil, win32api; print('Core OK:', sys.version.split()[0]); print('Executable:', sys.executable)"
if errorlevel 1 (
    echo Core dependencies are missing. Run install_dependencies.bat.
    pause
    exit /b 1
)

"%VENV_PYTHON%" -c "import cv2, numpy; print('Preview OK:', numpy.__version__, cv2.__version__)" 2>nul
if errorlevel 1 (
    echo Preview is unavailable. This does not block JSON generation or FH6 import.
)

pause
exit /b 0
