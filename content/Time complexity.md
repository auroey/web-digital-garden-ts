---
title: Time complexity
date: 2025-08-17
---
设**算法的操作数**是一个关于输入数据大小 $n$ 的函数，记为 $T(n)$，则以上函数的操作量为：

$$
T(n) = 3 + 2n
$$

$T(n)$ 是一次函数，说明其运行时间的增长趋势是线性的，因此它的时间复杂度是线性阶。

我们将线性阶的**时间复杂度**记为 $O(n)$，这个数学符号称为大 $O$ 记号（big-O notation），表示函数 $T(n)$ 的渐近上界（asymptotic upper bound）。

时间复杂度分析本质上是计算“操作数量 $T(n)$”的渐近上界。计算渐近上界就是寻找一个函数 $f(n)$，使得当 $n$ 趋向于无穷大时，$T(n)$ 和 $f(n)$ 处于**相同的增长级别**，仅相差一个常数系数 $c$。

$$O(1)<O(\log n)<O(n)<O(n\log n)<O(n^2)<O(2^n)<O(n!)$$

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817095213.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817095304.png)

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817095316.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817095451.png)

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/20250817095558.png)

“最差时间复杂度”对应函数渐近上界，使用大 $O$ 记号表示。相应地，“最佳时间复杂度”对应函数渐近下界，用 $\Omega$ 记号表示。而最差时间复杂度更为实用，因为它给出了一个效率安全值。平均时间复杂度可以体现算法在随机输入数据下的运行效率，用 $\Theta$ 记号来表示。但对于较为复杂的算法，计算平均时间复杂度往往比较困难，因为很难分析出在数据分布下的整体数学期望。在这种情况下，我们通常使用最差时间复杂度作为算法效率的评判标准。