---
title: Central Limit Theorem
date: 2025-08-15
---
无论原始分布如何（即使非常偏斜），当我们取大量相同规模的样本并计算其均值时，这些**样本均值的分布**会趋近于正态分布。


若 $X_1, X_2, \dots, X_n$ 为独立同分布随机变量，  
每个 $X_i$ 有期望 $\mu$、方差 $\sigma^2$，定义样本平均：

$$
\bar{X}_n = \frac{1}{n}\sum_{i=1}^n X_i
$$

则当 $n \to \infty$ 时：

$$
\frac{\bar{X}_n - \mu}{\sigma / \sqrt{n}}
\ \overset{d}{\longrightarrow}\ 
\mathcal{N}(0,1)
$$

## 3. 应用场景

1. **抽样分布**  
   - 调查中用样本均值估计总体均值  
   - 可用正态近似构造置信区间
  
2. **[[Monte Carlo Simulation]]**  
   - 多次独立模拟结果的平均  
   - 误差分布可用正态近似
  
3. **统计推断**  
   - 大样本下 t 检验、渐近检验、线性回归假设检验等

