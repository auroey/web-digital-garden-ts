---
title: AVL tree
date: 2025-08-17
---
AVL 树既是二叉搜索树，也是平衡二叉树，是一种平衡二叉搜索树（balanced binary search tree）。

## 预定义

- **节点高度**：节点到最远叶子的边数。
    
    - 叶节点高度 = 0
        
    - 空节点高度 = -1
        
- **平衡因子**：左子树高度 − 右子树高度
    
    - 取值范围：$-1 \le f \le 1$
        
    - 超出范围 → 失衡节点

## 原理

AVL 树的特点在于“旋转”操作，它能够在不影响二叉树的中序遍历序列的前提下，使失衡节点重新恢复平衡。换句话说，旋转操作既能保持“二叉**搜索**树”的性质，也能使树重新变为“**平衡**二叉树”。

我们将平衡因子绝对值 >1 的节点称为“失衡节点”。根据节点失衡情况的不同，旋转操作分为四种：右旋、左旋、先右旋后左旋、先左旋后右旋。下面详细介绍这些旋转操作。

从底至顶看，二叉树中首个失衡节点是“节点 3”。我们关注以该失衡节点为根节点的子树：
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817134420.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817134517.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817134526.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817134542.png)

当节点 `child` 有右子节点（记为 `grand_child` ）时，需要在右旋中添加一步：将 `grand_child` 作为 `node` 的左子节点。
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817134644.png)
右旋和左旋操作在逻辑上是镜像对称的，它们分别解决的两种失衡情况也是对称的。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817134719.png)
简单判断：
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817134801.png)
正式判断：
我们通过判断失衡节点的**平衡因子**以及**较高一侧子节点**的平衡因子的**正负号**，来确定失衡节点属于图中的哪种情况。

| 失衡节点的平衡因子 | 子节点的平衡因子 | 应采用的旋转方法 |
| ------------------ | ---------------- | ---------------- |
| $> 1$ （左偏树）   | $\geq 0$         | 右旋             |
| $> 1$ （左偏树）   | $<0$             | 先左旋后右旋     |
| $< -1$ （右偏树）  | $\leq 0$         | 左旋             |
| $< -1$ （右偏树）  | $>0$             | 先右旋后左旋     |
为了便于使用，我们将旋转操作封装成一个函数。

### AVL 树典型应用

- 组织和存储大型数据，适用于高频查找、低频增删的场景。
- 用于构建数据库中的索引系统。
- 红黑树也是一种常见的平衡二叉搜索树。相较于 AVL 树，红黑树的平衡条件更宽松，插入与删除节点所需的旋转操作更少，节点增删操作的平均效率更高。