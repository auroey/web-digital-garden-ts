---
title: Derivatives and Optimization
date: 2025-08-15
---
## 导数的两种常用记法

### 1. 从 $\Delta x / \Delta t$ 到 $dx/dt$
- 斜率最开始用的是  
$$
\frac{\Delta x}{\Delta t}
$$  
  → 表示两点之间的平均变化率（割线斜率）。
- 把区间越来越缩小 → 接近切线的斜率 → 记作  
$$
\frac{dx}{dt}
$$  
  这里 $dx$ 和 $dt$ 表示无限小的变化量。

---

### 2. 两种导数记法

#### ① Leibniz 记法  
- 一般用 $y = f(x)$ 表示函数，导数记作  
$$
\frac{dy}{dx} \quad\text{或}\quad \frac{d}{dx}f(x)
$$  
- 强调**变量之间的关系**（谁是自变量，谁是因变量）。  
- $d/dx$ 可以看作“对 $x$ 求导”的操作符。

#### ② Lagrange 记法  
- 写作  
$$
f'(x)
$$  
- 强调函数的变化率，读作“$f$ prime of $x$”。  
- 更**简洁**，计算步骤里常用。



## 反函数与导数的关系

### 1. 反函数的定义
- 若 $f$ 把 $a$ 映射到 $b$，则它的反函数 $g$ 会把 $b$ 映射回 $a$。
- 记作：
  $$
  g = f^{-1}
  $$
  注意：$f^{-1}$ 表示反函数，不是 $\frac{1}{f}$。
- 性质：
  $$
  g(f(x)) = x \quad \text{且} \quad f(g(y)) = y
  $$

---

### 2. 图像关系
- 反函数图像是原函数图像关于直线 $y = x$ 的**镜像对称**。
- 对应点：
  - 若 $(a, b)$ 在 $f$ 上，则 $(b, a)$ 在 $g$ 上。

---

### 3. 斜率的关系
- 在图像上，镜像对称会让切线斜率互为**倒数**：
  $$
  g'(y) = \frac{1}{f'(x)}
  $$
  其中 $y = f(x)$。

**推导思路**：
1. $f'(x) = \frac{\Delta f}{\Delta x}$  
   $g'(y) = \frac{\Delta g}{\Delta y}$
2. 镜像对称：$\Delta g = \Delta x$，$\Delta y = \Delta f$
3. 代入得：
   $$
   g'(y) = \frac{\Delta x}{\Delta f} = \frac{1}{f'(x)}
   $$

- 将一阶偏导组成**梯度向量**：
$$  
        \nabla f = \begin{bmatrix} f_x \\ f_y \end{bmatrix}  
        $$
将二阶偏导按顺序排成矩阵：[[Hessian Matrix]]（[[Covariance Matrix]] 也是这个分布，但含义和算法不同）
- 能记录函数在各方向的二阶变化率，反映曲面的局部曲率特性。
$$  
H(f) = \begin{bmatrix} f_{xx} & f_{xy} \\ f_{yx} & f_{yy} \end{bmatrix} = \begin{bmatrix} 4 & -1 \\ -1 & 6 \end{bmatrix}  
$$
- 当一阶偏导都是连续可微时（满足**混合偏导相等定理**），$f_{xy} = f_{yx}$ 。

---


[[Exponential (e)]]



- **梯度（Gradient）**：多维导数，指明最快下降方向。
    
- **优化（Optimization）**：用梯度来更新参数，最常用的是梯度下降（Gradient Descent）。
    
- **损失函数（Loss Function）**：衡量模型预测与真实值的差距，例如：
    
    - **平方损失（Square Loss）**：常用于回归。
        
    - **对数损失（Log Loss）**：常用于分类。、


为什么平方损失用于回归，对数损失用于分类

### 1. **平方损失（[[Square Loss]]） → 回归**
公式：
$$
L_{\text{square}} = \frac{1}{n} \sum_{i=1}^n (y_i - \hat{y}_i)^2
$$

**原因：**
- 平方会放大大误差，促使模型精准拟合连续输出的数值。


### 误差平方的原因

- 直接用 $e = y - \hat{y}$，正负误差会互相抵消

- 平方误差：$(y - \hat{y})^2$ 保证非负，并放大大误差
- 均方误差（MSE）：取平均，稳定训练
- 系数 $\frac12$：求导时抵消平方项的系数 2，简化公式

---

### 2. **对数损失（[[Log Loss]]） → 分类**
二分类公式：
$$
L_{\text{log}} = -\frac{1}{n} \sum_{i=1}^n \left[ y_i \log(\hat{p}_i) + (1-y_i) \log(1-\hat{p}_i) \right]
$$

**原因：**
- 不只是判断对错，而是根据预测概率的正确程度给分数。
    
- 对“自信但错”的预测惩罚特别重，保证概率预测更接近真实分布。
