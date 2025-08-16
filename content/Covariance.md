---
title: Covariance
date: 2025-08-16
---
# 原始定义

只知道数据规律（分布），算理论值：
$$\mathrm{Cov}(X,Y)=E[(X-E[X])(Y-E[Y])]=E[XY]-E[X]E[Y]$$
**离散型**：
$$\mathrm{Cov}(X,Y)=\sum_{i}\sum_{j}p(x_{i},y_{j})(x_{i}-\mu_{X})(y_{j}-\mu_{Y})$$
**连续型**：

$$\mathrm{Cov}(X,Y)=\iint f_{X,Y}(x,y)(x-\mu_{X})(y-\mu_{Y})dxdy$$

# 特例
已知实际的 events，算真实值：
$$\mathrm{Cov}(X,Y)=\frac{1}{n}\sum_{i=1}^n(x_i-\bar{x})(y_i-\bar{y})$$
- 如果 $(X,Y)$ 只有有限可能值，并且概率均等：
$$\mathrm{Cov}(X,Y)=\frac{1}{n}\sum_{i=1}^n(x_i-\mu_X)(y_i-\mu_Y)$$
