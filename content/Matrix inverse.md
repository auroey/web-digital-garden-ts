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

矩阵和数字的倒数很像： 数字 $0$ 没有倒数，因为没有任何数与 $0$ 相乘等于 $1$

- 有些矩阵有逆（可逆矩阵 / **invertible**）：非奇异矩阵
- 有些矩阵没有逆（不可逆矩阵 / **non-invertible**）：奇异矩阵

**行列式**（determinant）是判断矩阵是否可逆的核心：
$$
\det(A) \neq 0 \quad\Rightarrow\quad A \text{ 可逆}
$$
$$
\det(A) = 0 \quad\Rightarrow\quad A \text{ 不可逆}
$$
