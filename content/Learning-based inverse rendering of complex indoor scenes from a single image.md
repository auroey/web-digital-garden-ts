---
title: Learning-based inverse rendering of complex indoor scenes from a single image
date: 2025-08-13
---
# 背景
## 问题

- 单张室内图像的逆渲染很难，因为真实图像中包含阴影、镜面高光、漫反射等复杂的[[Global Illumination Effects]]。
    
- 需要从中恢复出：
    
    - 场景几何（几何、法线、深度）
        
    - 空间变化的材质（如金属度、粗糙度）
        
    - 未知的复杂照明（视野内+视野外）
## 传统方法的问题

- 优化驱动的逆渲染方法依赖强人工[[Prior]]和[[Regularization Term]]，真实场景中容易失败。
    
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

End-to-End Inverse Rendering Framework

- **目标**：从单张室内 RGB 图像中同时恢复：
    
    - **几何信息**：深度（Depth）、法线（Normal）
        
    - **材质属性**：反照率（Albedo）、粗糙度（Roughness）、金属度（Metallic）
        
    - **光照分布**：空间中任意点的照明强度
        
- **核心能力**：生成可编辑的 3D 场景重建结果
    
- **策略**：使用全流程分离建模（[[Full-pipeline Disentanglement]]）
    
| 模块编号    | 子模块名                                                               | 简要说明                                                     |
| ------- | ------------------------------------------------------------------ | -------------------------------------------------------- |
| **4.1** | **Material and Geometry Network（[[MGNet]]）**                       | 从单张图像预测材质与几何信息（反照率、粗糙度、金属度、法线、深度）                        |
| **4.2** | **[[Lighting Network]]（LightNet + SSRT）**                          | 局部光照建模：从图像中提取特征，结合 SSRT 模拟光线反射路径，预测给定点某方向的入射光强           |
| **4.3** | [[Uncertainty-Aware Out-of-View Lighting  Network]]（[[HyperNeRF]]） | 全局光照补全：模拟视野外光照，用 HyperNeRF 生成 MLP 估计空间中任意点的光照，并与 SSRT 融合 |
| **4.4** | **[[Rendering Layer]]（MC 重采样）**                                    | 采样多个方向，根据预测的材质参数与入射光进行微表面 BRDF 渲染，完成可导图像重建               |

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250814145937.png)

左图：**视野内光照估计与再渲染主流程**

对应系统的主渲染路径：

1. **MGNet 材质几何预测网络**
    
    - 输入：单张 HDR 图像；
        
    - 输出：空间变化的材质和几何图（$\tilde{A}$、$\tilde{N}$、$\tilde{R}$、$\tilde{M}_t$、$\tilde{D}$）；
        
    - 用于后续渲染。
        
2. **BRDF 重要性采样**
    
    - 使用微面元 BRDF（GGX）模型；
        
    - 根据视角、法线和材质，在每个像素采样 $N$ 个入射方向 ${d_i}$；
        
    - 这些方向用来估计从不同方向来的入射光。
        
3. **屏幕空间路径追踪（SSRT）**
    
    - 沿每个方向 $d_i$ 从当前像素点 $p$ 向场景中追踪，找到入射点 $s$；
        
    - 提取该点的图像特征：$F[\pi(s)]$；
        
    - 作为输入送入后续光照预测网络。
        
4. **LightNet 入射光照预测网络**
    
    - 输入：入射方向 $d_i$，G-Buffer（$\tilde{N}, \tilde{R}, \tilde{M}_t$），特征 $F[\pi(s)]$；
        
    - 输出：预测入射光照强度 $\tilde{L}_i$。
        
5. **可导蒙特卡洛积分**
    
    - 将所有 $\tilde{L}_i$ 与对应 BRDF 权重整合，得到重建图像：
        
        I~=1N∑i=1Nfr(v,di)⋅L~i⋅cos⁡θip(v,di)\tilde{I} = \frac{1}{N} \sum_{i=1}^{N} \frac{f_r(v, d_i) \cdot \tilde{L}_i \cdot \cos \theta_i}{p(v, d_i)}

---

右图：**视野外光照估计模块（Out-of-View LightNet）**

处理无法在视锥内追踪到光源时的补充路径：

1. **输入图像编码器**
    
    - 使用另一个 ResNet34 编码器提取全局特征 $F_g$。
        
2. **HyperNet 超网络**
    
    - 输入：全局图像特征；
        
    - 输出：用于构造 NeRF MLP 的参数 $\Phi$（即 NeRF 是场景特定的）。
        
3. **基于 NeRF 的体渲染**
    
    - 对每个 $(p, -d)$ 射线采样一组点 ${x_i = p - t_i d}$；
        
    - 输入位置编码 $\gamma(x_i)$ 到 MLP $f$，输出 $\sigma_i, c_i$（密度与颜色）；
        
    - 使用 NeRF 的体积渲染方法合成光照强度 $\hat{L}$。
        
4. **合成结果与主路径融合**
    
    - 如果 SSRT 判断不可靠（depth mismatch 大），则通过不确定度权重 $u$ 融合两条路径的结果：
        
        L^refined=(1−u)⋅L^SSRT+u⋅L^out-of-view\hat{L}_{\text{refined}} = (1 - u) \cdot \hat{L}_{\text{SSRT}} + u \cdot \hat{L}_{\text{out-of-view}}

---

总结表格如下：

|区域|模块|功能描述|
|---|---|---|
|**左图（主路径）**|MGNet|材质与几何图预测|
||Importance Sampling|从像素点采样多个入射方向|
||SSRT|屏幕空间路径追踪找到入射点|
||LightNet|基于局部特征预测入射光照强度|
||Rendering Layer|结合所有光照方向进行再渲染|
|**右图（补充路径）**|ResNet34 + HyperNet|从整图预测场景特定 NeRF 权重|
||NeRF MLP + Volume Rendering|模拟视野外环境光照估计|
||Blending|根据 SSRT 的可信度融合视野内外光照|

如需我用图标形式画出流程或生成总结 PDF，也可以继续说。
---

## 🏗️ 4. 支撑数据集：InteriorVerse

|特征|描述|
|---|---|
|📦 场景数量|4000+ 高质量合成室内场景|
|💎 渲染模型|使用 GGX 微表面 BRDF 渲染|
|🔍 数据特征|场景复杂，材质多样，光照丰富|
|📊 优势对比|超越 OpenRooms 和 SUNCG，在几何精度与光照准确性上均显著提升|
|🧠 用途|为全框架提供物理一致性监督，训练更鲁棒的几何-材质-光照预测模型|

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

