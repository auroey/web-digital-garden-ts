#!/bin/bash

# 检查同步守护进程状态脚本
# 功能：显示守护进程的运行状态和日志

REPO_PATH="/home/txr/code/quartz"
PID_FILE="$REPO_PATH/sync-daemon.pid"
LOG_FILE="$REPO_PATH/sync-daemon.log"

echo "🔄 同步守护进程状态检查"
echo "=========================="

# 检查 PID 文件
if [ ! -f "$PID_FILE" ]; then
    echo "❌ 状态：未运行"
    echo "   原因：没有找到 PID 文件"
    echo ""
    echo "💡 启动命令：./start-sync-daemon.sh"
    exit 0
fi

# 读取 PID
PID=$(cat "$PID_FILE")
echo "📋 PID 文件：$PID_FILE"
echo "🆔 进程 ID：$PID"

# 检查进程是否在运行
if ps -p "$PID" > /dev/null 2>&1; then
    echo "✅ 状态：正在运行"
    
    # 显示进程详细信息
    echo ""
    echo "📊 进程信息："
    ps -p "$PID" -o pid,ppid,cmd,etime,pcpu,pmem
    
    # 显示守护进程日志
    if [ -f "$LOG_FILE" ]; then
        echo ""
        echo "📝 守护进程日志 (最后15行):"
        tail -15 "$LOG_FILE"
    fi
    
    # 显示下次同步时间
    echo ""
    echo "⏰ 同步配置："
    echo "   间隔：180分钟 (3小时)"
    echo "   下次同步：约3小时后"
    
else
    echo "❌ 状态：进程不存在"
    echo "   原因：PID $PID 对应的进程不存在"
    echo ""
    echo "🧹 清理建议："
    echo "   ./stop-sync-daemon.sh"
    echo ""
    echo "🚀 重新启动："
    echo "   ./start-sync-daemon.sh"
fi

echo ""
echo "📁 相关文件："
echo "   PID 文件：$PID_FILE"
echo "   日志文件：$LOG_FILE"
echo "   同步脚本：$REPO_PATH/sync-content.sh"
