---
title: graph
date: 2025-08-17
---
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817151920.png)
图的常用表示方式包括“邻接矩阵”和“邻接表”。前者省时间，后者省空间。

树代表的是“一对多”的关系，而图则具有更高的自由度，可以表示任意的“**多对多**”关系。因此，我们可以把树看作图的一种特例。显然，树的遍历操作也是图的遍历操作的一种特例。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817152429.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817152631.png)
与广度优先遍历类似，深度优先遍历序列的顺序也不是唯一的。给定某顶点，**先往哪个方向探索都可以**，即邻接顶点的顺序可以任意打乱，都是深度优先遍历。

以树的遍历为例，“根  左  右”“左  根  右”“左  右  根”分别对应前序、中序、后序遍历，它们展示了三种遍历优先级，然而这三者都属于深度优先遍历。