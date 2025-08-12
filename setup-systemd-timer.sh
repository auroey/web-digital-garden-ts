#!/bin/bash

# 使用 systemd 定时器设置自动同步
# 功能：为 content 文件夹同步设置 systemd 定时器

REPO_PATH="/home/txr/code/quartz"
SYNC_SCRIPT="$REPO_PATH/sync-content.sh"
SERVICE_NAME="quartz-sync"
TIMER_NAME="quartz-sync.timer"

echo "设置 systemd 定时器..."

# 检查脚本是否存在
if [ ! -f "$SYNC_SCRIPT" ]; then
    echo "错误：同步脚本不存在: $SYNC_SCRIPT"
    exit 1
fi

# 给脚本添加执行权限
chmod +x "$SYNC_SCRIPT"
echo "✅ 已添加执行权限"

# 创建 systemd 服务文件
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"
sudo tee "$SERVICE_FILE" > /dev/null << EOF
[Unit]
Description=Quartz Content Sync Service
After=network.target

[Service]
Type=oneshot
User=$USER
WorkingDirectory=$REPO_PATH
ExecStart=$SYNC_SCRIPT
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

echo "✅ 已创建服务文件: $SERVICE_FILE"

# 创建 systemd 定时器文件
TIMER_FILE="/etc/systemd/system/$TIMER_NAME"
sudo tee "$TIMER_FILE" > /dev/null << EOF
[Unit]
Description=Run Quartz sync every 5 minutes
Requires=$SERVICE_NAME.service

[Timer]
Unit=$SERVICE_NAME.service
OnCalendar=*:0/5
Persistent=true

[Install]
WantedBy=timers.target
EOF

echo "✅ 已创建定时器文件: $TIMER_FILE"

# 重新加载 systemd 配置
sudo systemctl daemon-reload

# 启用并启动定时器
sudo systemctl enable "$TIMER_NAME"
sudo systemctl start "$TIMER_NAME"

echo "✅ 定时器已启用并启动"

# 显示状态
echo ""
echo "📊 定时器状态："
sudo systemctl status "$TIMER_NAME" --no-pager -l

echo ""
echo "📝 说明："
echo "- 服务名称：$SERVICE_NAME"
echo "- 定时器名称：$TIMER_NAME"
echo "- 同步频率：每5分钟一次"
echo "- 日志文件：$REPO_PATH/sync.log"
echo "- 查看状态：sudo systemctl status $TIMER_NAME"
echo "- 查看日志：sudo journalctl -u $SERVICE_NAME"
echo "- 停止定时器：sudo systemctl stop $TIMER_NAME"
echo "- 禁用定时器：sudo systemctl disable $TIMER_NAME"
