---
title: Moment
date: 2025-08-16
---
## Raw Moments

原点矩是指对变量本身取幂后的期望值：

$$
\mu_k' = \mathbb{E}[X^k]
$$

- 第 $k$ 阶原点矩：
  $$
  \mu'_k = \sum_{i=1}^n p_i x_i^k
  $$

- 一阶原点矩：$\mu_1' = \mathbb{E}[X]$（Mean），分布中心
- 二阶原点矩：$\mu_2' = \mathbb{E}[X^2]$
- 三阶原点矩：$\mu_3' = \mathbb{E}[X^3]$
- 四阶原点矩：$\mu_4' = \mathbb{E}[X^4]$

---

## Central Moments

中心矩是**以均值 $\mu$ 为中心**的偏移量的幂的期望：

$$
\mu_k = \mathbb{E}[(X - \mathbb{E}[X])^k]
$$
第 $k$ 阶中心矩：
  $$
  \mu_k = \sum_{i=1}^n p_i (x_i - \mu)^k
  $$

- 一阶中心矩：$\mu_1 = 0$（总为 0）
- 二阶中心矩：$\mu_2 = \text{Var}(X)$（Variance），离散程度
- 三阶中心矩：标准化后描述偏度（[[Skewness]]），分布对称性
- 四阶中心矩：标准化后描述峰度（[[Kurtosis]]），分布尖锐程度
