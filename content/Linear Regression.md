---
title: Linear Regression
date: 2025-08-14
---
- 监督学习方法
    
- 根据已收集的输入（特征）和输出（目标）数据，学习它们的关系

1D Linear Regression

数学形式：

- 传统写法：$y = mx + b$
    
- 机器学习写法：$y = wx + b$
    
    - $w$ = 权重（weight）
        
    - $b$ = 偏置（bias）

Multivariate Linear Regression

$$w_1x_1^{(i)}+w_2x_2^{(i)}+\cdots+w_nx_n^{(i)}+b=y^{(i)}$$
向量/矩阵表示：

- $\mathbf{w}$ = 权重向量
    
- $\mathbf{X}$ = 特征矩阵（每行是一个样本）
    
- $\mathbf{y}$ = 目标向量
    
- 简化形式：$\mathbf{X} \mathbf{w} + b = \mathbf{y}$

- 可视化：
    
    - 2 特征 → 平面（3D 可视化）
        
    - 多于 2 特征 → 高维空间的超平面（hyperplane）

数据集中每条记录 → 对应一条线性方程

- 其中 $(i)$ 是样本编号（上标，不是指数）
        
- 数据集有 $m$ 条记录 → 有 $m$ 条线性方程
    
- **目标**：求解所有 $w_j$ 和 $b$，使方程组同时成立（或近似成立）

每行数据的 $x$ 和 $y$ 值不同，但所有行共享同一**组** $w$ 和 $b$。


- 如果存在完美预测的 $w$ 和 $b$，则该问题等价于**可解析解的线性方程组**
    
- 条件：
    
    - 已知全部 $x$ 和 $y$
        
    - 样本数量 ≥ 未知数数量（$w$ 的个数 + $b$）
        
- 在机器学习中，通常是**迭代、近似求解**（最小化误差）

# 多点线性回归的梯度下降法

## 1. 问题背景
我们要拟合一个直线模型：
$$
y = m x + b
$$
希望它能最好地拟合 **n 个观测值**：
$$
(x_1, y_1), (x_2, y_2), \dots, (x_n, y_n)
$$

---

## 2. 损失函数（均方误差）
对第 $i$ 个点：
$$
\text{误差}_i = (m x_i + b) - y_i
$$
平方后得到该点的损失：
$$
\text{Loss}_i = \left( m x_i + b - y_i \right)^2
$$
对所有点取平均：
$$
L(m, b) = \frac{1}{n} \sum_{i=1}^n \left( m x_i + b - y_i \right)^2
$$
> 除以 $n$ 得到均值，乘以 $2$ 只是为了在求导时抵消指数里的 $2$，不影响最小值的位置。

---

## 3. 梯度公式
对 $m$ 和 $b$ 分别求偏导：
$$
\frac{\partial L}{\partial m} = \frac{2}{n} \sum_{i=1}^n \left( m x_i + b - y_i \right) x_i
$$
$$
\frac{\partial L}{\partial b} = \frac{2}{n} \sum_{i=1}^n \left( m x_i + b - y_i \right)
$$

---

## 4. 梯度下降更新
从 $(m_0, b_0)$ 出发，反复迭代：
$$
m_{k+1} = m_k - \alpha \cdot \frac{\partial L}{\partial m}
$$
$$
b_{k+1} = b_k - \alpha \cdot \frac{\partial L}{\partial b}
$$
其中 $\alpha$ 是学习率。

每次更新，直线都会调整，使整体误差变小。迭代多次后，$(m, b)$ 会逼近最优解。

---

## 5. 可视化理解
- **左图**：实际数据点 + 当前拟合直线。
- **右图**：$m$、$b$ 平面上的损失函数曲面（像碗形），梯度下降就是在这个“碗”里沿着坡度走向最低点。
