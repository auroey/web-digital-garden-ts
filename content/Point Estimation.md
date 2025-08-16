---
title: Point Estimation
date: 2025-08-16
---

### 点估计的常见方法
1. **最大似然估计 ([[Maximum Likelihood Estimation, MLE]])**
   - 定义：寻找参数 $\theta$，使得在该参数下观测数据的似然函数最大化。
   - 应用广泛，尤其在机器学习中非常常见。

1. **最大后验估计 ([[Maximum A Posteriori Estimation, MAP]])**
   - 来源：基于 **[[Bayes Theorem]]** 对 MLE 的推广。
   - 定义：在给定先验分布 $p(\theta)$ 的情况下，找到使后验分布 $p(\theta | \text{data})$ 最大化的 $\theta$。
   - 与 MLE 的关系：
     - MLE 只考虑数据似然 $p(\text{data}|\theta)$。
     - MAP 同时结合了 **先验信息** $p(\theta)$。

---

### MLE 与 MAP 的关系
- MAP 可以看作是 **带正则化的 MLE**：
  - MLE：只最大化似然函数
  - MAP：最大化 $p(\theta|\text{data}) \propto p(\text{data}|\theta) \cdot p(\theta)$
  - 其中 $p(\theta)$ 起到 **正则化（regularization）** 的作用
- 正则化的常见用途：防止过拟合（overfitting）

