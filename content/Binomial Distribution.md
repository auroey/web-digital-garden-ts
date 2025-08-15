---
title: Binomial Distribution
date: 2025-08-15
---

## 1. 基本定义

**二项分布**用于描述如下类型的实验：

- **重复**进行 $n$ 次 [[Bernoulli Distribution]] 实验
- 每次实验只有 **两个结果**（成功/失败）
- 每次实验的成功概率是 $p$
- 目标变量 $X$ 是“成功的次数”

我们记作：

$$
X \sim \text{Binomial}(n, p)
$$

---

## 2. 场景直觉（以抛硬币为例）

### 抛 5 次硬币，问出现 2 次正面的概率是多少？

- 每个序列（如：HTHTT）出现的概率都是 $(0.5)^5 = \frac{1}{32}$
- 出现 **2 个正面**的序列总共有 **10 种**
- 所以：

$$
P(X = 2) = 10 \cdot \frac{1}{32} = \frac{10}{32}
$$

---

## 3. 一般公式（PMF）

**概率质量函数（PMF）**如下：

$$
P(X = k) = \binom{n}{k} \cdot p^k \cdot (1 - p)^{n - k}
$$

其中：

- $\binom{n}{k}$ 是 [[Binomial Coefficient]]：“从 $n$ 次实验中取 $k$ 次成功”
- $p^k$ 是成功的概率
- $(1 - p)^{n - k}$ 是失败的概率

---

## 4. 示例图像与对称性

### ✅ 如果 $p = 0.5$（公平硬币）：

- 分布是**对称的**
- 最大值出现在 $k = n/2$

### ⚠️ 如果 $p \ne 0.5$：

- 分布是**偏斜的（skewed）**
- 比如 $p = 0.3$，更偏向 0 附近（成功次数少）

---

## 7. 常见性质总结

- **期望**：$E[X] = n \cdot p$
- **方差**：$\text{Var}(X) = n \cdot p \cdot (1 - p)$

# 📐 二项分布的期望与方差推导

---

## 🎯 设定

设 $X \sim \text{Binomial}(n, p)$，表示进行 $n$ 次独立伯努利试验（每次成功概率 $p$），$X$ 是成功次数。

我们可以将 $X$ 拆成 $n$ 个独立的 0-1 伯努利变量之和：

$$
X = X_1 + X_2 + \cdots + X_n,\quad X_i \sim \text{Bernoulli}(p)
$$

---

## 🧮 期望（Expectation）

利用**期望的线性性**：

$$
E[X] = E\left[\sum_{i=1}^n X_i\right] = \sum_{i=1}^n E[X_i]
$$

对于伯努利变量：

$$
E[X_i] = 1 \cdot p + 0 \cdot (1 - p) = p
$$

所以：

$$
E[X] = n \cdot p
$$

---

## 📊 方差（Variance）

利用**独立变量方差可加性**：

$$
\text{Var}(X) = \text{Var}\left(\sum_{i=1}^n X_i\right) = \sum_{i=1}^n \text{Var}(X_i)
$$

对于伯努利变量：

$$
\text{Var}(X_i) = p(1 - p)
$$

所以：

$$
\text{Var}(X) = n \cdot p(1 - p)
$$
