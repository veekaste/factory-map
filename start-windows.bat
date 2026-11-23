@echo off
rem Factory Map website: double-click to set up (first time) and start. Keep the window open while you play.
cd /d "%~dp0web"
set "PY="
python -c "import sys" >nul 2>nul && set "PY=python"
if not defined PY py -3 -c "import sys" >nul 2>nul && set "PY=py -3"
if not defined PY (
  echo Python is not installed. Get it from https://www.python.org/downloads/ and run this again.
  pause
  exit /b 1
)
.venv\Scripts\python -m pip --version >/dev/null 2>/dev/null || (
  echo First start: setting up, this takes a minute...
  if exist .venv rmdir /s /q .venv
  %PY% -m venv .venv || goto fail
)
.venv\Scripts\python -m pip install -q --disable-pip-version-check -r requirements.txt || goto fail
if not exist site.json copy site.example.json site.json >nul
set OPEN_BROWSER=1
.venv\Scripts\python server.py
pause
exit /b
:fail
echo Setup failed, see the message above. Common fixes: check your internet connection, or move this folder somewhere without special characters in the path.
pause
