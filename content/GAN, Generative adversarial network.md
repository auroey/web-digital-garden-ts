---
title: GAN, Generative adversarial network
date: 2025-09-10
---
[From GAN to WGAN | Lil'Log](https://lilianweng.github.io/posts/2017-08-20-gan/)

它受到博弈论启发：两个模型——生成器和判别器——相互竞争，同时又在相互促进。

## 其中对散度的使用

在深入分析 GAN 之前，让我们先回顾两种用于量化两个概率分布之间相似性的指标。

(1) KL (Kullback–Leibler) divergence，衡量一个概率分布  p 与另一个预期概率分布 q 之间的差异。但公式中p和q的重要性不对称

(2) Jensen–Shannon Divergence 其值被 [0,1] 所限制。JS 散度是对称的

有人认为（Huszar，2015），GAN 取得巨大成功的原因之一是将损失函数从传统最大似然方法中的非对称 KL 散度切换为对称 JS 散度。

## GAN主体

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509101152800.png)

- **交替训练**：固定一个模型，优化另一个；D 学会把真/假分开，G 学会骗过 D。
    
- 常见策略是**多次更新 D、一次更新 G** 或者交替 1:1，视训练稳定性调整。
## 问题


