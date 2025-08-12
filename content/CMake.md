---
title: CMake
date: 2025-08-12
---
跨平台编译工具，用一份配置文件（`CMakeLists.txt`）描述不同平台的编译与链接过程

#### VS 工程方式与 CMake 对比

- **传统 VS 工程**：
    
    - 创建空项目 → 得到 `.sln`（解决方案） + `.vcxproj`（工程文件）
        
    - `.sln` 可包含多个 `.vcxproj` 工程
        
    - 局限：只能用 VS 打开，不便于跨平台迁移
        
- **CMake 工程**：
    
    - 一份配置文件（`CMakeLists.txt`）描述工程结构
        
    - 任何支持 CMake 的 IDE 都能打开
        
    - 适合跨平台协作与共享


#### 编译后链接

- **编译**：`.cpp` → `.obj`（目标文件）
    
- **链接**：多个 `.obj` 或 `.lib` → `.exe`（可执行文件）
    
- 示例：
    
    - `main.cpp` 调用 `add()`（在 `func.cpp` 中实现，`func.h` 中声明）
        
    - 编译 → `main.obj` + `func.lib`
        
    - 链接 → `main.exe`