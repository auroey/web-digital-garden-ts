---
title: Learning-based inverse rendering of complex indoor scenes from a single image
date: 2025-08-13
---
# 背景
## 问题

- 单张室内图像的逆渲染很难，因为真实图像中包含阴影、镜面高光、漫反射等复杂的[[全局光照效应]]。
    
- 需要从中恢复出：
    
    - 场景几何（几何、法线、深度）
        
    - 空间变化的材质（如金属度、粗糙度）
        
    - 未知的复杂照明（视野内+视野外）
## 传统方法问题

- 优化驱动的逆渲染方法依赖强人工[[先验]]和[[正则项]]，真实场景中容易失败。
    
- 早期方法假设过于简化，导致反演精度和重渲效果较差。

## 已有方法

### 🧩 逆渲染研究

- 传统方法多拆分任务：只做几何、材质或光照其中之一。
    
- Li et al. (2020) 等开始做**联合反演**：同时预测几何+材质+照明。
    
- 多数方法只处理**均匀光照**，忽略空间变化。
    

### 🔦 光照估计与重光照

- 传统方法用统一的环境光球，无法处理**室内空间变化**。
    
- 新方法尝试用：
    
    - **Spherical Gaussians/Spherical Harmonics**
        
    - **3D Voxel Grid** 表达空间变化
        
- Relighting 相关方法（如 Griffiths 2022）也通过屏幕空间技术估算遮挡/投影。
    

### 🧠 神经场景表示

- 最新技术开始用 Voxels、HashGrids、Point-based 方法（如 NeRF、Müller 2022）表达场景，更高效也更准确。

### 可导渲染（Differentiable Rendering）：

- 前人提出了通用的物理可导渲染器，如 Li et al. 和 Mitsuba2（Nimier-David）。
    
- 本文创新在于将**蒙特卡洛渲染器直接集成到网络中**，提升真实感并支持反向传播（§4.4）。

# 论文核心贡献

| 编号      | 贡献点                                                   | 技术名词                                                                    | 作用说明                                                                          |
| ------- | ----------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| **1️⃣** | [[端到端逆渲染框架]]                                          | 全流程解耦几何、材质与光照                                                           | 从单张RGB图像中同时恢复深度、法线、反照率、粗糙度、金属度和空间光照，实现可编辑的场景重建                                |
| **2️⃣** | [[可导蒙特卡洛光线追踪（Differentiable Monte Carlo Raytracing）]] | Differentiable Monte Carlo Raytracing + BRDF Importance Sampling + SSRT | 通过路径追踪采样真实反射方向并使其可导，可重建镜面反射、阴影、间接光等全局光照，提升材质和光照预测准确性                          |
| **3️⃣** | **NeRF风格的 out-of-view 光照估计网络**                        | [[LightNet]] + HyperNeRF + [[不确定性加权的视野外光照估计网络]]                         | 对图像外的不可见光源进行建模，通过 NeRF 估计任意点光照，引入不确定性根据深度差异加权融合 SSRT 和 NeRF 结果，解决“看不到的光怎么估”问题 |
| **4️⃣** | **高质量室内数据集 InteriorVerse**                            | 4000+ 合成场景 + GGX 渲染                                                     | 使用高质量微表面渲染器生成逼真数据，具备丰富材质、几何、照明细节，显著优于 OpenRooms/SUNCG 等已有数据集，为训练提供可靠监督        |

# 实验
## train

#### Lighting Network（光照网络 LightNet）：

- 损失函数包括：
    
    - **直接光照监督损失**（L_light）
        
    - **重渲染损失**（L_re-render），用于增强对亮度、镜面高光的捕捉
        
- 总损失为：  
    LLightNet=Llight+λrLre-renderL_\text{LightNet} = L_\text{light} + \lambda_r L_\text{re-render}LLightNet​=Llight​+λr​Lre-render​
    
- 加入 **re-render loss** 能提升镜面材质上的光照估计精度，避免模糊或斑点伪影。
    

#### 训练顺序（Progressive Training）：

- 先训练 **材质-几何网络**（MGNet），保证 albedo、normal、roughness、metallic、depth 的准确性；
    
- 再训练依赖这些预测的 **光照网络**，并加入 re-rendering loss。
    

---

### 🧪 实验设置与对比（Section 6.1 - 6.3）

#### 训练数据：

- 使用自建高质量合成室内数据集 **InteriorVerse**
    
- 在真实数据上微调：
    
    - IIW 数据集用于 albedo
        
    - NYUv2 数据集用于 depth 与 normal
        

#### 对比方法：

- 与两种 SOTA 方法对比：
    
    - Li et al. 2020（室内场景整体逆渲染）
        
    - Lighthouse（需立体图像对输入，仅用于光照估计）

## inference

#### 合成数据集评估（见 Fig. 5）：

- Albedo：Li et al. 2020 模型结果过于平滑，本文模型保留更多纹理细节。
    
- Normal：本文模型能更好还原墙角等处的锐利边缘，归功于 perceptual loss。
    
- Metallic 未展示对比，因为 Li 方法不支持。
    

#### 真实数据集评估（IIW 和 NYUv2）：

- 使用 WHDR 衡量 albedo 预测的人类主观一致性；
    
- 使用角误差与 si-MSE 衡量 normal 与 depth。
    
- 表格结果（Table 1）显示本文方法在所有指标上优于对比方法。

# 局限性

1. **Out-of-view 网络容量有限**，对高频光照建模能力弱。
    
2. **Monte Carlo 渲染存在噪声**，提高采样代价高。
    
3. **当前不支持光源自发光建模**，为未来工作方向。

