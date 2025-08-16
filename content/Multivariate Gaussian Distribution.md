---
title: Multivariate Gaussian Distribution
date: 2025-08-16
---
## 1. 从一维到多维
- 一维高斯分布（Univariate Gaussian）：  
  $$
  f(x) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp\left(-\frac{(x-\mu)^2}{2\sigma^2}\right)
  $$

- 多维高斯分布（Multivariate Gaussian）：考虑 $d$ 个变量  
  $$
  f(x) = \frac{1}{(2\pi)^{d/2}|\Sigma|^{1/2}} \exp\left(-\tfrac{1}{2}(x-\mu)^T \Sigma^{-1} (x-\mu)\right)
  $$
  - $x \in \mathbb{R}^d$：随机向量
  - $\mu \in \mathbb{R}^d$：均值向量
  - $\Sigma \in \mathbb{R}^{d\times d}$：协方差矩阵（对称、半正定）

---

## 2. 独立 vs 相关
- **独立情况**：$\Sigma$ 为对角阵  
  - 各变量互不影响，等高线是圆（二维情况）
- **相关情况**：$\Sigma$ 有非零的非对角元素  
  - 各变量存在线性相关性，等高线拉长为椭圆

---

## 3. 协方差矩阵的作用
- $\Sigma$ 控制分布的形状：
  - 对角线元素：每个变量的方差
  - 非对角线元素：变量间的协方差
- $|\Sigma|$（行列式）：控制“体积”/扩散范围  
  - 越大 → 分布越“平坦”，越分散  
  - 越小 → 分布越“尖锐”，越集中


# Q：为什么各变量存在线性相关性，等高线拉长为椭圆

## 1. 独立情况（圆形/标准椭圆）
如果 $X, Y$ 独立：
- 协方差矩阵：
  $$
  \Sigma = 
  \begin{bmatrix} 
    \sigma_x^2 & 0 \\ 
    0 & \sigma_y^2 
  \end{bmatrix}
  $$
- 二次型：
  $$
  (x-\mu)^T \Sigma^{-1} (x-\mu) 
  = \frac{(x-\mu_x)^2}{\sigma_x^2} 
  + \frac{(y-\mu_y)^2}{\sigma_y^2}
  $$
- 这是一个**椭圆方程**。当 $\sigma_x = \sigma_y$ 时为圆，否则是轴对齐的椭圆。

---

## 2. 存在线性相关性（椭圆旋转）
当 $X, Y$ 有相关性：
- 协方差矩阵：
  $$
  \Sigma = 
  \begin{bmatrix} 
    \sigma_x^2 & \rho\sigma_x\sigma_y \\ 
    \rho\sigma_x\sigma_y & \sigma_y^2 
  \end{bmatrix}, \quad -1 < \rho < 1
  $$
- 二次型：
  $$
  (x-\mu_x, \, y-\mu_y) 
  \begin{bmatrix} a & b \\ b & c \end{bmatrix}
  \begin{bmatrix} x-\mu_x \\ y-\mu_y \end{bmatrix} = 1
  $$
  由于 $b \neq 0$（存在协方差项），曲线会产生**旋转项** → 等高线是**旋转后的椭圆**。

---

## 3. 椭圆为什么会拉长？
- 协方差 $>0$：$X$ 增大时 $Y$ 也倾向增大 → 数据点沿 **正斜率方向** 分布更宽 → 椭圆主轴朝 $y=x$ 方向。  
- 协方差 $<0$：$X$ 增大时 $Y$ 倾向减小 → 数据点沿 **负斜率方向** 分布更宽 → 椭圆主轴朝 $y=-x$ 方向。  
- 本质：协方差矩阵的**特征向量**决定椭圆的方向，**特征值**决定长短轴大小。