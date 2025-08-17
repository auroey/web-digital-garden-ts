---
title: binary search tree, BST
date: 2025-08-17
---
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132402.png)
最佳用例是检索某数值，将目标节点值 `num`与节点值 `cur.val`比较，若没找到，执行 `cur = cur.right`或执行 `cur = cur.left`，继续搜索。
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132712.png)
也可以插入：

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132720.png)
删除：
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132740.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132805.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132831.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132840.png)
这个后继结点一定是已有数据中最靠近（且略大于）待删除节点的。
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132854.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817132907.png)
排序：
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817133042.png)
## 二叉搜索树常见应用

- 用作系统中的多级索引，实现高效的查找、插入、删除操作。
- 作为某些搜索算法的底层数据结构。
- 用于存储数据流，以保持其有序状态。


## 改良定义方式后：AVL 树

为了确保在持续添加和删除节点后，好看的二叉树不会退化成难用的普通二叉树，从而使得各种操作的时间复杂度保持在 $O(\log n)$ 级别，提出 [[AVL tree]]。
