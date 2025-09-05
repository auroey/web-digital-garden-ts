---
title: BCE, binary cross-entropy
date: 2025-09-05
---
对每个样本，若真实标签 $y\in{0,1}$，预测概率为 $p=\sigma(z)$（$z$ 是 logit），交叉熵衡量预测分布与真实分布的差异：预测越接近真实，损失越小。

$$\ell(p,y)=-
\begin{bmatrix}
y\log p+(1-y)\log(1-p)
\end{bmatrix}$$