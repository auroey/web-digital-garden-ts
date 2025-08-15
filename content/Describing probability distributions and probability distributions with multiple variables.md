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

