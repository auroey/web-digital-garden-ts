@echo off
REM === Set your repository path ===
cd /d D:\2_ADD\Exp\Nutstore\ResearchNotes

REM === Git user information (optional if already configured globally) ===
git config user.name "auroey"
git config user.email "zy181982414@gmail.com"

REM === Pull the latest changes from remote (to prevent conflicts) ===
git pull origin main

REM === Build the site to update latest updates and recommendations ===
echo Building site to update latest updates and recommendations...
call npm run quartz build
if %errorlevel% neq 0 (
    echo Build failed, but continuing with git operations...
)

REM === Add all changes including built files ===
git add .

REM === Commit changes (skip if no changes) ===
git commit -m "Auto commit: %date% %time% - Updated latest updates and recommendations" || echo No changes to commit

REM === Push to GitHub ===
git push origin main

echo Auto push completed successfully!
