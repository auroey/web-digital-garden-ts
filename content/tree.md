---
title: tree
date: 2025-08-17
---
<u>二叉树（binary tree）</u>是一种非线性数据结构，代表“祖先”与“后代”之间的派生关系，体现了“一分为二”的分治逻辑。与链表类似，二叉树的基本单元是节点，每个节点包含值、左子节点引用和右子节点引用。

每个节点都有两个引用（指针），分别指向<u>左子节点（left-child node）</u>和<u>右子节点（right-child node）</u>，该节点被称为这两个子节点的<u>父节点（parent node）</u>。当给定一个二叉树的节点时，我们将该节点的左子节点及其以下节点形成的树称为该节点的<u>左子树（left subtree）</u>，同理可得<u>右子树（right subtree）</u>。

在二叉树中，除叶节点外，其他所有节点都包含子节点和非空子树。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817130618.png)
## 二叉树常见术语

二叉树的常用术语如下图所示。

- <u>根节点（root node）</u>：位于二叉树顶层的节点，没有父节点。
- <u>叶节点（leaf node）</u>：没有子节点的节点，其两个指针均指向 `None` 。
- <u>边（edge）</u>：连接两个节点的线段，即节点引用（指针）。
- 节点所在的<u>层（level）</u>：从顶至底递增，根节点所在层为 1 。
- 节点的<u>度（degree）</u>：节点的子节点的数量。在二叉树中，度的取值范围是 0、1、2 。
- 二叉树的<u>高度（height）</u>：从根节点到最远叶节点所经过的边的数量。
- 节点的<u>深度（depth）</u>：从根节点到该节点所经过的边的数量。
- 节点的<u>高度（height）</u>：从距离该节点最远的叶节点到该节点所经过的边的数量。

![](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817130635.png)

我们通常将“高度”和“深度”定义为“经过的边的数量”，但有些题目或教材可能会将其定义为“经过的节点的数量”。在这种情况下，高度和深度都需要加 1 。

## 常见二叉树类型

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817130853.png)
[[complete binary tree]]
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817130904.png)

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817130924.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817131019.png)
## 二叉树的退化

下图展示了二叉树的理想结构与退化结构。当二叉树的每层节点都被填满时，达到“完美二叉树”；而当所有节点都偏向一侧时，二叉树退化为“链表”。

- 完美二叉树是理想情况，可以充分发挥二叉树“分治”的优势。
- 链表则是另一个极端，各项操作都变为线性操作，时间复杂度退化至 $O(n)$ 。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817131108.png)

如下表所示，在最佳结构和最差结构下，二叉树的叶节点数量、节点总数、高度等达到极大值或极小值。

|                  | 完美二叉树              | 链表      |
| ---------------- | ------------------ | ------- |
| 第 $i$ 层的节点数量     | $2^{i-1}$          | $1$     |
| 高度为 $h$ 的树的叶节点数量 | $2^h$              | $1$     |
| 高度为 $h$ 的树的节点总数  | $2^{h+1} - 1$      | $h + 1$ |
| 节点总数为 $n$ 的树的高度  | $\log_2 (n+1) - 1$ | $n - 1$ |

## 二叉树的遍历

从物理结构的角度来看，树是一种基于链表的数据结构，因此其遍历方式是通过指针逐个访问节点。然而，树是一种非线性数据结构，这使得遍历树比遍历链表更加复杂，需要借助搜索算法来实现。

二叉树常见的遍历方式包括层序遍历、前序遍历、中序遍历和后序遍历等。

### 层序遍历

本质上属于广度优先遍历（breadth-first traversal），也称广度优先搜索（[[breadth-first search, BFS]]），它体现了一种“一圈一圈向外扩展”的逐层遍历方式。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817131307.png)
### 前序、中序、后序遍历

都属于深度优先遍历（depth-first traversal），也称深度优先搜索（[[depth-first search, DFS]]），它体现了一种“先走到尽头，再回溯继续”的遍历方式。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817131353.png)
## 用数组表示

在链表表示下，二叉树的存储单元为节点 `TreeNode` ，节点之间通过指针相连接。

- 数组表示：层序遍历存储，用 索引关系 代替指针。
    
    - 若节点索引为 $i$：
        
        - 左子节点：$2i+1$
            
        - 右子节点：$2i+2$
            

→ 映射公式在数组表示里，相当于链表里的“指针”。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817131806.png)
在二叉树的中间层通常存在许多 `None` 。由于层序遍历序列并不包含这些 `None` ，因此我们无法仅凭该序列来推测 `None` 的数量和分布位置。这意味着存在多种二叉树结构都符合该层序遍历序列。为了解决此问题，我们可以考虑在层序遍历序列中**显式地写出所有 `None`** 。如图所示，这样处理后，层序遍历序列就可以唯一表示二叉树了。
![](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817131907.png)完全二叉树非常适合使用数组来表示，因为所有 `None` 一定出现在层序遍历序列的**末尾**，可以省略存储所有 `None`。

当存储的数值分布满足一定规律时，我们将这个二叉树称作[[binary search tree, BST]]