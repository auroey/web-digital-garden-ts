---
title: LightNet
date: 2025-08-14
---
这一页是论文最核心的内容，详述了作者提出的**端到端逆渲染框架**的完整流程和每个模块的作用。可以总结为以下四部分：

---

### 🔧 1. 总体流程（见 Figure 3 左侧图）

论文的逆渲染系统包含五步：

1. **MGNet**：输入图像 → 预测材质和几何（深度、法线、反照率、金属度、粗糙度）
    
2. **BRDF 重要性采样**：根据预测结果，选择关键的入射光方向集合 $d_i$
    
3. **SSRT 光线追踪**：从点 $p$ 沿 $-d_i$ 方向进行屏幕空间光线追踪，找到光源位置 $s$，并提取该处的图像特征
    
4. **LightNet**：利用特征、视角方向、G-Buffer，预测该方向上的入射光照 $L_i(p,d)$
    
5. [[可导蒙特卡洛光线追踪（Differentiable Monte Carlo Raytracing）]]：结合所有 $L_i$，通过积分重建图像 $\hat{I}$，与原图计算损失并反向传播
    

---

### 🧠 2. MGNet：材质-几何网络（§4.1）

- 输入：HDR图像（或LDR图像预处理后）
    
- 架构：DenseNet121 编码器 + 4个解码器
    
- 输出：
    
    - Albedo（反照率 $A$）
        
    - Normal（法线 $N$）
        
    - Depth（深度 $D$）
        
    - Material（材质 $M$）含 Roughness ($R$) 与 Metallic ($M_t$)
        

---

### 💡 3. LightNet：光照预测网络（§4.2）

- 使用 ResNet34 编码器提取图像特征 $F$
    
- 对每个像素点 $p$，选择一个入射方向 $d$
    
- 执行光线追踪：$s = trace(p, -d)$
    
- 提取 $s$ 处的特征、法线、粗糙度等（来自 G-buffer）
    
- 利用 MLP 解码器 $f$，预测该方向上的光照：
    
    Li(p,d)=f(γ(d),F[π(s)],G[π(s)])L_i(p, d) = f(\gamma(d), F[\pi(s)], G[\pi(s)])
    
    > 其中 $\gamma$ 是 NeRF 中常用的位置编码函数，$\pi(s)$ 是将3D点 $s$ 投影到图像上的位置。
    

---

### 🌌 4. NeRF 风格的视野外光照网络（§4.3）


为了估算视野外的光照 $L_i(p, d)$：

- **从点 $p$ 沿方向 $-d$ 采样多个3D点**：$x_i = p - t_i d$（$t_i$ 是距离）
    
- 使用 **NeRF MLP** 模型 $f$，带位置编码 $\gamma(x_i)$，预测每点的密度 $\sigma_i$ 和颜色 $c_i$
    
- 利用 NeRF 的体渲染公式计算光照强度：
    
    L^=∑i=1NTi(1−e−σiδi)ci\hat{L} = \sum_{i=1}^{N} T_i (1 - e^{-\sigma_i \delta_i}) c_i
    
    其中：
    
    - $T_i = \exp(-\sum_{j=1}^{i-1} \sigma_j \delta_j)$ 表示前面点的透明度累积
        
    - $\delta_i = t_{i+1} - t_i$ 是采样点间距
        
    - MLP 参数来自 HyperNet：$\Phi = H(G(I))$
        

> 与原始 NeRF 不同，这里简化了模型规模、去掉了 ray direction 输入以提速。

---

### ☯️ 2. **融合机制：SSRT 与 NeRF 光照的加权混合**

- **SSRT 可能产生假交点（false positive）**，需要判断是否可信。
    
- 定义 SSRT 不确定性 $u = \tanh(10 \Delta d)$，其中 $\Delta d$ 是表面深度与光线深度之差
    
- 最终光照预测为：
    
    L^refined=(1−u)⋅L^SSRT+u⋅L^out−of−view\hat{L}_{refined} = (1 - u) \cdot \hat{L}_{SSRT} + u \cdot \hat{L}_{out-of-view}
    
    → 小 $u$ 时信任 SSRT，大 $u$ 时用 NeRF 结果。
    

---

### 🎮 3. **渲染层：可微蒙特卡洛重渲染器**

与 Li et al. [2020] 使用离散化方向不同，本方法采用 **重要性采样的可微蒙特卡洛积分**，能更真实模拟高光反射：

- 使用 BRDF 重要性采样采样 $N$ 条方向 $d_i$（依据视角、法线、粗糙度、金属度）
    
- 每条 $d_i$ 光线用 SSRT 找到光源，使用 LightNet 预测其辐射亮度 $L_i$
    
- 最终渲染图像：
    
    I~=1N∑i=1Nfr(v,di;A~,N~,R~,Mt~)⋅Li⋅cos⁡θip(v,di;N~,R~,Mt~)\tilde{I} = \frac{1}{N} \sum_{i=1}^{N} \frac{f_r(v, d_i; \tilde{A}, \tilde{N}, \tilde{R}, \tilde{M_t}) \cdot L_i \cdot \cos \theta_i}{p(v, d_i; \tilde{N}, \tilde{R}, \tilde{M_t})}
    - 分子是 BRDF 加权后的光照
        
    - 分母是采样该方向的概率密度 $p$
        

> 相比 Li 等人方法，能有效避免高光位置噪点和离散采样引起的条纹伪影，效果更真实。