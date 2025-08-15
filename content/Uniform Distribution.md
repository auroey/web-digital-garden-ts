---
title: Uniform Distribution
date: 2025-08-15
---

**均匀分布**是一种最简单的概率分布，特点是：**在某个区间内，所有数值的出现概率相同。**

设 $X \sim \mathcal{U}(a, b)$，表示 $X$ 在 $[a, b]$ 区间上**连续均匀分布**，即：

$$
f(x) = 
\begin{cases}
\frac{1}{b - a}, & a \leq x \leq b \\
0, & \text{otherwise}
\end{cases}
$$

- 密度是“高度”
- 面积就是概率（总面积为 1）

---

## 📈 累计分布函数（[[CDF, Cumulative Distribution Function]]）

$$
F(x) = 
\begin{cases}
0, & x < a \\
\frac{x - a}{b - a}, & a \le x \le b \\
1, & x > b
\end{cases}
$$

图像：

- $x < a$：CDF = 0（还没开始）
- $x \in [a, b]$：线性增长（斜率为 $\frac{1}{b-a}$）
- $x > b$：CDF = 1（累计完了）

---

## 📌 期望与方差

| 名称     | 表达式                        |
|----------|-------------------------------|
| 期望     | $E[X] = \frac{a + b}{2}$      |
| 方差     | $\text{Var}(X) = \frac{(b - a)^2}{12}$ |
