---
title: Bernoulli Distribution
date: 2025-08-15
---

## 1. 定义

伯努利分布描述一个**只有两种结果**的随机试验，记随机变量 $X$ 为一次试验的结果：

$$
X = 
\begin{cases}
1 & \text{Success} \\
0 & \text{Failure}
\end{cases}
$$

其中：
- 成功的概率为 $p$
- 失败的概率为 $1 - p$

---

## 2. 概率质量函数（[[PMF，Probability Mass Function]]）

$$
P(X = x) = p^x (1 - p)^{1 - x}, \quad x \in \{0, 1\}
$$

展开后为：

- $P(X = 1) = p$
- $P(X = 0) = 1 - p$

## 5. 期望与方差

- **期望值（均值）**：

  $$
  E[X] = p
  $$

- **方差（波动）**：

  $$
  \text{Var}(X) = p(1 - p)
  $$

---

## 6. 与二项分布关系

- 伯努利分布是**二项分布的特例**，即 $n = 1$ 的情况：

  $$
  \text{Bern}(p) = \text{Binomial}(n=1, p)
  $$


