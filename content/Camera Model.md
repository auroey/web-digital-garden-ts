---
title: Camera Model
date: 2025-09-02
---
[Site Unreachable](https://zhuanlan.zhihu.com/p/668317571)

相机将**三维世界中**的坐标点（单位为**米**）映射到**二维图像平面**（单位为**像素**）的过程能够用一个几何模型进行描述，这个几何模型就是所谓的相机模型。

相机模型有一系列相机参数。最为常见的相机模型就是针孔相机模型（Pin-hole），全景相机（Omnidirectional）等等。

![[Pasted image 20250811171043.png]]

与相机的几何属性和姿态有关的两种参数：
Intrinsic Parameters：内参是描述**相机内部属性**的参数，包括焦距、主点（光学中心）坐标、畸变系数等。内参通常在相机标定时确定，因为它们通常对于特定相机型号是固定的，不随时间变化。
Extrinsic Parameters：外参是描述**相机**在世界坐标系中的**位置和姿态**的参数，通常包括旋转矩阵和平移向量。外参在不同的相机位置或拍摄时刻可能会发生变化。例如，在立体视觉中，如果您有两个相机，那么它们的相对位置和方向会在每次移动相机时发生变化，从而导致外参的变化。

坐标系：
世界坐标系就是物体在真实世界中的坐标
相机坐标系以光心为相机坐标系的原点，以平行于图像的x和y方向为Xc轴和Yc轴，单位是长度单位。
图像物理坐标系以主光轴和图像平面交点为坐标原点，x和y方向如图所示，单位是长度单位。
图像像素坐标系以图像的顶点为坐标原点，u和v方向平行于x和y方向，单位是以像素计。
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509021408807.png)
（U,V,W）是世界坐标系，经过刚体变换（如：旋转、平移）后变为了相机坐标系，再次经过透视投影转变为了图像坐标系，最后经仿射变换转换为了像素坐标系（u,v）。转换关系如下(Z是尺度因子)：

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509021413812.png)
$$
Z
\begin{pmatrix}u\\v\\1\end{pmatrix}
=
\begin{pmatrix}
\frac{1}{d_X} & -\frac{\cot\theta}{d_X} & u_0\\[4pt]
0 & \frac{1}{d_Y\sin\theta} & v_0\\[4pt]
0&0&1
\end{pmatrix}
\begin{pmatrix}f&0&0&0\\[2pt]0&f&0&0\\[2pt]0&0&1&0\end{pmatrix}
\begin{pmatrix}R & T\\[2pt]0 & 1\end{pmatrix}
\begin{pmatrix}U\\V\\W\\1\end{pmatrix}
$$
## 右侧（外参 / 世界 -> 相机）

刚体变换只改变物体的空间位置(平移)和朝向(旋转)，而不改变其形状的变换，可用两个变量来描述：正交单位旋转矩阵R，三维平移矢量t。
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509021447209.png)
- `$R$`：旋转矩阵（$3\times3$），**无单位**。描述相机朝向（把世界坐标旋转到相机坐标）。  
- `$T$`：平移向量（例如 **米** 或 **毫米**）。描述相机在世界坐标系中的位置偏移。  
- `$(U,V,W)$`：世界坐标系下三维点，单位与 `$T$` 一致。  
- 计算中间量：  
  $$
  \begin{pmatrix}X_c\\Y_c\\Z_c\end{pmatrix}=R\begin{pmatrix}U\\V\\W\end{pmatrix}+T
  $$
  其中 `$Z_c$` 即投影所需的深度（等同于公式左侧的 `$Z$`）。
## 中间（透视 / 焦距）
相机坐标系到图像坐标系是透视关系，利用相似三角形：
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509021447340.png)
- `$f$`：焦距，单位为与成像面物理单位一致（如 **mm**）。作用：把相机坐标映射到成像平面的物理坐标（透视缩放）。  
  在像素域常见的标量为：
  $$
  f_x = \frac{f}{d_X},\quad f_y = \frac{f}{d_Y\sin\theta}
  $$
  即焦距与像素尺寸共同决定像素级的焦距 `$f_x, f_y$`。
## 左侧（像素 / 仿射变换：把物理像面坐标换成像素坐标）
像素坐标系是图像坐标系的离散化表示，实际CCD相机每个像素对应一个感光点，是个矩形，假设其物理尺寸为dx宽，dy高。以CCD传感器的左上角为坐标原点建立的坐标系与以成像平面中心建立的坐标系的转换关系如下。
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509021450259.png)

- `$d_X$`：水平像素的物理宽度（**例如 mm/像素**），常用于把物理长度转为像素。矩阵中以 `$1/d_X$` 出现（把物理单位换成像素）。  
- `$d_Y$`：竖直方向像素物理高度（**mm/像素**），与 `$d_X$` 类似。  
- `$\theta$`：像素格横纵轴之间的夹角（弧度或度）。若像素正交，`$\theta=90^\circ$`，则 `$\cot\theta=0,\ \sin\theta=1$`。  
- `$\cot\theta$`：表示切变（skew）量的三角函数形式；矩阵中 `-\frac{\cot\theta}{d_X}` 是横向受纵向轴倾斜影响的项。  
- `$u_0, v_0$`：主点 / 光心（单位：像素）。表示光学轴在像素平面上的落点（通常接近图像中心）。

把这些合并成常见内参表示：
$$
f_x=\frac{f}{d_X},\quad f_y=\frac{f}{d_Y\sin\theta},\quad s=-\frac{\cot\theta}{d_X}
$$
常见的内参矩阵（$K$）为：
$$
K=\begin{pmatrix}f_x & s & u_0\\[4pt]0 & f_y & v_0\\[4pt]0&0&1\end{pmatrix}.
$$