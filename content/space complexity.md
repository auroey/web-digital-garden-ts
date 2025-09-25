---
title: space complexity
date: 2025-08-17
---
算法在运行过程中使用的内存空间主要包括以下几种。

- **输入空间**：用于存储算法的输入数据。
- **暂存空间**：用于存储算法在运行过程中的变量、对象、函数上下文等数据。
- **输出空间**：用于存储算法的输出数据。

一般情况下，空间复杂度的统计范围是“暂存空间”加上“输出空间”。

暂存空间可以进一步划分为三个部分。

- **暂存数据**：用于保存算法运行过程中的各种常量、变量、对象等。
- **栈帧空间**：用于保存调用函数的上下文数据。系统在每次调用函数时都会在栈顶部创建一个栈帧，函数返回后，栈帧空间会被释放。
- **指令空间**：用于保存编译后的程序指令，在实际统计中通常忽略不计。

在分析一段程序的空间复杂度时，**我们通常统计暂存数据、栈帧空间和输出数据三部分**，如下图所示。
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817100422.png)



而与时间复杂度不同的是，**我们通常只关注最差空间复杂度**。这是因为内存空间是一项硬性要求，我们必须确保在所有输入数据下都有足够的内存空间预留。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817100654.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817100709.png)

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817100929.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817100934.png)





