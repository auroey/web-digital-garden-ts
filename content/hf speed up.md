---
title: hf speed up
date: 2025-08-19
---
用 **hfd.sh + 镜像 + aria2c 多线程**一键把整个仓库拉下来：

### 1) 获取脚本 & 准备

```bash
cd ~/code/projectname/models
conda install -c conda-forge aria2 -y

wget https://hf-mirror.com/hfd/hfd.sh
chmod a+x hfd.sh
export HF_ENDPOINT="https://hf-mirror.com"
```

### 2) 多线程批量下载（整仓）

```bash
./hfd.sh xx/modelname --tool aria2c -x 8 -j 4 \
  --local-dir modelname
```

- `-x 8`：每个文件 8 线程
    
- `-j 4`：同时下载 4 个文件
    
- **断点续传**：同一命令重跑即可续传
    

