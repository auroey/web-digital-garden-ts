---
title: Joint Distribution
date: 2025-08-16
---
Joint [[PMF，Probability Mass Function]]：
$$P(X=x,Y=y)$$

- 联合分布 = 最全的信息
    
- **边际分布（[[Marginal Distribution]]）** 和 **条件分布（[[Conditional Distribution]]）** 都能从联合分布推出来。

联合概率 / 边际概率 = 条件概率


计算 Joint PMF：
- **独立时**：联合分布可以拆开成两个边缘分布相乘。  
    $P(X,Y)=P(X)\cdot P(Y)$
    
- **不独立时**：需要通过具体关系（比如 $Y=X+$第二个骰子）来计算，某些格子是 0，某些是 $1/36$。
    
- 联合分布表格里：
    
    - **非零的格子**表示可能的组合；
        
    - **0 的格子**表示不可能的事件。



Joint [[PDF, Probability Density Function]]：
$$P\left((X,Y)\in A\right)=\iint_Af_{X,Y}(x,y)dxdy$$



可视化：[[scatter plot]]、[[heatmap]]

两个变量的同步情况：[[Covariance]]