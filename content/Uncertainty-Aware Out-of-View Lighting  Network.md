---
title: Uncertainty-Aware Out-of-View Lighting  Network
date: 2025-08-14
---
## 🌌 Uncertainty-Aware Out-of-View Lighting Network（视野外不确定光照建模）

> **目标：** 弥补 SSRT 在视野外区域无法获取有效光照的缺陷，提升整场景照明建模的完整性与稳定性。

---

### 🧱 核心思想

- SSRT 仅能处理图像视野内的光照。
- 当射线追踪超出视野范围，必须依赖额外机制。
- 本模块借鉴 NeRF 思想，使用 HyperNeRF 风格网络预测视野外光照。

---

### 🧠 模型结构

1. **图像编码**  
   - 输入图像 $I$，通过 ResNet34 编码器提取全局特征：
     $$
     F_g = G(I)
     $$

2. **超网络生成 MLP 权重**  
   - 使用超网络 $H$ 生成 MLP 的权重：
     $$
     \Phi = H(F_g)
     $$

3. **在射线上采样 $N$ 个点**
   - 射线方向：从点 $p$ 向 $-d$ 方向延伸
   - 采样点：
     $$
     x_i = p - t_i d,\quad i=1,\dots,N
     $$

4. **使用 MLP 获取每个点的密度和颜色**
   - 输入经过位置编码 $\gamma(x_i)$，输出密度 $\sigma_i$ 和颜色 $c_i$：
     $$
     \{\sigma_i, c_i\} = f(\gamma(x_i); \Phi)
     $$

5. **体渲染合成光照强度**
   - 使用体渲染和 alpha 合成得到预测光照：
     $$
     \hat{L} = \sum_{i=1}^{N} T_i (1 - \exp(-\sigma_i \delta_i)) c_i
     $$
   - 其中：
     $$
     T_i = \exp\left(-\sum_{j=1}^{i-1} \sigma_j \delta_j\right),\quad \delta_i = t_{i+1} - t_i
     $$

---

### ❗ 性能优化

- 本 MLP 模型相对 NeRF 更小型，不再将光线方向 $d$ 作为输入。
- 减少计算量，便于场景泛化。

---

### 🔁 视野内外光照融合机制（不确定性加权）

> SSRT 有可能产生错误的碰撞（False Positive）。我们用视差大小定义其不确定性：

- 定义深度误差 $\Delta d$：
  - 若为真实碰撞，$\Delta d$ 小
  - 若为错误碰撞，$\Delta d$ 大

- 定义不确定度：
  $$
  u = \tanh(10 \Delta d)
  $$

- 加权融合最终光照预测：
  $$
  \hat{L}_{\text{refined}} = (1 - u) \cdot \hat{L}_{\text{SSRT}} + u \cdot \hat{L}_{\text{out-of-view}}
  $$

---

### 📝 备注

- 当 $u$ 较大时，说明 SSRT 不可信，转为依赖 out-of-view 预测；
- 当 $u$ 较小时，说明追踪可靠，主要依赖 SSRT 结果；
- 补充材料中提供了使用 only-out-of-view 与 full-model 的对比消融实验。

