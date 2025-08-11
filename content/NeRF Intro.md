---
type: Post
status: Published
date: 2025-01-12
slug: NeRF Intro
summary: 辅助理解nerf
category: 未来保障
tags:
  - 工具
---
# NeRF算法简介

PAPER：RePresenting Scenes as Neural Radiance Fields for View Synthesis

REF: https://www.bilibili.com/video/BV1fL4y1T7Ag/?spm_id_from=333.337.search-card.all.click&vd_source=8be5ba4fcf7c69b9960ed391f70c5fb0

![image-20250112135007277](C:\Users\10543\AppData\Roaming\Typora\typora-user-images\image-20250112135007277.png)

基于不同位姿照片，得到神经场模型，得到新视角照片的过程。

## 获得输入：光线采样

沿每条光线 $r(t) = o + t \cdot d$（起点 $o$ 和方向 $d$）均匀采样多个点。

每个采样点的位置 $(x, y, z)$ 和观察方向 $(\theta, \phi)$ 作为神经网络输入。

## 给模型点上色：MLP预测

![image-20250112141327514](C:\Users\10543\AppData\Roaming\Typora\typora-user-images\image-20250112141327514.png)

先把世界坐标encode成60维向量作为网络的输入

![image-20250112145922224](C:\Users\10543\AppData\Roaming\Typora\typora-user-images\image-20250112145922224.png)

NeRF用公式算出。Mip-NeRF远处概率分布得到的颜色决定近处颜色。

![image-20250112150117199](C:\Users\10543\AppData\Roaming\Typora\typora-user-images\image-20250112150117199.png)

这里没看懂，先不管了。大概意思是把一个低维的信息拆解成 多种信息/事件的概率分布，方便神经网络学习规律。

然后对每个采样点使用 MLP 输出体积密度/不透明度 $\sigma$ 和颜色 $c(r, g, b)$。

![image-20250112145746938](C:\Users\10543\AppData\Roaming\Typora\typora-user-images\image-20250112145746938.png)

## 2d视角取色：Volume Rendering with Radiance Fields 辐射场体渲染

通过追踪光线穿过一个三维体积数据场（如密度场或辐射场）的路径，累计光线所累积的颜色或强度值（用微分描述空间的一个位置的粒子信息），从而生成二维图像。

![image-20250112144422373](C:\Users\10543\AppData\Roaming\Typora\typora-user-images\image-20250112144422373.png)

得到输出的辐射描述后，利用体渲染公式，综合计算光线经过多个采样点的颜色和密度，得到最终的看起来连续的像素颜色。前面的不透明度会积分，一个点之前的不透明度离散积分越大，此点对于像素颜色的贡献越小。

## 自优化：损失函数
- 将体积渲染生成的颜色 $C(r)$ 与输入图像中真实像素颜色进行对比，计算误差（如均方误差 MSE）。
- 通过梯度下降优化神经网络权重。
