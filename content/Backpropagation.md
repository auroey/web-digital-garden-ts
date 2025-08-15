---
title: Backpropagation
date: 2025-08-15
---
[[5分钟深度学习] #02 反向传播算法\_哔哩哔哩\_bilibili](https://www.bilibili.com/video/BV1yG411x7Cc/?spm_id_from=333.337.search-card.all.click&vd_source=8be5ba4fcf7c69b9960ed391f70c5fb0)


# 链式法则与反向传播推导

## 1. 线性回归中的链式法则推导

### 1.1 结构关系
- $L$ 依赖于 $\hat{y}$：
  $$
  L \to \hat{y}
  $$
- $\hat{y}$ 依赖于 $w_1, w_2, b$：
  $$
  \hat{y} = w_1 x_1 + w_2 x_2 + b
  $$

### 1.2 公共部分
对所有参数：
$$
\frac{\partial L}{\partial \hat{y}} = - (y - \hat{y})
$$
> 因为 $L = \frac{1}{2}(y - \hat{y})^2$，求导得到 $(y - \hat{y})(-1)$

### 1.3 各参数的局部导数
$$
\frac{\partial \hat{y}}{\partial b} = 1
$$
$$
\frac{\partial \hat{y}}{\partial w_1} = x_1
$$
$$
\frac{\partial \hat{y}}{\partial w_2} = x_2
$$

### 1.4 梯度公式
结合链式法则：
$$
\frac{\partial L}{\partial b} = - (y - \hat{y}) \cdot 1
$$
$$
\frac{\partial L}{\partial w_1} = - (y - \hat{y}) \cdot x_1
$$
$$
\frac{\partial L}{\partial w_2} = - (y - \hat{y}) \cdot x_2
$$

### 1.5 参数更新（梯度下降）
$$
w_1 \leftarrow w_1 + \alpha (y - \hat{y}) x_1
$$
$$
w_2 \leftarrow w_2 + \alpha (y - \hat{y}) x_2
$$
$$
b \leftarrow b + \alpha (y - \hat{y})
$$
其中 $\alpha$ 为学习率。

---

## 2. 损失函数与优化目标

### 2.1 模型目标
- 找到最佳 $w_1, w_2, b$
- 使预测 $\hat{y}$ 与真实值 $y$ 的误差最小
- 误差度量：**均方误差（MSE）**

### 2.2 均方误差
对于数据集 $\{ (x_1^{(i)}, x_2^{(i)}, y^{(i)}) \}$：
$$
L(w_1, w_2, b) = \frac{1}{n} \sum_{i=1}^n \left( \hat{y}^{(i)} - y^{(i)} \right)^2
$$
其中：
$$
\hat{y}^{(i)} = w_1 x_1^{(i)} + w_2 x_2^{(i)} + b
$$

### 2.3 梯度下降法
$$
w_j \leftarrow w_j - \alpha \frac{\partial L}{\partial w_j}, \quad b \leftarrow b - \alpha \frac{\partial L}{\partial b}
$$

---

## 3. 多层神经网络的反向传播

### 3.1 网络结构
- 输入层：$x$
- 隐藏层 1：$W^{[1]}, b^{[1]}, a^{[1]} = \sigma(z^{[1]})$
- 隐藏层 2：$W^{[2]}, b^{[2]}, a^{[2]} = \sigma(z^{[2]})$
- 输出层：$W^{[3]}, b^{[3]}, \hat{y} = \sigma(z^{[3]})$

### 3.2 损失函数（Log Loss）
$$
L(y, \hat{y}) = -y \log(\hat{y}) - (1-y)\log(1-\hat{y})
$$

### 3.3 反向传播步骤

**输出层：**
$$
\delta^{[3]} = \hat{y} - y
$$
$$
\frac{\partial L}{\partial W^{[3]}} = \delta^{[3]} (a^{[2]})^\top
$$
$$
\frac{\partial L}{\partial b^{[3]}} = \delta^{[3]}
$$

**隐藏层 2：**
$$
\delta^{[2]} = (W^{[3]})^\top \delta^{[3]} \odot a^{[2]}(1-a^{[2]})
$$
$$
\frac{\partial L}{\partial W^{[2]}} = \delta^{[2]} (a^{[1]})^\top
$$
$$
\frac{\partial L}{\partial b^{[2]}} = \delta^{[2]}
$$

**隐藏层 1：**
$$
\delta^{[1]} = (W^{[2]})^\top \delta^{[2]} \odot a^{[1]}(1-a^{[1]})
$$
$$
\frac{\partial L}{\partial W^{[1]}} = \delta^{[1]} (x)^\top
$$
$$
\frac{\partial L}{\partial b^{[1]}} = \delta^{[1]}
$$

### 3.4 参数更新
$$
W^{[l]} \leftarrow W^{[l]} - \alpha \frac{\partial L}{\partial W^{[l]}}
$$
$$
b^{[l]} \leftarrow b^{[l]} - \alpha \frac{\partial L}{\partial b^{[l]}}
$$

