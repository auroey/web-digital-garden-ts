---
title: Learning to predict indoor illumination from a single image
date: 2025-08-13
---
在这篇 _“Learning to Predict Indoor Illumination from a Single Image”_ 里，CNN（卷积神经网络）的使用主要是作为**端到端的回归器**，直接从有限视场的输入图像预测出对应的HDR环境光照（environment map）。  


![[Pasted image 20250813162248.png]]

### **流程**

#### **1. 输入**

- **Single LDR image**  
    普通相机拍的一张单曝光图片，没有完整的亮度范围信息。
    

---

#### **2. CNN 预测 HDR 环境光照**

- 使用卷积神经网络（CNN）输入这张 LDR 图片，输出一个 **HDR environment map（HDR 环境贴图）**
    
- 这个 HDR 贴图是球面上的光照分布，包含光源的方向、颜色、亮度信息。


#### 双阶段训练

## **输入（Input）**

- **局部 RGB 图像裁剪（Input crop）**
    
    - 从 HDR 全景图中裁剪的一个局部视场（模拟普通相机拍摄到的画面）。
        
    - 格式：普通的低动态范围 RGB 图像（虽然来源是 HDR 数据，但裁剪部分会作为标准图像输入 CNN）。
        
    - 尺寸：通常是固定分辨率（比如 $256\times256$，具体看实现）。
        

---

## **输出（Output）**

- **HDR 环境图的光源强度分布（Target light log-intensity）**
    
    - 是整个场景的光照在球面上的分布，经过 **spherical warp** 对齐到 CNN 输出坐标。
        
    - 数值是 **光照强度的对数值（log-intensity）**，这样可以压缩 HDR 的极大亮度范围，避免训练不稳定。
        
    - 输出维度：一般是球面展开后的 2D 张量（例如 $64\times128$），每个像素表示该方向上的光强。
        

---


- **阶段一（LDR 数据）**：输出是 **光源方向的 mask（light mask）**。
    
- **阶段二（HDR 数据）**：输出是 **光源强度分布（log-intensity map）**。



**1. 阶段一：光源位置学习（LDR 数据训练）**

**目的**：让 CNN 学会预测光源的**方向**（位置分布）。

流程：

1. **数据来源**
    
    - **LDR panorama from SUN360 database**  
        来自 SUN360 数据库的低动态范围全景图（LDR），覆盖 360° 场景信息。
        

---

2. **光源检测 & 球面变换**
    
    - **Light detector（Sec. 4）**  
        检测全景图中光源的区域（输出一个光源掩码 mask）。
        
    - **Spherical warp（Sec. 5）**  
        对全景图做球面投影变换，把球面上的光照信息映射到 CNN 输出的光照坐标空间。
        
 为什么是球面：在 3D 世界里，你的眼睛（或者摄像机）站在一个点上，**光照的来源方向可以是任何一个 3D 单位向量**。所有可能的方向构成了一个单位球面（unit sphere）上的点，每个点对应一个方向。 
 
---

3. **生成训练标签**
    
    - **Target light mask**  
        白色区域表示光源位置，黑色区域为非光源。
        
    - **Target RGB panorama**  
        经过变换后的 RGB 全景，用于监督学习。
        

---

4. **裁剪输入图像**
    
    - 从全景图中截取一个 **局部视场**（Input crop），作为 CNN 的输入图像。
        

---

5. **训练规模**
    
    - 这种数据生成方式可以大规模扩展（×96,000），因为 LDR 全景图数据易获取，成本低。
---

**2. 阶段二：光源强度学习（HDR 数据微调）**

**目的**：让 CNN 学会预测光源的**亮度**（强度分布）。

流程：

### 1. **数据来源**

- **HDR panorama from new HDR database**  
    使用新采集的 HDR（高动态范围）全景数据，能够真实记录场景中的光照强度（而不仅仅是方向）。  
    由于 HDR 数据采集成本高，数量较少（×14,000）。
    

---

### 2. **球面变换（Spherical warp, Sec. 5）**

- 将球面全景图转换到 CNN 输出空间，使光照信息在神经网络的输出坐标系中对齐。
    
- 对 HDR 光照进行 **log 强度映射**（log-intensity），防止亮度范围过大导致训练不稳定。
    

---

### 3. **生成训练标签**

- **Target light (log)-intensity**  
    表示光照在不同方向上的强度分布（亮的区域更黄/绿，暗的区域更蓝/紫）。
    
- **Target RGB panorama**  
    球面变换后的 RGB 环境图，用作辅助信息。
    

---

### 4. **裁剪输入**

- 从 HDR 全景中截取局部视场（Input crop）作为 CNN 输入，模拟从普通相机拍摄得到的局部图像。
    

---

### 5. **微调（Fine-tuning）**

- 在 **阶段一（LDR 数据训练）** 的 CNN 基础上，使用这些 HDR 数据进行**微调**，让模型不仅能预测光源方向，还能预测光源强度。
