---
title: Uncertainty-Weighted Out-of-View Lighting Estimation Network
date: 2025-08-13
---


### 📌 背景动机：

- 输入图像中只能看到**部分可视区域**；
    
- 然而，真实渲染过程需要**全局光照信息**（包括视野外）；
    
- 如果不处理视野外区域，会导致光照预测不完整，渲染结果失真。
    

---

### 🧠 设计方法：

作者将光照预测拆解为两部分：

|区域|表示|估计方式|
|---|---|---|
|可视区域（In-view）|$\mathcal{I}_{\text{in}}$|使用 Screen-Space Ray Tracing (SSRT)|
|不可视区域（Out-of-view）|$\mathcal{I}_{\text{out}}$|使用 **NeRF + HyperNetwork** 生成|

---

### 🛠️ 不确定性加权机制：

由于可视与不可视区域的光照预测来源不同，存在可信度差异，作者提出：

> 将两种光照估计按照**预测不确定性**进行融合，加权得到最终光照结果。

#### 📐 融合公式：

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250813204109.png)


其中：

- $\alpha = \text{sigmoid}(w)$ 为网络学习到的**不确定性权重**（越接近 1，说明视野内预测越可信）
    

---

### 🧱 NeRF + HyperNetwork 实现视野外光照：

- 视野外区域由一个 NeRF 模型表示辐射场；
    
- 但不是每张图都训练一个 NeRF，而是用一个 **HyperNetwork** 动态生成 NeRF 的权重；
    
- 这样能根据不同输入图像快速推断视野外辐射场，提升效率与泛化能力。
    

---

### 🎯 效果与优势：

|优点|描述|
|---|---|
|🔍 弥补视野盲区|视野外光照不再被忽略，提升全局一致性|
|🧠 动态建模|HyperNetwork + NeRF 可根据输入图像适配不同场景|
|🧮 权重融合可学习|学习不确定性权重实现软切换、提升鲁棒性|
