---
title: Data Structures and Algorithms
date: 2025-08-16
---
# 算法入门

熟悉各种数据结构的**特点和用法**，学习不同算法的**原理、流程、用途和效率**等方面的内容。

参考：[Hello 算法](https://www.hello-algo.com/chapter_hello_algo/)

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250816212024.png)

- data structure
	- [[data structure]]
	  - 逻辑结构、物理结构
	  - [[Basic data types]]
	  - 数字编码、字符编码
	
	- [[array and linked list]]
	  - 连续与分散存储方式
	  - 两者操作方法与优缺点
	  - 基于动态数组实现列表
	  - 计算机内存与缓存
	
	- [[stack and queue]]
	  - 先入后出、先入先出、双向队列
	  - 基于数组和链表实现
	
	- [[hash table]]
	  - 哈希表工作原理、基于数组实现
	  - 哈希冲突、链式地址、开放寻址
	  - 哈希算法的用途与设计目标
	
	- [[tree]]
	  - 完美、完全、完满、平衡二叉树
	  - 链表表示、数组表示、两者对比
	  - 层序、前序、中序、后序遍历
	  - 二叉搜索树
	  - AVL树
	
	- [[heap]]
	  - 小顶堆、大顶堆、优先队列
	  - 基于数组实现堆、建堆操作
	  - Top-k问题
	
	- [[graph]]
	  - 有向图、连通图、有权图
	  - 邻接表、邻接矩阵、两者对比
	  - 广度优先遍历、深度优先遍历

---

- [[complexity analysis]]
  - [[iteration and recursion]]
    - for循环、while循环、嵌套循环
    - 递归调用栈、尾递归、递归树
    - 迭代与递归对比
  - [[Time complexity]]
    - 函数渐近上界
    - 计算方法、常见类型
    - 最差、最佳、平均时间复杂度
  - [[space complexity]]
    - 推算方法、常见类型
    - 权衡时间与空间

---

- algorithm
  - [[search algorithm]]
    - 暴力搜索：线性搜索、广度与深度优先搜索
    - 高效搜索：二分查找、哈希查找、树查找
    - 搜索算法的选取
  - [[sorting algorithm]]
    - 就地性、稳定性、自适应性、是否基于比较
    - 递归：选择排序、冒泡排序、插入排序
    - 分治：快速排序、归并排序
    - 非比较：桶排序、计数排序、基数排序
  - [[divide and conquer]]
    - 分治问题特性、解题方法
    - 例题：二分、构数组、汉诺塔
  - [[backtracking algorithm]]
    - 回溯问题特性、框架代码
    - 例题：全排列、子集和、N皇后
  - [[dynamic programming, DP]]
    - 暴力搜索、记忆化搜索、动态规划
    - 最优子结构、无后效性、子问题、无冗余性
    - 动态规划问题建模方法、求解步骤
    - 例题：0-1背包、完全背包、编辑距离
  - [[greedy algorithm]]
    - 贪心问题特性、解题方法
    - 例题：分数背包、最大客容量、最大切分乘积

# 刷算法题

从热门题目开刷，先积累至少 100 道题目，熟悉主流的算法问题。按照“艾宾浩斯遗忘曲线”来复习题目，通常在进行 3～5 轮的重复后，就能将其牢记在心。

清单：[代码随想录](https://programmercarl.com/)、[力扣](https://leetcode.cn/leetbook/detail/illustration-of-algorithm/)

# 搭建知识体系

在学习方面，我们可以阅读算法**专栏**文章、解题**框架**和算法教材，以不断丰富知识体系。
在刷题方面，可以尝试采用进阶刷题策略，如按专题分类、一题**多解**、一解多题等。


# 一些名词

| English                        | 简体中文       |
| ------------------------------ | ---------- |
| algorithm                      | 算法         |
| data structure                 | 数据结构       |
| code                           | 代码         |
| file                           | 文件         |
| function                       | 函数         |
| method                         | 方法         |
| variable                       | 变量         |
| asymptotic complexity analysis | 渐近复杂度分析    |
| time complexity                | 时间复杂度      |
| space complexity               | 空间复杂度      |
| loop                           | 循环         |
| iteration                      | 迭代         |
| recursion                      | 递归         |
| tail recursion                 | 尾递归        |
| recursion tree                 | 递归树        |
| big-$O$ notation               | 大 $O$ 记号   |
| asymptotic upper bound         | 渐近上界       |
| sign-magnitude                 | 原码         |
| 1’s complement                 | 反码         |
| 2’s complement                 | 补码         |
| array                          | 数组         |
| index                          | 索引         |
| linked list                    | 链表         |
| linked list node, list node    | 链表节点       |
| head node                      | 头节点        |
| tail node                      | 尾节点        |
| list                           | 列表         |
| dynamic array                  | 动态数组       |
| hard disk                      | 硬盘         |
| random-access memory (RAM)     | 内存         |
| cache memory                   | 缓存         |
| cache miss                     | 缓存未命中      |
| cache hit rate                 | 缓存命中率      |
| stack                          | 栈          |
| top of the stack               | 栈顶         |
| bottom of the stack            | 栈底         |
| queue                          | 队列         |
| double-ended queue             | 双向队列       |
| front of the queue             | 队首         |
| rear of the queue              | 队尾         |
| hash table                     | 哈希表        |
| hash set                       | 哈希集合       |
| bucket                         | 桶          |
| hash function                  | 哈希函数       |
| hash collision                 | 哈希冲突       |
| load factor                    | 负载因子       |
| separate chaining              | 链式地址       |
| open addressing                | 开放寻址       |
| linear probing                 | 线性探测       |
| lazy deletion                  | 懒删除        |
| binary tree                    | 二叉树        |
| tree node                      | 树节点        |
| left-child node                | 左子节点       |
| right-child node               | 右子节点       |
| parent node                    | 父节点        |
| left subtree                   | 左子树        |
| right subtree                  | 右子树        |
| root node                      | 根节点        |
| leaf node                      | 叶节点        |
| edge                           | 边          |
| level                          | 层          |
| degree                         | 度          |
| height                         | 高度         |
| depth                          | 深度         |
| perfect binary tree            | 完美二叉树      |
| complete binary tree           | 完全二叉树      |
| full binary tree               | 完满二叉树      |
| balanced binary tree           | 平衡二叉树      |
| binary search tree             | 二叉搜索树      |
| AVL tree                       | AVL 树      |
| red-black tree                 | 红黑树        |
| level-order traversal          | 层序遍历       |
| breadth-first traversal        | 广度优先遍历     |
| depth-first traversal          | 深度优先遍历     |
| binary search tree             | 二叉搜索树      |
| balanced binary search tree    | 平衡二叉搜索树    |
| balance factor                 | 平衡因子       |
| heap                           | 堆          |
| max heap                       | 大顶堆        |
| min heap                       | 小顶堆        |
| priority queue                 | 优先队列       |
| heapify                        | 堆化         |
| top-$k$ problem                | Top-$k$ 问题 |
| graph                          | 图          |
| vertex                         | 顶点         |
| undirected graph               | 无向图        |
| directed graph                 | 有向图        |
| connected graph                | 连通图        |
| disconnected graph             | 非连通图       |
| weighted graph                 | 有权图        |
| adjacency                      | 邻接         |
| path                           | 路径         |
| in-degree                      | 入度         |
| out-degree                     | 出度         |
| adjacency matrix               | 邻接矩阵       |
| adjacency list                 | 邻接表        |
| breadth-first search           | 广度优先搜索     |
| depth-first search             | 深度优先搜索     |
| binary search                  | 二分查找       |
| searching algorithm            | 搜索算法       |
| sorting algorithm              | 排序算法       |
| selection sort                 | 选择排序       |
| bubble sort                    | 冒泡排序       |
| insertion sort                 | 插入排序       |
| quick sort                     | 快速排序       |
| merge sort                     | 归并排序       |
| heap sort                      | 堆排序        |
| bucket sort                    | 桶排序        |
| counting sort                  | 计数排序       |
| radix sort                     | 基数排序       |
| divide and conquer             | 分治         |
| hanota problem                 | 汉诺塔问题      |
| backtracking algorithm         | 回溯算法       |
| constraint                     | 约束         |
| solution                       | 解          |
| state                          | 状态         |
| pruning                        | 剪枝         |
| permutations problem           | 全排列问题      |
| subset-sum problem             | 子集和问题      |
| $n$-queens problem             | $n$ 皇后问题   |
| dynamic programming            | 动态规划       |
| initial state                  | 初始状态       |
| state-transition equation      | 状态转移方程     |
| knapsack problem               | 背包问题       |
| edit distance problem          | 编辑距离问题     |
| greedy algorithm               | 贪心算法       |
