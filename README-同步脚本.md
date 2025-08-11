# Quartz Content 自动同步脚本使用说明

## 📋 概述

这个项目包含了一套完整的自动同步脚本，能够自动检测 `content` 文件夹的变化并将更改推送到 GitHub 仓库。

## 🚀 快速开始

### 1. 手动测试同步
```bash
./test-sync.sh
```

### 2. 设置自动同步（推荐使用 systemd 定时器）
```bash
chmod +x setup-systemd-timer.sh
./setup-systemd-timer.sh
```

## 📁 脚本文件说明

### `sync-content.sh` - 核心同步脚本
- **功能**：检测 content 文件夹变化并自动同步到 GitHub
- **特点**：
  - 自动检测新文件和修改
  - 智能处理 Git 冲突
  - 详细的日志记录
  - 错误处理和重试机制

### `test-sync.sh` - 测试脚本
- **功能**：手动测试同步功能
- **用途**：验证脚本是否正常工作

### `setup-systemd-timer.sh` - systemd 定时器设置
- **功能**：设置系统级定时任务
- **优势**：比 crontab 更可靠，支持开机自启

### `setup-cron.sh` - crontab 设置（备选）
- **功能**：设置传统的 crontab 定时任务
- **注意**：需要系统支持 crontab

## ⚙️ 配置选项

### 同步频率
默认每 5 分钟同步一次，可以在脚本中修改：

**systemd 定时器**：编辑 `/etc/systemd/system/quartz-sync.timer`
```ini
OnCalendar=*:0/5  # 每5分钟
```

**crontab**：编辑 `setup-cron.sh` 中的 `CRON_JOB` 变量
```bash
CRON_JOB="*/5 * * * * $SYNC_SCRIPT"  # 每5分钟
```

### 日志文件
同步日志保存在：`/home/txr/code/quartz/sync.log`

## 🔧 使用方法

### 日常使用
1. 在 `content/` 文件夹中添加或修改 Markdown 文件
2. 脚本会自动检测变化并同步
3. 无需手动执行 Git 操作

### 查看状态
```bash
# 查看定时器状态
sudo systemctl status quartz-sync.timer

# 查看同步日志
tail -f sync.log

# 查看系统日志
sudo journalctl -u quartz-sync
```

### 手动同步
```bash
# 立即执行一次同步
./sync-content.sh

# 测试同步功能
./test-sync.sh
```

## 🛠️ 故障排除

### 常见问题

1. **推送失败**
   - 检查网络连接
   - 确认 GitHub 权限
   - 查看错误日志

2. **定时器不工作**
   - 检查服务状态：`sudo systemctl status quartz-sync.timer`
   - 重新启动：`sudo systemctl restart quartz-sync.timer`

3. **权限问题**
   - 确保脚本有执行权限：`chmod +x *.sh`
   - 检查文件所有者

### 日志分析
```bash
# 查看最近的同步日志
tail -20 sync.log

# 查看系统服务日志
sudo journalctl -u quartz-sync --since "1 hour ago"
```

## 📝 注意事项

1. **Git 配置**：确保已正确配置 Git 用户信息和 SSH 密钥
2. **网络要求**：需要稳定的网络连接访问 GitHub
3. **权限管理**：脚本需要 Git 仓库的写入权限
4. **备份建议**：定期备份重要的 content 文件

## 🔄 更新和维护

### 更新脚本
```bash
git pull origin main
chmod +x *.sh
```

### 重新设置定时器
```bash
sudo systemctl stop quartz-sync.timer
sudo systemctl disable quartz-sync.timer
./setup-systemd-timer.sh
```

## 📞 技术支持

如果遇到问题，请检查：
1. 脚本日志文件
2. 系统服务状态
3. Git 仓库状态
4. 网络连接情况

---

**版本**：1.0.0  
**最后更新**：2025-01-17  
**维护者**：Quartz 用户
