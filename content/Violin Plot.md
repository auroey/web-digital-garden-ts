---
title: Violin Plot
date: 2025-08-16
---
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250816121750.png)
[[Box-Plot]]展示位置、离散程度、异常值
[[Kernel Density Estimation, KDE]]展示数据分布

## 结构组成

- **中间**：一个箱线图
    
    - 中位数（median）
        
    - 四分位数（Q1, Q3）
        
    - 胡须（whiskers，通常到 1.5×IQR 范围）
        
- **两边对称的“形状”**：KDE 曲线（平滑概率分布）
    
- **可能的点**：异常值或实际样本点
    
- **有时**：还会标出均值（mean）

## 典型使用场景

- 多组数据对比（不同实验条件、群体差异）
    
- 检查分布是否对称、是否多峰
    
- 替代单纯的 boxplot，获得**更丰富的分布信息**