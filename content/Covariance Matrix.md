---
title: Covariance Matrix
date: 2025-08-14
---
[[Covariance]]

## 1. 定义
- **作用**：集中存储数据集中所有变量两两之间的**方差**与**协方差**。
- 对于 2 个变量 $x$ 和 $y$：
$$
C =
\begin{bmatrix}
\text{Var}(x) & \text{Cov}(x, y) \\
\text{Cov}(y, x) & \text{Var}(y)
\end{bmatrix}
$$
- 对角线元素：各变量的方差（Var）。
- 非对角线元素：变量之间的协方差（Cov）。

---

## 2. 特性
- 对称性：$\text{Cov}(x, y) = \text{Cov}(y, x)$
- 协方差矩阵是**对称矩阵**。
- 协方差公式：
  - $\text{Var}(x) = \frac{\sum (x_i - \mu_x)^2}{n-1}$
  - $\text{Cov}(x, y) = \frac{\sum (x_i - \mu_x)(y_i - \mu_y)}{n-1}$

---

## 3. 构造步骤（2 变量示例）
1. **计算均值向量**  
   $$
   \mu_x = \frac{1}{n} \sum_{i=1}^n x_i,\quad
   \mu_y = \frac{1}{n} \sum_{i=1}^n y_i
   $$
2. **数据中心化**  
   构造矩阵 $A - \mu$，对每一列减去该列均值。
3. **矩阵计算公式**  
   $$
   C = \frac{1}{n-1} (A - \mu)^\top (A - \mu)
   $$
   - $A$：$n \times m$ 矩阵（$n$ 行观测，$m$ 列变量）
   - $\mu$：与 $A$ 同形状，每列填该列均值
   - **方差**就是“同一个变量与自己求协方差”。
   - 所有 $(x_i - \mu_x)(y_i - \mu_y)$ 这样的“差值乘积”，其实就是**内积（dot product）**的结果。
1. **结果**  
   - $C$ 尺寸：$m \times m$
   - 对角线 = 方差，非对角线 = 协方差

---

## 4. 矩阵运算理解
- $(A - \mu)^\top$ 尺寸：$m \times n$
- $(A - \mu)$ 尺寸：$n \times m$
- 相乘后得到 $m \times m$ 矩阵
- 各元素解释：
  - $(1,1)$ 元素：$x$ 与 $x$ → $\text{Var}(x)$
  - $(1,2)$ 元素：$x$ 与 $y$ → $\text{Cov}(x, y)$
  - $(2,1)$ 元素：$y$ 与 $x$ → $\text{Cov}(y, x)$
  - $(2,2)$ 元素：$y$ 与 $y$ → $\text{Var}(y)$

---

## 5. 多变量情况
- 对任意 $m$ 维数据（$m$ 个变量），协方差矩阵依然是 $m \times m$：
  $$
  C_{ij} = \text{Cov}(\text{Var}_i, \text{Var}_j)
  $$
- 构造方法与二维相同：
  - 按列减去均值
  - 左乘转置
  - 除以 $n-1$

---

## 6. PCA 中的意义
- PCA 从协方差矩阵的**特征向量**中找到方差最大的方向（主成分方向）。
- 协方差矩阵的**特征值**代表对应方向的方差大小。
- 对角化 $C$ → 得到新的正交坐标系（主成分轴）。




## 定义
给随机向量 $X=(X_1,\dots,X_d)^T$，协方差矩阵定义为：
$$
\Sigma=\mathrm{Cov}(X)=\mathbb{E}\!\left[(X-\mu)(X-\mu)^T\right],\quad \mu=\mathbb{E}[X]
$$
元素形式：
$$
\Sigma_{ij}=\mathrm{Cov}(X_i,X_j)=\mathbb{E}\!\left[(X_i-\mu_i)(X_j-\mu_j)\right]
$$
对角线是方差：$\Sigma_{ii}=\mathrm{Var}(X_i)$；非对角线是协方差：$\Sigma_{ij}$。

---

## 数据集版本（样本协方差）
样本矩阵 $X\in\mathbb{R}^{n\times d}$（行=样本，列=特征），样本均值 $\bar x\in\mathbb{R}^d$，中心化矩阵 $Z=X-\mathbf{1}\bar x^T$：
$$
\hat\Sigma=\frac{1}{n-1}Z^T Z
$$
（若用 $\tfrac{1}{n}$ 为有偏估计；多数统计软件默认 $\tfrac{1}{n-1}$。）

---

## 关键性质
- **对称**：$\Sigma=\Sigma^T$
- **半正定**：$\forall v,\ v^T\Sigma v\ge 0$（特征值$\ge 0$）
- **独立性**：若 $X_i\perp X_j$，则 $\Sigma_{ij}=0$
- **仿射变换**：对 $Y=AX+b$，
$$
\mathrm{Cov}(Y)=A\,\Sigma\,A^T
$$

---

## 相关矩阵（Correlation Matrix）
标准差向量 $s=(\sigma_1,\dots,\sigma_d)^T$，$D=\mathrm{diag}(s)$：
$$
R=D^{-1}\Sigma D^{-1},\quad R_{ij}=\rho_{ij}
$$
$R$ 消除了量纲，便于跨特征比较（$-1\le \rho_{ij}\le 1$）。

---

## 与多元高斯
若 $X\sim\mathcal{N}(\mu,\Sigma)$，密度为：
$$
p(x)=\frac{1}{(2\pi)^{d/2}\,|\Sigma|^{1/2}}
\exp\!\left(-\tfrac{1}{2}(x-\mu)^T\Sigma^{-1}(x-\mu)\right)
$$
等概率密度面是椭球；形状与朝向由 $\Sigma$ 决定。

---

## PCA 关联（特征分解）
对称半正定 $\Sigma$ 可特征分解：
$$
\Sigma=U\Lambda U^T,\quad \Lambda=\mathrm{diag}(\lambda_1\!\ge\!\cdots\!\ge\!\lambda_d\!\ge\!0)
$$
主成分方向为 $U$ 的列向量，方差为对应 $\lambda_i$；降维取前 $k$ 个最大特征值的方向。

---

## 小例子（二维）
$$
\Sigma=
\begin{bmatrix}
4 & 3\\
3 & 9
\end{bmatrix}
$$
- $\mathrm{Var}(X_1)=4$，$\mathrm{Var}(X_2)=9$
- $\mathrm{Cov}(X_1,X_2)=3>0$：同向变化趋势
- 相关系数：
$$
\rho_{12}=\frac{3}{\sqrt{4}\sqrt{9}}=\frac{3}{6}=0.5
$$
