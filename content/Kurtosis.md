---
title: Kurtosis
date: 2025-08-16
---

峰度衡量分布的**尖锐**程度。

定义：

$$
\text{Kurtosis} = \frac{\mathbb{E}[(X - \mu)^4]}{\sigma^4}
$$

- 标准正态分布的峰度是 3
- 通常我们更关注过峰度（Excess Kurtosis）：

$$
\text{Excess Kurtosis} = \text{Kurtosis} - 3
$$

| 类型            | 解释                         |
|-----------------|------------------------------|
| Excess Kurtosis > 0 | 尖峰（Leptokurtic）         |
| Excess Kurtosis < 0 | 平峰（Platykurtic）         |
| Excess Kurtosis = 0 | 中等峰（Mesokurtic，例如正态） |
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250816114214.png)
