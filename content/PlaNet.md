参考：[用于决策的世界模型 -- 论文 World Models (2018) & PlaNet (2019) 讲解 - 伊犁纯流莱 - 博客园](https://www.cnblogs.com/tshaaa/p/18670731#learning-latent-dynamics-for-planning-from-pixels-2019)

相对于上一篇，这篇的改进：

1. 假定了环境是部分可观测马尔可夫决策过程 (POMDP)，世界模型就是在学习这个POMDP.
2. 给出了一套结合模型预测控制 (MPC) 方法的训练过程 —— Deep Planning Network (PlaNet).
3. 提出基于确定性和随机性结合的状态空间模型 (RSSM)，而不是仅有确定性状态的RNN和仅有随机性状态的SSM.
4. 给出了适用于多步预测的变分推断方法 —— latent overshooting.


## Problem setup

Partially Observable Markov Decision Process (POMDP)

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202607081803985.png)


## Deep planning network

MPC (Model Predictive Control，模型预测控制)

