---
title: Describing probability distributions and probability distributions with multiple variables
date: 2025-08-15
---
分布中心的三种度量方式

| 名称            | 定义                 | 优点                | 缺点                    |
| ------------- | ------------------ | ----------------- | --------------------- |
| 均值（Mean）/ 期望值 | 所有值加权平均（权重为**概率**） | 易计算，有数学优美性质（如线性性） | 极易被**异常值（outlier）**影响 |
| 中位数（Median）   | 将数据排序后位于正中间的值      | 抗异常值强，反映**位置**而非值 | 不适合进一步计算（如方差）         |
| 众数（Mode）      | 出现频率最高的值           | 对于**分类变量**很有用     | 不一定唯一，或可能没有（如均匀分布）    |

对于离散型随机变量 $X$，其概率质量函数为 $p(x)$，若 $g$ 是定义在 $X$ 取值上的任意函数，则：

$$
\mathbb{E}[g(X)] = \sum_x g(x) \cdot p(x)
$$

对于连续型随机变量 $X$，其概率密度函数为 $f(x)$，则：

$$
\mathbb{E}[g(X)] = \int_{-\infty}^{\infty} g(x) \cdot f(x) \, dx
$$

---

## 💡 常见例子

- $\mathbb{E}[X]$：期望
- $\mathbb{E}[X^2]$：二阶矩，用于计算方差
- $\mathbb{E}[|X - \mu|]$：绝对偏差

---

## 🧠 线性性质

期望运算符 $\mathbb{E}$ 是线性的，即对于常数 $a, b$ 和函数 $g(X)$：

$$
\mathbb{E}[a \cdot g(X) + b] = a \cdot \mathbb{E}[g(X)] + b
$$

例如：

- $\mathbb{E}[2X - 5] = 2 \cdot \mathbb{E}[X] - 5$
- $\mathbb{E}[\text{常数}] = \text{常数}$

---

## 🎲 例子：掷骰子

### 例 1：$\mathbb{E}[X^2]$

掷一颗六面骰子，$X$ 表示点数，$P(X=x) = \frac{1}{6}$。

$$
\mathbb{E}[X^2] = \sum_{x=1}^6 x^2 \cdot \frac{1}{6} = \frac{1}{6}(1^2 + 2^2 + \cdots + 6^2) = \frac{91}{6}
$$

### 例 2：$\mathbb{E}[2X - 5]$

$$
\mathbb{E}[2X - 5] = 2 \cdot \mathbb{E}[X] - 5 = 2 \cdot \frac{1+2+3+4+5+6}{6} - 5 = 2 \cdot 3.5 - 5 = 2
$$

---

## ✅ 总结

- 求 $g(X)$ 的期望，只需对每个 $x$ 计算 $g(x) \cdot P(x)$ 后求和（或积分）
- 期望有线性性质，可化简运算
- 常用于处理非线性奖励、损失、变换等场景
