#!/bin/bash

# 测试同步脚本
# 功能：手动测试 content 文件夹同步功能

REPO_PATH="/home/txr/code/quartz"
SYNC_SCRIPT="$REPO_PATH/sync-content.sh"

echo "🧪 测试 Content 文件夹同步功能"
echo "=================================="

# 检查脚本是否存在
if [ ! -f "$SYNC_SCRIPT" ]; then
    echo "❌ 错误：同步脚本不存在: $SYNC_SCRIPT"
    exit 1
fi

# 检查脚本权限
if [ ! -x "$SYNC_SCRIPT" ]; then
    echo "⚠️  脚本没有执行权限，正在添加..."
    chmod +x "$SYNC_SCRIPT"
fi

echo "✅ 同步脚本准备就绪"
echo ""

# 显示当前 Git 状态
echo "📊 当前 Git 状态："
git status --porcelain

echo ""
echo "🔄 开始测试同步..."

# 执行同步脚本
if "$SYNC_SCRIPT"; then
    echo ""
    echo "✅ 测试成功！"
    echo ""
    echo "📝 查看日志："
    if [ -f "$REPO_PATH/sync.log" ]; then
        tail -10 "$REPO_PATH/sync.log"
    else
        echo "暂无日志"
    fi
else
    echo ""
    echo "❌ 测试失败！"
    echo "请检查错误信息并修复问题"
    exit 1
fi
