#!/bin/bash

# 设置定时任务脚本
# 功能：为 content 文件夹同步设置定时任务

REPO_PATH="/home/txr/code/quartz"
SYNC_SCRIPT="$REPO_PATH/sync-content.sh"
CRON_JOB="*/180 * * * * $SYNC_SCRIPT"  # 每5分钟执行一次

echo "设置定时任务..."

# 检查脚本是否存在
if [ ! -f "$SYNC_SCRIPT" ]; then
    echo "错误：同步脚本不存在: $SYNC_SCRIPT"
    exit 1
fi

# 给脚本添加执行权限
chmod +x "$SYNC_SCRIPT"
echo "✅ 已添加执行权限"

# 创建临时 crontab 文件
TEMP_CRON=$(mktemp)

# 导出当前的 crontab
crontab -l 2>/dev/null > "$TEMP_CRON" || true

# 检查是否已经存在相同的任务
if grep -q "$SYNC_SCRIPT" "$TEMP_CRON"; then
    echo "⚠️  定时任务已存在，跳过添加"
else
    # 添加新的定时任务
    echo "$CRON_JOB" >> "$TEMP_CRON"
    echo "✅ 已添加定时任务：每5分钟同步一次"
fi

# 安装新的 crontab
crontab "$TEMP_CRON"

# 清理临时文件
rm "$TEMP_CRON"

echo "✅ 定时任务设置完成！"
echo "当前定时任务列表："
crontab -l

echo ""
echo "📝 说明："
echo "- 脚本将每5分钟检查一次 content 文件夹变化"
echo "- 日志文件：$REPO_PATH/sync.log"
echo "- 如需修改频率，请编辑此脚本中的 CRON_JOB 变量"
echo "- 如需停止，请运行：crontab -e 并删除相关行"
