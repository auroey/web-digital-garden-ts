---
title: Covariance Matrix
date: 2025-08-14
---
[[Covariance]]

## 1. 作用  
协方差矩阵把多个变量的 **方差** 和它们之间的 **协方差** 统一表示出来，是描述多维数据 **整体波动性与相关性** 的工具。

- 对角线：每个变量的方差  
- 非对角线：不同变量之间的协方差  

例：二维情况 $(x,y)$  
$$
C=
\begin{bmatrix}
\mathrm{Var}(x) & \mathrm{Cov}(x,y) \\
\mathrm{Cov}(y,x) & \mathrm{Var}(y)
\end{bmatrix}
$$  
- 左上角：$x$ 的波动  
- 右下角：$y$ 的波动  
- 非对角线：$x$ 与 $y$ 的相关程度（正相关/负相关）

---

## 2. 数学定义（总体协方差矩阵）  
对于随机向量  
$$
X=(X_1,\dots,X_d)^T,
$$  
其协方差矩阵为  
$$
\Sigma=\mathrm{Cov}(X)=\mathbb{E}[(X-\mu)(X-\mu)^T], \quad \mu=\mathbb{E}[X].
$$  

分量形式：  
$$
\Sigma_{ij}=\mathrm{Cov}(X_i,X_j)=\mathbb{E}[(X_i-\mu_i)(X_j-\mu_j)].
$$  

- $\Sigma_{ii}=\mathrm{Var}(X_i)$（单个变量的方差）  
- $\Sigma_{ij}$（$i\neq j$）：变量间的协方差  

---

## 3. 样本协方差矩阵  
实际中，我们只有有限样本。设数据矩阵  
$$
X \in \mathbb{R}^{n \times d} \quad (n\ \text{个样本},\ d\ \text{个特征})
$$  

- 样本均值：  
$$
\bar x=\frac{1}{n}\sum_{i=1}^n x_i
$$  

- 中心化矩阵：  
$$
Z=X-\mathbf{1}\bar x^T
$$  

- 样本协方差矩阵：  
$$
\hat\Sigma=\frac{1}{n-1}Z^T Z
$$  

---

## 4. 为什么是 $n-1$？（无偏估计）  
如果直接用 $n$ 作分母（即最大似然估计），会低估协方差：  
$$
\mathbb{E}\!\left[\frac{1}{n}\sum (x_i-\bar x)(y_i-\bar y)\right] < \mathrm{Cov}(X,Y).
$$  

原因：计算 $\bar x,\bar y$ 已经消耗了自由度，导致系统性偏差。  
修正后用 **$n-1$** 作分母，可以得到无偏估计：  
$$
\mathbb{E}[\hat\Sigma] = \Sigma.
$$  

多数统计软件默认采用 $n-1$。  




**协方差（covariance）** 只能告诉你两个变量是不是一起涨或一起跌（正相关/负相关），  
但它的大小没有“统一的量纲”，可能是 7.45，也可能是 17，还可能是 1000。
为了解决“量纲不一样”的问题，就把协方差除以两个变量的标准差：相关系数（[[Correlation Coefficient]]）