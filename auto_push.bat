@echo off
REM === Set your repository path ===
cd /d D:\2_ADD\Exp\Nutstore\ResearchNotes

REM === Git user information (optional if already configured globally) ===
git config user.name "auroey"
git config user.email "zy181982414@gmail.com"

REM === Pull the latest changes from remote (to prevent conflicts) ===
git pull origin main

REM === Add all changes ===
git add .

REM === Commit changes (skip if no changes) ===
git commit -m "Auto commit: %date% %time%" || echo No changes to commit

REM === Push to GitHub ===
git push origin main
