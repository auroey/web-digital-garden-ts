---
title: Box-Plot
date: 2025-08-16
---
一种常用的统计图，用来展示数据分布的“五数概括”：
使用[[Quantiles]]作为部分指标
结合[[Kernel Density Estimation, KDE]]成为[[Violin Plot]]
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250816115928.png)

| 组件名      | 含义        |
| -------- | --------- |
| 最小值（Min） | 非异常值中的最小值 |
| Q1（25%）  | 第一四分位数    |
| Q2（50%）  | 中位数       |
| Q3（75%）  | 第三四分位数    |
| 最大值（Max） | 非异常值中的最大值 |
### 外部值（Outliers）

- 通常定义为超过 $[Q1 - 1.5IQR, Q3 + 1.5IQR]$ 的值
    
- 其中 $IQR = Q3 - Q1$ 是**四分位距**