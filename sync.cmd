@echo off
setlocal

cd /d "%~dp0"

echo Syncing Obsidian notes to the web...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\sync-content.ps1"
set "SYNC_EXIT_CODE=%ERRORLEVEL%"

echo.
if not "%SYNC_EXIT_CODE%"=="0" (
  echo Sync failed with exit code %SYNC_EXIT_CODE%.
) else (
  echo Sync finished.
)

echo.
pause
exit /b %SYNC_EXIT_CODE%
