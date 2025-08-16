---
title: t-Distribution
date: 2025-08-16
---
是进行[[t-Tests]]过程中，做假设得到的分布规律。

- 如果总体均值 $\mu$ 和标准差 $\sigma$ 已知，样本均值 $\bar{x}$ 服从正态分布。
- 可以定义 **Z 统计量**：
$$
Z = \frac{\bar{x} - \mu}{\sigma / \sqrt{n}}
$$
其服从标准正态分布。

- 用 **样本标准差 $S$** 代替 $\sigma$：
$$
t = \frac{\bar{x} - \mu}{S / \sqrt{n}}
$$
$$S^2=\frac{1}{n-1}\sum_{i=1}^n(x_i-\bar{x})^2$$
- $t$ 不再服从标准正态，而是服从 **t 分布**
$$t\sim t_{n-1}$$

