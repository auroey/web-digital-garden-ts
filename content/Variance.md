---
title: Variance
date: 2025-08-16
---
$$\mathrm{Var}(X)=\mathbb{E}\left[(X-\mathbb{E}[X])^2\right]$$

### 方差的问题：

- 如果 $X$ 的单位是 **米（m）**，那么 $\text{Var}(X)$ 的单位就是 **米²（m²）**
    
- 这在实际解释中不方便，例如你测量身高，不会希望用“平方米”来表示离散程度

### 解决方法：

对方差开平方，让结果回到**原始单位**

Standard Deviation：
$$\sigma=\sqrt{\mathrm{Var}(X)}=\sqrt{\mathbb{E}[(X-\mathbb{E}[X])^2]}$$