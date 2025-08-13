@echo off
REM === 设置你的仓库路径 ===
cd /d D:\2_ADD\Exp\Nutstore\ResearchNotes

REM === Git 用户信息（如果全局已配置可省略）===
git config user.name "auroey"
git config user.email "zy181982414@gmail.com"

REM === 拉取最新远程变动（可防止冲突）===
git pull origin main

REM === 添加所有变更 ===
git add .

REM === 提交更改（若无更改则跳过）===
git commit -m "自动提交：%date% %time%" || echo 没有需要提交的更改

REM === 推送到 GitHub ===
git push origin main
