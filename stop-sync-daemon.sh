#!/bin/bash

# 停止同步守护进程脚本
# 功能：停止后台运行的同步守护进程

REPO_PATH="/home/txr/code/quartz"
PID_FILE="$REPO_PATH/sync-daemon.pid"
LOG_FILE="$REPO_PATH/sync-daemon.log"

echo "停止同步守护进程..."

# 检查 PID 文件是否存在
if [ ! -f "$PID_FILE" ]; then
    echo "⚠️  没有找到 PID 文件，守护进程可能没有运行"
    exit 0
fi

# 读取 PID
PID=$(cat "$PID_FILE")

# 检查进程是否在运行
if ps -p "$PID" > /dev/null 2>&1; then
    echo "正在停止进程 (PID: $PID)..."
    
    # 尝试优雅停止
    kill "$PID"
    
    # 等待进程结束
    sleep 2
    
    # 检查是否还在运行
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "进程仍在运行，强制停止..."
        kill -9 "$PID"
        sleep 1
    fi
    
    # 最终检查
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "❌ 无法停止进程"
        exit 1
    else
        echo "✅ 进程已停止"
    fi
else
    echo "⚠️  进程 (PID: $PID) 不在运行"
fi

# 清理 PID 文件
rm -f "$PID_FILE"
echo "✅ 已清理 PID 文件"

# 显示守护进程日志的最后几行
if [ -f "$LOG_FILE" ]; then
    echo ""
    echo "📝 守护进程日志 (最后10行):"
    tail -10 "$LOG_FILE"
fi

echo "✅ 同步守护进程已停止"
