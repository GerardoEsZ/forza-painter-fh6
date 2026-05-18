@echo off
setlocal
cd /d "%~dp0"
set "PYTHONDONTWRITEBYTECODE=1"

call :find_python
if errorlevel 1 (
    echo No usable Python was found. Install 64-bit Python 3.10 to 3.13, then run this again.
    pause
    exit /b 1
)

echo Using %PYTHON_CMD%
%PYTHON_CMD% -m pip install --upgrade pip
if errorlevel 1 goto Failed

%PYTHON_CMD% -m pip install -r requirements.txt
if errorlevel 1 goto Failed

%PYTHON_CMD% -c "import sys; raise SystemExit(0 if sys.version_info < (3, 13) else 1)" >nul 2>nul
if errorlevel 1 (
    echo.
    echo Optional preview dependencies were skipped on Python 3.13 or newer.
    echo JSON generation and FH6 import can still run. If preview is required, use Python 3.12.
) else (
    echo.
    echo Installing optional preview dependencies for image/JSON preview...
    %PYTHON_CMD% -m pip install -r requirements-preview.txt
    if errorlevel 1 (
        echo Optional preview dependencies failed. The app can still generate and import JSON.
    )
)

echo.
echo Dependencies installed.
pause
exit /b 0

:Failed
echo.
echo Dependency installation failed. Check the Python version and network, then try again.
pause
exit /b 1

:find_python
for %%V in (3.12 3.11 3.10 3.13) do (
    py -%%V -c "import sys; raise SystemExit(0 if sys.maxsize > 2**32 else 1)" >nul 2>nul
    if not errorlevel 1 (
        set "PYTHON_CMD=py -%%V"
        exit /b 0
    )
)
python -c "import sys; raise SystemExit(0 if sys.version_info >= (3, 10) and sys.maxsize > 2**32 else 1)" >nul 2>nul
if not errorlevel 1 (
    set "PYTHON_CMD=python"
    exit /b 0
)
exit /b 1
