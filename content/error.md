---
title: error
date: 2025-09-05
---
- 误差（error）：  
  $$
  \hat{y}^{(i)} - y^{(i)}
  $$
- 平方误差（squared error）：  
  $$
  \big(\hat{y}^{(i)} - y^{(i)}\big)^2
  $$
- 均方误差 ([[MSE, Mean Squared Error]])
$$
J(w,b) = \frac{1}{2m} \sum_{i=1}^{m} \Big( f_{w,b}(x^{(i)}) - y^{(i)} \Big)^2
$$
	 $m$ 个样本，把每个样本的平方误差加起来：  
	  $$
	  \sum_{i=1}^{m} \Big( \hat{y}^{(i)} - y^{(i)} \Big)^2
	  $$
	为了不受样本数影响，取平均：  
	  $$
	  \frac{1}{m} \sum_{i=1}^{m} \Big( \hat{y}^{(i)} - y^{(i)} \Big)^2
	  $$
	传统上再除以 $2$（方便后续求导）
	