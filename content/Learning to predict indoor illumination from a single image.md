---
title: Learning to predict indoor illumination from a single image
date: 2025-08-13
---
在这篇 _“Learning to Predict Indoor Illumination from a Single Image”_ 里，CNN（卷积神经网络）的使用主要是作为**端到端的回归器**，直接从有限视场的输入图像预测出对应的HDR环境光照（environment map）。  


![[Pasted image 20250813162248.png]]


这张图是该论文的**整体流程示意图**，展示了作者如何用 CNN 从单张室内 LDR 图像预测 HDR 环境光照（HDR environment map），分为两个阶段训练：

---

### **1. 阶段一：光源位置学习（LDR 数据训练）**

**目的**：让 CNN 学会预测光源的**方向**（位置分布）。

流程：

1. 从 **SUN360 LDR 全景数据库** 取出全景图。
    
2. 使用 **光源检测器**（Light detector）在全景图上检测光源位置，得到**光源掩码（Target light mask）**。
    
3. 对全景图做 **球面投影变换（spherical warp）**，将 [[等距柱状投影 equirectangular projection]] 映射到 CNN 输出的在**球面坐标系**（spherical coordinates）上的坐标空间。
    
    为什么是球面：在 3D 世界里，你的眼睛（或者摄像机）站在一个点上，**光照的来源方向可以是任何一个 3D 单位向量**。所有可能的方向构成了一个单位球面（unit sphere）上的点，每个点对应一个方向。
    
4. 从全景图中裁剪出局部视场（Input crop）作为 CNN 的输入，同时光源掩码作为标签。
    
5. CNN 学习从局部 LDR 图像预测光源方向分布（light directions）。
    
6. 数据量很大（×96,000），因为 LDR 数据容易收集。
    

---

### **2. 阶段二：光源强度学习（HDR 数据微调）**

**目的**：让 CNN 学会预测光源的**亮度**（强度分布）。

流程：

1. 使用新采集的 **HDR 全景数据库**（有真实光照强度信息）。
    
2. 对 HDR 全景做 **球面投影变换**，得到目标光照强度分布（Target light (log)-intensity）。
    
3. 裁剪局部视场作为 CNN 输入，强度分布作为标签。
    
4. 对在 LDR 数据上训练好的 CNN 进行**微调（fine-tuning）**，预测 HDR 环境图（包含位置 + 强度）。
    
5. 数据量相对较小（×14,000），因为 HDR 采集成本高。
    

---

### **3. 最终效果**

- 输入：单张 LDR 图像（例如一张室内照片）。
    
- CNN 输出：完整的 HDR 环境图（包含光源方向 + 光强）。
    
- 应用：可将预测的 HDR 光照用于虚拟物体的真实感重光（relighting），实现真实光照下的虚拟物体插入。
    
