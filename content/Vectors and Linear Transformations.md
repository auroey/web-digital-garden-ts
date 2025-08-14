---
title: Vectors and Linear Transformations
date: 2025-08-14
---

## **向量的基本概念**

- 向量就是一组数字，可以是 2 个、3 个或更多。
    
- **维度**：向量中数字的个数。例如：
    
    - $(4,3)$ → 二维平面上的点，指向 $(4,3)$。
        
    - $(4,3,1)$ → 三维空间的点，指向 $(4,3,1)$。
        

---

## **向量的两个核心属性**

1. **大小（magnitude / norm）**
    
2. **方向（direction）**
    

---

### **1. 向量的大小**

#### **(a) L1 范数（Taxicab distance / 曼哈顿距离）**

只能走水平和垂直路径时的距离：

$$\|\mathbf{x}\|_1=|a|+|b|$$

更一般地（n 维向量 $\mathbf{x} = (x_1, x_2, \dots, x_n)$）：

$$\|\mathbf{x}\|_1=\sum_{i=1}^n|x_i|$$

#### **(b) L2 范数（Euclidean distance / 直线距离）**

像直升机飞一样走直线：  
二维：

$$\|\mathbf{x}\|_2=\sqrt{a^2+b^2}$$

n 维：

$$\|\mathbf{x}\|_2=\sqrt{\sum_{i=1}^nx_i^2}$$

默认情况下，$|x|$ 表示 **L2 范数**。

---

### **2. 向量的方向**

- 对于二维向量 $(a,b)$，方向角 $\theta$（与 x 轴夹角）：
    

---

## **方向与大小的独立性**

- $(4,3)$ 与 $(2,1.5)$ **方向相同**（比例一致），但大小不同。
    
- 大小缩放不会改变方向。
    

---

## **向量的表示方法**

- **行向量**：$(a, b)$
    
- **列向量**：...
    

- 也可以用 $\vec{x}$、**x** 表示向量。
    
- 括号与方括号只是记号差异，无概念区别。
    

# Linear Transformations

Parallelogram rule：平行四边形的**对角线**
Difference of vectors：平行四边形的**另一条对角线**
Scalar multiplication：拉长、缩短、反向

## 1. 点积（Dot Product）定义
给定两个 $n$ 维向量  
$\mathbf{x} = (x_1, x_2, \dots, x_n), \quad \mathbf{y} = (y_1, y_2, \dots, y_n)$  

**点积定义**：
$$
\mathbf{x} \cdot \mathbf{y} = \sum_{i=1}^n x_i y_i
$$
另一种常用记法：
$$
\langle \mathbf{x}, \mathbf{y} \rangle
$$

---

## 2. 例子：水果价格
- 水果数量向量：
$$
\mathbf{q} = (2, 4, 1)^T
$$
- 单价向量：
$$
\mathbf{p} = (3, 5, 2)^T
$$

**总价**：
$$
\mathbf{q} \cdot \mathbf{p} = 2 \times 3 + 4 \times 5 + 1 \times 2 = 6 + 20 + 2 = 28
$$

矩阵写法（行向量 × 列向量）：
$$
\mathbf{q}^T \mathbf{p} =
\begin{bmatrix}
2 & 4 & 1
\end{bmatrix}
\begin{bmatrix}
3 \\ 5 \\ 2
\end{bmatrix} = 28
$$

---

## 3. 点积与范数（Norm）的关系
**L2 范数**：
$$
\|\mathbf{x}\|_2 = \sqrt{\mathbf{x} \cdot \mathbf{x}}
$$

**例**：
$$
\mathbf{x} = (4, 3) \quad\Rightarrow\quad
\mathbf{x} \cdot \mathbf{x} = 4 \times 4 + 3 \times 3 = 25
$$
$$
\|\mathbf{x}\|_2 = \sqrt{25} = 5
$$

---

## 4. 转置（Transpose）
- **列向量 → 行向量**：
$$
\mathbf{x}^T = 
\begin{bmatrix} x_1 & x_2 & \dots & x_n \end{bmatrix}
$$

- **行向量 → 列向量**：
$$
(\mathbf{x}^T)^T = \mathbf{x}
$$

- **矩阵转置**：
若 $A$ 是 $m \times n$ 矩阵，$A^T$ 是 $n \times m$ 矩阵，行列互换：
$$
A =
\begin{bmatrix}
a_{11} & a_{12} \\
a_{21} & a_{22} \\
a_{31} & a_{32}
\end{bmatrix}
\quad\Rightarrow\quad
A^T =
\begin{bmatrix}
a_{11} & a_{21} & a_{31} \\
a_{12} & a_{22} & a_{32}
\end{bmatrix}
$$

---

## 5. 关键要点
- 点积本质上是**对应元素相乘再相加**  
- **几何意义**（二维/三维）：  
$$
\mathbf{x} \cdot \mathbf{y} = \|\mathbf{x}\|_2 \|\mathbf{y}\|_2 \cos\theta
$$
- 范数是点积的特殊情况（向量和自己点积再开方）  
- 转置用于调整向量形状（行 vs 列）以便做矩阵运算  

## 6. 点积与向量夹角关系

### 6.1 正交（Orthogonal）与点积为 0
- **定义**：若 $\mathbf{u} \cdot \mathbf{v} = 0$，则 $\mathbf{u}$ 与 $\mathbf{v}$ **正交**（垂直）。
- **例子**：
$$
\mathbf{u} = (-1, 3), \quad \mathbf{v} = (6, 2)
$$
$$
\mathbf{u} \cdot \mathbf{v} = (-1) \times 6 + 3 \times 2 = -6 + 6 = 0
$$
$\Rightarrow$ 两向量正交。

---

### 6.2 点积的几何公式
对于任意 $\mathbf{u}, \mathbf{v}$，有：
$$
\mathbf{u} \cdot \mathbf{v} = \|\mathbf{u}\|_2 \cdot \|\mathbf{v}\|_2 \cdot \cos\theta
$$
其中：
- $\theta$ 是 $\mathbf{u}$ 与 $\mathbf{v}$ 的夹角
- $\|\mathbf{u}\|_2$ 表示 L2 范数（长度）

---

### 6.3 投影解释
- **点积等于一个向量在另一个向量上的投影长度 × 另一个向量的长度**
- 无论是 $\mathbf{u}$ 投影到 $\mathbf{v}$，还是 $\mathbf{v}$ 投影到 $\mathbf{u}$，点积结果相同

公式：
$$
\mathbf{u} \cdot \mathbf{v} = \|\mathbf{u}\| \cdot (\|\mathbf{v}\| \cos\theta)
$$

---

### 6.4 点积符号与方向关系
- **$\mathbf{u} \cdot \mathbf{v} > 0$**：夹角 $\theta \in (0^\circ, 90^\circ)$，同向成分为正
- **$\mathbf{u} \cdot \mathbf{v} = 0$**：夹角 $\theta = 90^\circ$，正交
- **$\mathbf{u} \cdot \mathbf{v} < 0$**：夹角 $\theta \in (90^\circ, 180^\circ)$，反向成分为负

**例**：  
设 $\mathbf{u} = (6, 2)$  
- $\mathbf{v}_1 = (-1, 3)$  
$$
\mathbf{u} \cdot \mathbf{v}_1 = 0 \quad\Rightarrow\quad 正交
$$
- $\mathbf{v}_2 = (2, 4)$  
$$
\mathbf{u} \cdot \mathbf{v}_2 = 6\times 2 + 2\times 4 = 20 > 0 \quad\Rightarrow\quad 夹角锐角
$$
- $\mathbf{v}_3 = (-4, 1)$  
$$
\mathbf{u} \cdot \mathbf{v}_3 = 6\times (-4) + 2\times 1 = -22 < 0 \quad\Rightarrow\quad 夹角钝角
$$

---

### 6.5 几何区域
- 对于固定向量 $\mathbf{u}$：
    - **正交区域**：所有与 $\mathbf{u}$ 点积为 0 的向量，位于一条垂直于 $\mathbf{u}$ 的直线上
    - **正点积区域**：位于 $\mathbf{u}$ 正方向的半平面
    - **负点积区域**：位于 $\mathbf{u}$ 反方向的半平面

## 7. 矩阵与向量相乘

### 7.1 点积回顾
- 两个向量的点积（dot product）：  
$$
\mathbf{u} \cdot \mathbf{v} = \sum_{i=1}^n u_i v_i
$$
- 例：  
$$
2a + 4b + c = 28
$$
可写为：
$$
[2, 4, 1] \cdot
\begin{bmatrix}
a \\ b \\ c
\end{bmatrix}
= 28
$$

---

### 7.2 系统的线性方程组
假设有三个未知数 $a, b, c$ 和三个方程：
$$
\begin{cases}
a + b + c = 10 \\
a + 2b + c = 15 \\
a + b + 2c = 12
\end{cases}
$$

每个方程都可表示为 **行向量** 与 **列向量** 的点积：
$$
[1, 1, 1] \cdot \begin{bmatrix} a \\ b \\ c \end{bmatrix} = 10
$$
$$
[1, 2, 1] \cdot \begin{bmatrix} a \\ b \\ c \end{bmatrix} = 15
$$
$$
[1, 1, 2] \cdot \begin{bmatrix} a \\ b \\ c \end{bmatrix} = 12
$$

---

### 7.3 矩阵-向量乘法
将系数向量 **按行堆叠** 形成矩阵：
$$
\begin{bmatrix}
1 & 1 & 1 \\
1 & 2 & 1 \\
1 & 1 & 2
\end{bmatrix}
\begin{bmatrix}
a \\ b \\ c
\end{bmatrix}
=
\begin{bmatrix}
10 \\ 15 \\ 12
\end{bmatrix}
$$

**意义**：
- **矩阵 × 向量** = **多个点积的堆叠**。
- 每一行与列向量的点积得到一个结果，结果按行组成新的列向量。

---

### 7.4 维度匹配条件
- 若矩阵是 $m \times n$，向量必须是 $n \times 1$。
- 乘积结果是 $m \times 1$ 向量。
- **列数 = 向量长度**，否则点积无法定义。
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250814203654.png)

---

### 7.5 矩形矩阵情况
- 矩阵不一定是方阵。
- 例：$4\times 3$ 矩阵 × 长度为 3 的列向量 → 结果是长度为 4 的列向量。

---

### 7.6 总结
- 矩阵 × 向量本质是**批量点积**。
- 这是表达和求解线性方程组的标准方式：
$$
A \mathbf{x} = \mathbf{b}
$$
其中：
- $A$ 是系数矩阵
- $\mathbf{x}$ 是未知变量列向量
- $\mathbf{b}$ 是常数列向量

Matrices as linear transformations：把平面（或更高维空间）上的每个点，按照某种结构化规则**映射**到另一个点。

性质：线性变换——原点不变的基变换导致向量变换

[[Linear transformations as matrices]]