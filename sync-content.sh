#!/bin/bash

# Content 文件夹自动同步脚本
# 功能：检测 content 文件夹变化并自动推送到 GitHub

set -e  # 遇到错误时退出

# 配置变量
REPO_PATH="/home/txr/code/quartz"
CONTENT_PATH="$REPO_PATH/content"
LOG_FILE="$REPO_PATH/sync.log"
BRANCH="main"
REMOTE="origin"

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 检查是否在正确的目录
cd "$REPO_PATH" || {
    log "错误：无法进入仓库目录 $REPO_PATH"
    exit 1
}

log "开始检查 content 文件夹变化..."

# 检查是否有未提交的更改（包括新文件）
if git diff --quiet HEAD -- "$CONTENT_PATH" && [ -z "$(git ls-files --others --exclude-standard "$CONTENT_PATH")" ]; then
    log "content 文件夹没有变化，无需同步"
    exit 0
fi

log "检测到 content 文件夹有变化，开始同步..."

# 添加所有 content 文件夹的更改
git add "$CONTENT_PATH"

# 检查是否有实际需要提交的文件
if git diff --cached --quiet; then
    log "没有需要提交的文件"
    exit 0
fi

# 获取变更的文件列表
CHANGED_FILES=$(git diff --cached --name-only)
log "变更的文件："
echo "$CHANGED_FILES" | while read -r file; do
    log "  - $file"
done

# 提交更改
COMMIT_MSG="自动同步: $(date '+%Y-%m-%d %H:%M:%S') 更新 content 文件夹"
git commit -m "$COMMIT_MSG"

log "已提交更改：$COMMIT_MSG"

# 先拉取最新更改
log "拉取最新更改..."
if ! git pull "$REMOTE" "$BRANCH" --rebase; then
    log "⚠️  拉取失败，尝试合并..."
    if ! git pull "$REMOTE" "$BRANCH"; then
        log "❌ 拉取失败，无法推送"
        exit 1
    fi
fi

# 推送到远程仓库
log "推送到远程仓库..."
if git push "$REMOTE" "$BRANCH"; then
    log "✅ 成功推送到 GitHub"
else
    log "❌ 推送失败"
    exit 1
fi

log "同步完成！"
