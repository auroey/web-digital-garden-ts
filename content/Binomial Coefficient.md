---
title: Binomial Coefficient
date: 2025-08-15
---

## 1. 定义

二项式系数 $\binom{n}{k}$ 表示从 $n$ 个元素中**不重复地选出 $k$ 个**的**组合数**，与顺序无关。

$$
\binom{n}{k} = \frac{n!}{k! \cdot (n-k)!}
$$

---

## 2. 推导

### 🚶 步骤一：考虑有序选取

从 $n$ 个元素中依次选出 $k$ 个，有：

$$
n \cdot (n-1) \cdot \cdots \cdot (n-k+1) = \frac{n!}{(n-k)!}
$$

### 🚫 步骤二：去重（顺序无关）

每组 $k$ 个元素有 $k!$ 种排列方式，所以我们要除以 $k!$：

$$
\binom{n}{k} = \frac{n!}{k! \cdot (n-k)!}
$$

---

## 3. 特殊值

- $\binom{n}{0} = \binom{n}{n} = 1$
- $\binom{n}{1} = \binom{n}{n-1} = n$
- $\binom{n}{k} = \binom{n}{n-k}$（对称性）

---

## 4. 在二项分布中的作用

在 **二项分布**中：

$$
P(X = k) = \binom{n}{k} \cdot p^k \cdot (1-p)^{n-k}
$$

其中：

- $\binom{n}{k}$ 表示在 $n$ 次实验中恰好出现 $k$ 次成功的**排列总数**
- $p^k$ 表示 $k$ 次成功的概率
- $(1-p)^{n-k}$ 表示其余 $n-k$ 次失败的概率
