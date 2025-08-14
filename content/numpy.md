---
title: numpy
date: 2025-08-14
---


1. **NumPy 的优点**
    
    - 比 Python list 更快、更节省内存。
        
    - 有大量内置函数，方便进行矩阵和向量运算。
        
2. **数组创建**
    
    - `np.array()`：直接从 list 创建。
        
    - `np.arange(start, stop, step)`：按步长生成。
        
    - `np.linspace(start, stop, num)`：生成等间隔的指定数量值。
        
    - `np.ones()` / `np.zeros()` / `np.empty()` / `np.random.rand()`。
        
3. **多维数组**
    
    - `.ndim` 维数
        
    - `.shape` 形状
        
    - `.size` 元素个数
        
    - `np.reshape()` 改变形状
        
4. **运算**
    
    - 元素级加减乘除：`+ - * /`
        
    - **广播**（broadcasting）：数组和标量运算自动扩展。
        
5. **索引和切片**
    
    - 索引 `[row][col]` 或 `[row, col]`。
        
    - 切片 `[start:end:step]`。
        
6. **堆叠与拆分**
    
    - `np.vstack()` 垂直堆叠
        
    - `np.hstack()` 水平堆叠
        
    - `np.hsplit()` 水平拆分
        
7. **区别**
    
    - `np.zeros()` → 已初始化为 0。
        
    - `np.empty()` → 未初始化，内容是内存中的随机值。
        


[[linalg]]

## 1 线性方程组与矩阵表示 <a name="1"></a>

### 1.1 线性方程组 <a name="1.1"></a>
示例系统（编号(1)）：
$-x_1+3x_2=7,\quad 3x_1+2x_2=1$

**定义**：若线性系统没有唯一解则称为**奇异**，否则为**非奇异**。

### 1.2 矩阵表示 <a name="1.2"></a>
将(1)写成增广矩阵：
$\begin{bmatrix}-1 & 3 & 7 \\ 3 & 2 & 1\end{bmatrix}$

将系数与常数分开：  
$A=\begin{bmatrix}-1 & 3 \\ 3 & 2\end{bmatrix},\quad b=\begin{bmatrix}7 \\ 1\end{bmatrix}$

```python
import numpy as np

A = np.array([[-1, 3],
              [ 3, 2]], dtype=float)
b = np.array([7, 1], dtype=float)

print("Matrix A:\n", A)
print("\nArray b:\n", b)

print(f"Shape of A: {A.shape}")
print(f"Shape of b: {b.shape}")
````

使用 `np.linalg.solve(A, b)` 解方程：

```python
x = np.linalg.solve(A, b)
print(f"Solution: {x}")  # x[0] = x1, x[1] = x2
```

### 1.3 行列式与唯一解

若 $A$ 为方阵，则：

- $\det(A)\neq 0 \Rightarrow$ 唯一解（非奇异）
    
- $\det(A)=0 \Rightarrow$ 非唯一（奇异）
    

```python
d = np.linalg.det(A)
print(f"Determinant of matrix A: {d:.2f}")  # 非零 → 唯一解
```

---

## 2 将 2×2 系统可视化为直线

### 2.1 构造增广矩阵以作图

增广矩阵形式（对应(1)）：  
$\begin{bmatrix}-1 & 3 & 7 \ 3 & 2 & 1\end{bmatrix}$

```python
import matplotlib.pyplot as plt
from utils import plot_lines

A_system = np.hstack((A, b.reshape((2, 1))))
print(A_system)

print(A_system[1])  # 取第二行
```

### 2.2 作图与解的几何意义

两条直线交点 $(x_1,x_2)$ 即为解：

```python
plot_lines(A_system)  # 交点应为 (-1, 2)
```
