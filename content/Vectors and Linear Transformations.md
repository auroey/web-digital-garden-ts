---
title: Vectors and Linear Transformations
date: 2025-08-14
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


向量组：一组向量的集合的名称

线性相关：其中有向量可以被其他向量线性表示

线性表示：某些向量数乘后的组合
- 如果两个向量组能互相线性表示，则称二者等价

向量空间（张成空间 / [[span]]）：几个向量的线性表示的组合的活动范围。可以用向量组来表示
- R^n
- 三维的原点与二维原点维度不同，不能被视为二维，但仍然可以作为向量空间，只不过是三维向量空间
- 子空间

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

## 矩阵乘法在神经网络中的应用：线性分类器与感知机

### 1. 问题背景：垃圾邮件分类
- 数据集中有两个高相关词：**lottery** 和 **win**
- 目标：建立一个分类器（classifier）来判断邮件是否为垃圾邮件（spam）

---

### 2. 分类器机制
1. 为每个词赋一个**权重**（score/weight）  
   - 例：`lottery = 3`，`win = 2`
2. 邮件得分 = 每个词出现次数 × 对应权重，再求和（**点积 dot product**）
3. **阈值判断（threshold）**：
   - 分数 ≥ 阈值 → 分类为垃圾邮件
   - 分数 < 阈值 → 分类为非垃圾邮件

例：
- `lottery=1`，`win=1`，阈值=1.5
- “win win lottery” → $2\times1 + 1\times1 = 3 \ge 1.5$ → spam

---

### 3. 线性分类器的几何解释
- 横轴：lottery 出现次数
- 纵轴：win 出现次数
- 分类边界：$1 \cdot \text{lottery} + 1 \cdot \text{win} = 1.5$
- 直线将平面分为**正类区域**（spam）和**负类区域**（not spam）

---

### 4. 矩阵形式
设：
- 数据矩阵 $X$（行=邮件，列=特征，即词的出现次数）
- 权重向量 $w$
- 阈值 $t$

预测：
$$
\text{score} = X \cdot w
$$
$$
\hat{y} = \begin{cases}
\text{spam} & \text{if score} \ge t \\
\text{not spam} & \text{otherwise}
\end{cases}
$$

---

### 5. 阈值与偏置（Bias）
- 阈值判断 $\text{score} \ge t$ 等价于 $\text{score} - t \ge 0$
- 将 $b = -t$ 作为 **bias**，可写成：
$$
\text{score} = X \cdot w + b
$$
- 检查 $\text{score} \ge 0$ → spam

矩阵实现：
- 在数据矩阵 $X$ 增加一列常数 $1$
- 在权重向量 $w$ 增加一个分量 $b$

---

### 6. AND 运算的感知机实现
- 数据：$(x,y)$ → 1（是）当且仅当 $x=1$ 且 $y=1$
- 模型：
$$
w = (1,1), \quad b = -1.5（可变数）
$$
- 分类边界：$x + y - 1.5 = 0$
- 对应**单层感知机（Perceptron）**：
    1. 输入 $(x,y)$
    2. 计算 $z = w \cdot (x,y) + b$
    3. 激活函数（step function）：$z \ge 0 \to 1$，否则 $0$

---

### 7. 感知机公式
$$
\text{output} = \text{activation}( w \cdot x + b )
$$
- **权重** $w$：特征重要性
- **偏置** $b$：调整决策边界位置
- **激活函数**：将线性结果转为类别（0/1）
