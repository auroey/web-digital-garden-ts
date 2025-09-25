---
title: Loss Function
date: 2025-09-18
---
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509111133861.png)# 常见损失函数速览（Markdown）

下面是几种常见损失函数的公式、直观含义、优缺点、梯度以及简单代码示例（NumPy / PyTorch）。把方括号替换成你的变量即可。

---

## 1. MSE / RMSE（L2 loss）
**公式**  
$$
\mathrm{MSE}=\frac{1}{n}\sum_{i=1}^n (y_i-\hat y_i)^2,\qquad
\mathrm{RMSE}=\sqrt{\mathrm{MSE}}.
$$

**直观**：平方惩罚把大错误放大，平滑可导，适用于回归。  
**优缺点**：
- 优点：数学性质好、可导、与高斯噪声下的 MLE 等价。  
- 缺点：对离群点敏感。

**梯度（对预测 $\hat y_i$）**  
$$
\frac{\partial \mathrm{MSE}}{\partial \hat y_i} = -\frac{2}{n}(y_i-\hat y_i).
$$

**NumPy 示例**
```python
import numpy as np
y = np.array([2.0,3.0,5.0])
y_hat = np.array([1.8,2.9,5.2])
mse = np.mean((y - y_hat)**2)
grad = -2*(y - y_hat)/len(y)
