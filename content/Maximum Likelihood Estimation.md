---
title: Maximum Likelihood Estimation
date: 2025-08-15
---
最大似然估计（MLE）是一种通过使观测数据在模型参数下的概率最大，来估计参数的方法。

从所有可能的参数 $\theta$ 中，挑出一个让“观测到这些数据”的概率最大的那个，作为我们的参数估计值。本质是求**起因到底是什么**。

公式为：

$$
\hat{\theta}_{MLE} = \arg \max_{\theta} P(\text{数据} \mid \theta)
$$
- **$P(\text{数据} \mid \theta)$**
    
    - 读作「在参数 $\theta$ 给定的情况下，观测到这些数据的概率」
        
    - 这就是 似然（[[Likelihood]]） 的定义，只不过在 MLE 里它是作为关于参数 $\theta$ 的函数来用的。
        
- **$\arg\max_{\theta}$**
    
    - 表示「找到能让这个概率值最大的那个 $\theta$」
        
    - 这里不是取概率的最大值，而是取让它达到最大值的参数。