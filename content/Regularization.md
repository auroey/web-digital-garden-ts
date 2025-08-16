---
title: Regularization
date: 2025-08-16
---
## 1. 问题背景
- 给定一个数据集，可以用不同复杂度的模型去拟合：
  - **模型1**：线性模型  
  - **模型2**：二次多项式  
  - **模型3**：十次多项式  

- 使用 **平方误差 (Loss)** 衡量拟合效果：
  - 模型1：Loss = 10  
  - 模型2：Loss = 2  
  - 模型3：Loss = 0.1  

- 单纯看误差，模型3 拟合最好。但它太复杂、波动剧烈，不能很好地泛化（过拟合）。

---

## 2. 引入正则化的动机
- 我们希望找到 **既能拟合数据，又不过于复杂** 的模型。
- 方法：在误差函数中加入一个 **惩罚项 (Penalty)**，让复杂模型“代价更大”。

---

## 两种正则化

  - **L2 正则化（Ridge）**：  
    $$
    \hat{\theta} = \arg\min_\theta \|y - X\theta\|^2 + \lambda \|\theta\|^2
    $$
    对应 [[Maximum A Posteriori Estimation, MAP]]，等价于给参数加上高斯先验。  

  - **L1 正则化（Lasso）**：  
    $$
    \hat{\theta} = \arg\min_\theta \|y - X\theta\|^2 + \lambda \|\theta\|_1
    $$
    对应给参数加上 **Laplace 先验**，能产生稀疏解。

---

## 4. 正则化的公式化表达
- 原始损失函数（如对数似然损失）：  
  $$
  \mathcal{L}(\theta)
  $$
- 加上正则化后的损失：  
  $$
  \mathcal{L}_{reg}(\theta) = \mathcal{L}(\theta) + \lambda \sum_j \theta_j^2
  $$
  其中：
  - $\lambda$ = 正则化参数（控制惩罚强度）
  - $\sum_j \theta_j^2$ = L2 惩罚

---

## 5. 总结
- 正则化的作用是：
  - **抑制过拟合**（惩罚过于复杂的模型）
  - **提高泛化能力**
- 直观理解：
  - 不仅考虑“谁拟合得好”，还要考虑“谁最简单”。
- 在机器学习中：
  - [[Maximum Likelihood Estimation, MLE]]倾向于选择复杂模型；
  - **[[Maximum A Posteriori Estimation, MAP]]= MLE + 正则化（相当于引入先验约束）。

---
