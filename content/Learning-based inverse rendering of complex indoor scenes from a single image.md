---
title: Learning-based inverse rendering of complex indoor scenes from a single image
date: 2025-08-13
---
# 1. 研究背景与问题

- 为什么要做 inverse rendering？
	为了从图片推测[[Geometry]]、[[Material Texture Representation|Material]]、[[Lighting Network|Illumination]]
- 室内场景的特殊挑战（复杂光照、反射、材质多样）。
     含有[[Global Illumination Effects]]，ill-posed problem
- 传统方法 & 深度学习方法的不足。
     - [[Physics-based Optimization]]：依赖强人工[[Prior]]和[[Regularization Term]]，方法假设过于简化，导致反演精度和重渲效果较差。
     - 深度学习方法：依赖数据集的 真实性与质量 + 网络结构设计。渲染层不够物理化，尤其处理高光、镜面反射差。鲁棒性不足。

---

# 2. 核心贡献

- 方法层面的新意。
	    ![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508241410255.png)
		图左(**新型 MC 可微渲染层**：基于重要性采样 + SSRT)和图右(**不确定性感知视域外光照网络**：HyperNetwork+NeRF)
- 数据集的贡献。
	    InteriorVerse 数据集：约 4000 个复杂室内场景，用 GGX 物理材质渲染。
- 整体框架的优势。
	    提出端到端学习框架，可从单张图恢复反照率、法向、深度、粗糙度、金属性。

---

# 3. 相关工作对比

## Inverse Rendering of Indoor Scenes

从框架整体来看，计算像素颜色的效果更好，具体原因是各个框架都变了。

以往的不足：
- [[Physics-based Optimization]] 规则不完美
- 深度学习方法输入不完美（Li et al., 2020）
- ill-posed Problem
- 数据集不够真实
- 渲染时使用的 environment map 忽略局部的高强度反射

本文改善：
- 两个大方法和一个更真实的数据集

## Lighting Estimation & Relighting

从光照估计来看，光源更真实，因为增加了视野外的计算和对重要光源的加权

以往的不足：
- 算光照
	- 单一环境图（如 Gardner’17）：所有像素点共用一种计算光照的方式
	- 球面高斯（Li’20）：不同像素点计算光照的系数不同，但仍变化缓慢/低频
	- 3D 光照体素（Wang’21b）：3D voxel grid 存储光照信息，但计算量大
- Relighting
	- 屏幕空间方法（Griffiths’22）、改灯管线（Li’22）：无法预测相机视角外的光，不能实现局部高清修改
- 用 LDR 作为数据集

本文改善：

---

# 4. **方法细节**

## 4.1 材质与几何网络 (MGNet)

- 输入输出 (albedo, normal, depth, roughness, metallic)。
    
- 网络结构（DenseNet 编码器 + 多解码器）。
    

## 4.2 光照网络 (LightNet)

- 屏幕空间光线追踪 (SSRT)。
    
- 本地特征提取方式。
    

## 4.3 外视野光照估计

- HyperNetwork + NeRF 的作用。
    
- 不确定性感知机制 (用 NeRF 修正 SSRT)。
    

## 4.4 可微分蒙特卡洛渲染层

- 为什么要用 MC。
    
- 和 Li 2020 的离散化渲染对比。
    
- 效果提升（高光、镜面反射）。
    

---

# 5. **数据集 InteriorVerse**

- 与现有数据集对比。
    
- GGX BRDF 的物理真实感。
    
- 场景复杂度与多样性。
    

---

# 6. **实验与结果**

- 合成数据集对比。
    
- 真实数据集评测 (IIW, NYUv2)。
    
- 应用场景：
    
    - 虚拟物体插入。
        
    - 材质编辑。
        
    - 重渲染。
        

---

# 7. **优点与改进点**

- **优点**：高频光照、真实反射、数据集质量高。
    
- **局限性**：MC 采样噪声大、计算开销高、NeRF 外视野光照仍有限。
    

---

# 8. **总结与未来方向**

- 本文方法的地位（比 Li 2020/Wang 2021 更物理真实）。
    
- 潜在改进方向：支持光源发射、提升采样效率、增强 NeRF 分辨率。
    
