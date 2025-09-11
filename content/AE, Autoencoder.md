---
title: AE, Autoencoder
date: 2025-08-11
---
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509101244803.png)


```
输入 x ──> [编码器 Encoder] ──> z ──> [解码器 Decoder] ──> 重构 x̂
```

用自编码器学习低维向量表示，这个 latent Representation / Bottleneck Vector 也可以称作 embedding

希望重构目标与原始输入相同。如果希望生成的图像为新事物的话采用[[VAE, Variational Autoencoder]]


# Denoising Autoencoder
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509101246869.png)

