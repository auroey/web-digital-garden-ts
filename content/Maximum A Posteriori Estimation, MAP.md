---
title: Maximum A Posteriori Estimation, MAP
date: 2025-08-16
---

MAP 估计是基于 [[Bayes Theorem]] 的参数估计方法，在看到数据 $X$ 后，找到参数 $\theta$ 的后验分布 $P(\theta|X)$ 的**众数（mode）**，“最大概率的点”就是 **后验分布的众数**：  

$$
\hat{\theta}_{MAP} = \arg\max_{\theta} P(\theta|X)
$$

根据贝叶斯公式：  

$$
P(\theta|X) = \frac{P(X|\theta) P(\theta)}{P(X)}
$$  

因为 $P(X)$ 与 $\theta$ 无关，所以 MAP 等价于：  

$$
\hat{\theta}_{MAP} = \arg\max_{\theta} \big[ P(X|\theta) \cdot P(\theta) \big]
$$

---

## 与 MLE 的关系  
- **MLE（最大似然估计）**：  
  $$\hat{\theta}_{MLE} = \arg\max_{\theta} P(X|\theta)$$  
  → 只看数据（似然），不考虑先验。  

- **MAP（最大后验估计）**：  
  $$\hat{\theta}_{MAP} = \arg\max_{\theta} P(X|\theta) P(\theta)$$  
  → 同时考虑数据（似然）和先验知识。  

---

## 直观理解  
- **MLE**：谁能最好地解释现有数据，就选谁。  
- **MAP**：谁能最好地解释现有数据，同时又符合我们对世界的先验认知，就选谁。  

---

## 举例  
- **数据**：看到地上有爆米花  
- **MLE**：认为最可能是「爆米花比赛」，因为这种场景最容易产生爆米花。  
- **MAP**：会认为「看电影」更合理，因为虽然比赛解释力更强，但它发生的先验概率极低。  

---

## 与正则化的关系  
在机器学习中，MAP 常常对应 **正则化**：  
- 在线性回归中，加上 **L2 正则化** 相当于假设参数服从 **高斯先验**。  
- 所以可以把 **MAP 看作 “MLE + 先验约束”**。如果先验是**均匀分布**，MAP = MLE。
- **MAP = argmax Posterior**（最大化后验）。  
- **MLE = argmax Likelihood**（最大化似然）。  
