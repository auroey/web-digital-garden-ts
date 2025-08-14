---
title: determinant
date: 2025-08-14
---
最方便、通用而且不容易出错的方法就是**[[Gaussian Elimination]] 化为上三角矩阵**：

1. **用初等行变换**把矩阵化成上三角（对角线下方全是 0）。
    
2. 记录变换对行列式的影响：
    
    - 交换两行：$\det$ 变号（乘 $-1$）
        
    - 某行乘 $k$：$\det$ 乘 $k$
        
    - 某行加另一行的倍数：$\det$ 不变
        
3. 化成上三角后，**行列式 = 对角线上元素的乘积 × 所有变换的累计系数**。
    

## 2×2
给 $A=\begin{bmatrix}a & b\\ c & d\end{bmatrix}$  
$\det(A)=ad-bc$

**例**：$\begin{bmatrix}1&1\\2&3\end{bmatrix}$，$\det=1\cdot3-1\cdot2=1$

---

## 3×3（Sarrus 法）
给 $A=\begin{bmatrix}a&b&c\\ d&e&f\\ g&h&i\end{bmatrix}$  
$\det(A)=aei+bfg+cdh-ceg-bdi-afh$

**例**：$\begin{bmatrix}1&2&3\\0&1&4\\5&6&0\end{bmatrix}$  
$\det=1\cdot1\cdot0+2\cdot4\cdot5+3\cdot0\cdot6-3\cdot1\cdot5-2\cdot0\cdot0-1\cdot4\cdot6=40-15-24=1$

---

## 一般 $n\times n$（拉普拉斯展开 / 代数余子式）
对第 $i$ 行展开：
$\displaystyle \det(A)=\sum_{j=1}^{n}(-1)^{i+j}a_{ij}\,M_{ij}$
其中 $M_{ij}$ 是删去第 $i$ 行第 $j$ 列后的子式的行列式。

**小技巧**：选择**零多**的行/列展开更快。

---

## 行初等变换对行列式的影响
- 交换两行：$\det$ 变号  
- 某行乘以标量 $k$：$\det$ 乘以 $k$  
- 某行加上另一行的 $k$ 倍：$\det$ 不变

**实用法**：用高斯消元把矩阵化为上三角，记录上述影响，最后对角线乘积即为 $\det$。

---

## 三角矩阵 / 对角矩阵
若 $A$ 是上/下三角或对角矩阵：  
$\det(A)=\prod_{i=1}^n a_{ii}$

---

## 块三角矩阵
$A=\begin{bmatrix}B & *\\ 0 & C\end{bmatrix}$ 或 $\begin{bmatrix}B & 0\\ * & C\end{bmatrix}$  
$\det(A)=\det(B)\det(C)$

---

## 常用性质
- $\det(AB)=\det(A)\det(B)$
- $\det(A^T)=\det(A)$
- 若 $A$ 可逆，则 $\det(A)\neq 0$；且 $\det(A^{-1})=\dfrac{1}{\det(A)}$
- 任意两行（或两列）**线性相关** $\Rightarrow \det(A)=0$
