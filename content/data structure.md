---
title: data structure
date: 2025-08-17
---
## 分类

- **逻辑结构（Logical Structure）** → 从“数据之间的逻辑关系”角度看
    ![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817101219.png)
    - **线性结构**：数据元素一对一关系
        
        - 数组（Array）
            
        - 链表（Linked List）
            
        - 栈（Stack）
            
        - 队列（Queue）
            
    - **非线性结构**：数据元素一对多或多对多关系
        
        - 树（Tree）
            
        - 图（Graph）
            
        - 集合（Set）
            
- **物理结构（Storage Structure）** → 从“数据在内存里的存放方式”角度看
    ![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817101353.png)
    - 顺序存储（连续内存，比如数组）
        
    - 链式存储（用指针/引用连接，比如链表）
        

内存条、内存空间、内存地址：
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817101252.png)
- **内存（[[Random Access Memory, RAM]]）**
    
    - 属于 **CPU** 的“工作台”。
        
    - 存放正在运行的程序和数据，支持通用计算。
        
    - 特点：容量大（几 GB 到几十 GB），但对图像矩阵这种大规模并行处理效率不高。
        
- **显存（VRAM / GPU Memory）**
    
    - 属于 **GPU** 的“专用工作台”。
        
    - 存放 GPU 在计算时需要的模型参数、激活值、中间特征图、纹理、显卡渲染数据等。
        
    - 特点：带宽高（读写速度快）、适合并行，但容量通常比内存小（常见 8GB–80GB）。

所有数据结构都是基于**数组、链表或二者的组合**实现的。例如，栈和队列既可以使用数组实现，也可以使用链表实现；而哈希表的实现可能同时包含数组和链表。

- 基于数组可实现：栈、队列、哈希表、树、堆、图、**矩阵、张量**（维度 >=3 的数组）等。
- 基于链表可实现：栈、队列、哈希表、树、堆、图等。