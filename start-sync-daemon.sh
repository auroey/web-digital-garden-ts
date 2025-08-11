#!/bin/bash

# 后台同步守护进程脚本
# 功能：在后台运行，按指定时间间隔自动同步
# 不需要 sudo 权限

REPO_PATH="/home/txr/code/quartz"
SYNC_SCRIPT="$REPO_PATH/sync-content.sh"
PID_FILE="$REPO_PATH/sync-daemon.pid"
LOG_FILE="$REPO_PATH/sync-daemon.log"
INTERVAL=180  # 180分钟 = 3小时

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 检查脚本是否存在
if [ ! -f "$SYNC_SCRIPT" ]; then
    log "错误：同步脚本不存在: $SYNC_SCRIPT"
    exit 1
fi

# 给脚本添加执行权限
chmod +x "$SYNC_SCRIPT"

# 检查是否已经在运行
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p "$PID" > /dev/null 2>&1; then
        log "同步守护进程已经在运行 (PID: $PID)"
        log "如需重启，请先运行: ./stop-sync-daemon.sh"
        exit 1
    else
        log "发现过期的 PID 文件，正在清理..."
        rm -f "$PID_FILE"
    fi
fi

# 启动守护进程
log "启动同步守护进程，同步间隔: ${INTERVAL}分钟"
log "PID 文件: $PID_FILE"
log "日志文件: $LOG_FILE"

# 后台运行守护进程
(
    while true; do
        log "等待 ${INTERVAL} 分钟后执行同步..."
        sleep $((INTERVAL * 60))
        
        log "执行定时同步..."
        if "$SYNC_SCRIPT"; then
            log "✅ 同步完成"
        else
            log "❌ 同步失败"
        fi
        
        log "继续等待下次同步..."
    done
) > "$LOG_FILE" 2>&1 &

# 保存 PID
echo $! > "$PID_FILE"
log "✅ 同步守护进程已启动 (PID: $!)"
log "守护进程日志: tail -f $LOG_FILE"
log "停止守护进程: ./stop-sync-daemon.sh"
