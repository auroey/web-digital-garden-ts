---
title: Matrix inverse
date: 2025-08-14
---
## 矩阵的逆（Inverse Matrix）

我们可以把**矩阵的逆**类比成**数字的倒数**：  
- 数字 $2$ 的倒数是 $\frac12$，因为 $2 \cdot \frac12 = 1$  
- 矩阵 $A$ 的逆矩阵 $A^{-1}$ 满足：  
$$
A \cdot A^{-1} = I
$$
其中 $I$ 是单位矩阵。  

---

### 1. 几何意义
- $A$ 表示一个线性变换，把单位方形变成一个平行四边形。
- $A^{-1}$ 则是能把这个平行四边形变回原单位方形的变换。
- 组合 $A^{-1} \circ A$ 等于**恒等变换**（什么都不做）。

---

### 2. 符号
和数字一样，我们用 $A^{-1}$ 表示逆矩阵：
- $2^{-1} = \frac12$
- $A^{-1}$ 表示矩阵 $A$ 的逆

---

### 3. 如何求逆矩阵（$2\times 2$ 情况）
设  
$$
A =
\begin{bmatrix}
3 & 1 \\
1 & 2
\end{bmatrix}
\quad
A^{-1} =
\begin{bmatrix}
a & b \\
c & d
\end{bmatrix}
$$  
要求 $A \cdot A^{-1} = I$，即：
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250814205945.png)


$$
\begin{cases}
3a + 1c = 1 \\
3b + 1d = 0 \\
1a + 2c = 0 \\
1b + 2d = 1
\end{cases}
$$  
解得：
$$
a = \frac25,\quad b = -\frac15,\quad c = -\frac15,\quad d = \frac35
$$

---

### 4. 逆矩阵存在条件
不是所有矩阵都有逆。  
例如某矩阵解出来的方程组出现：
$$
a+c=1,\quad 2a+2c=0
$$
显然矛盾（$a+c$ 不可能既等于 $1$ 又等于 $0$），因此此矩阵**不可逆**。
