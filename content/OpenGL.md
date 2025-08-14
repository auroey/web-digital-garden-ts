---
title: OpenGL
date: 2025-08-11
---
### OpenGL 的两种模式

1. **立即渲染模式（Immediate Mode）**
    
    - 用一组固定的 API（固定渲染管线）完成绘制 API 把很多显卡底层细节都帮你封装好了（帮你算光照、变换、投影等）。
        
    - 封装度高、限制多、不灵活
        
2. **核心渲染模式（Core Profile）**
    
    - 移除了大部分固定管线 API（`glBegin/glEnd` 等） 引入**可编程[[Rendering Pipeline]]**：你必须自己写**着色器（Shader）**，告诉 GPU 怎么处理顶点和像素
        
    - 给程序员更多控制显卡细节的自由


OpenGL 工程管理：基于 [[CMake]] 构建