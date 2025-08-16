---
title: Confidence Interval, CI
date: 2025-08-16
---
## 1. 动机
- 我们想估计总体均值 $\mu$，但只能依赖样本均值 $\bar{x}$。  
- 每次抽样都会得到不同的 $\bar{x}$，因此需要一种方法刻画 **估计的不确定性**。  
- 置信区间就是在 $\bar{x}$ 周围加上一个“缓冲范围”，让我们有一定把握这个区间包含真实参数 $\mu$。

## 3. 关键概念
- **显著性水平 $\alpha$**：允许样本落在区间外的概率。常取 $\alpha = 0.05$。  
- **置信水平 $1-\alpha$**：区间覆盖真实参数的概率。例如 95%。 用这种方法构造的区间，有 95% 的概率会覆盖真实参数
- **误差范围（Margin of Error）**：根据样本分布和 $\alpha$ 确定的区间半径。  

---

## 4. 公式（已知总体方差 $\sigma^2$ 的情况）
$$
CI = \bar{x} \pm z_{\alpha/2} \cdot \frac{\sigma}{\sqrt{n}}
$$

- $\bar{x}$：样本均值  
- $z_{\alpha/2}$：标准正态分布的临界值（95% 置信区间时约为 1.96）  
- $\frac{\sigma}{\sqrt{n}}$：样本均值的标准误  


# 置信区间的变化（Changing the Interval）

- $\bar{X}$（样本均值）的期望始终等于总体均值 $\mu$，与样本量 $n$ 无关：  
  $$
  \mathbb{E}[\bar{X}] = \mu
  $$
- $\bar{X}$ 的标准差（标准误差，SE）随样本量变化：  
  $$
  \sigma_{\bar{X}} = \frac{\sigma}{\sqrt{n}}
  $$
- 当 $n=1$ 时，$\sigma_{\bar{X}} = \sigma$；  
  当 $n$ 增加时，$\sigma_{\bar{X}}$ 变小，分布更集中。


# 置信区间的误差边界（Margin of Error）

## 1. 置信区间的两个核心成分
1. **样本均值** $\bar{X}$  
2. **误差边界（Margin of Error, MOE）**

置信区间公式：
$$
\text{CI} = \bar{X} \pm \text{MOE}
$$

---

## 2. 样本均值的分布
- 总体：$X \sim \mathcal{N}(\mu, \sigma^2)$  
- 样本均值：  
  $$
  \bar{X} \sim \mathcal{N}\left(\mu, \frac{\sigma^2}{n}\right)
  $$
- 标准误差（Standard Error, SE）：  
  $$
  SE = \frac{\sigma}{\sqrt{n}}
  $$

---

## 3. 正态分布与 Z 分数
- 在标准正态分布下：  
  - 约 68% 落在 $[-1,1]$  
  - 约 95% 落在 $[-2,2]$  
  - 精确 95% 的区间为 $[-1.96, 1.96]$  

- **临界值（Critical Value）**：  
  - $z_{\alpha/2}$：左侧面积为 $\alpha/2$ 的分位点  
  - $z_{1-\alpha/2}$：左侧面积为 $1-\alpha/2$ 的分位点  

例如：$\alpha=0.05$ → $z_{0.025}=-1.96, z_{0.975}=1.96$。

---

## 4. 误差边界公式
- 一般形式：  
  $$
  \text{MOE} = z_{1-\alpha/2} \cdot SE
  $$
- 展开：  
  $$
  \text{MOE} = z_{1-\alpha/2} \cdot \frac{\sigma}{\sqrt{n}}
  $$

因此：
$$
CI = \bar{X} \pm z_{1-\alpha/2} \cdot \frac{\sigma}{\sqrt{n}}
$$



计算步骤
1. **求样本均值** $\bar{X}$  
2. **确定置信水平** （例如 $1-\alpha = 95\%$）  
3. **查找临界值** $z_{1-\alpha/2}$  
4. **计算标准误差**  
   $$
   SE = \frac{\sigma}{\sqrt{n}}
   $$
   （如果 $\sigma$ 未知，通常用样本标准差 $s$ 替代）  
5. **计算误差边界**  
   $$
   \text{MOE} = z_{1-\alpha/2} \cdot SE
   $$
6. **构建置信区间**  
   $$
   CI = \bar{X} \pm \text{MOE}
   $$

Probability：**随机事件** 发生的可能性。**对象**：随机变量。
Confidence：指统计推断方法在**长期重复实验**中成功的比例，方法的覆盖率。**对象**：置信区间。


# Unknown Standard Deviation & Student’s t 分布

## 1. 问题背景
- 在推导置信区间时，之前我们**假设已知总体标准差 $\sigma$**。
- 但现实中，大多数情况下我们并不知道 $\sigma$。
- 当 $\sigma$未知时，不能再直接使用正态分布的 $z$ 分数。

---

## 2. 解决方法
- 用 **样本标准差 $s$** 来估计总体标准差。
- 代入后，采样分布不再是正态分布，而是 **Student’s t 分布**。

---

## 3. t 分布的特点
- 形状类似正态分布，但有 fat tails（由于 $s$ 本身是估计量，会引入额外的不确定性）
- 意味着：采样结果更可能偏离中心。
- 随着样本量增加，t 分布逐渐逼近正态分布。

---

## 4. 两种情况对比

| 情况                   | 使用标准差 | 使用分布   | 使用统计量   |
|------------------------|------------|------------|--------------|
| $\sigma$ 已知          | $\sigma$  | 正态分布   | $z$ 分数     |
| $\sigma$ 未知          | $s$        | t 分布     | $t$ 分数     |

公式：
- 已知 $\sigma$：
  $$
  CI = \bar{x} \pm z_{\alpha/2} \cdot \frac{\sigma}{\sqrt{n}}
  $$
- 未知 $\sigma$：
  $$
  CI = \bar{x} \pm t_{\alpha/2,\, df} \cdot \frac{s}{\sqrt{n}}
  $$

---

## 5. 自由度（[[Degree of Freedom, df]]）
- 定义：$df = n - 1$
- 自由度越大，t 分布越接近正态分布。
  - $df=1$ → 尾部最胖。
  - $df=10$ → 更接近正态。
  - $df \to \infty$ → 完全等于正态。

---

## 6. 总结
- **$\sigma$ 已知 → 正态分布 + $z$ 分数**。
- **$\sigma$ 未知 → t 分布 + $t$ 分数**。
- 核心区别就是：是否知道总体标准差。


# 比例的置信区间（Confidence Interval for Proportion）

## 1. 场景
- 之前我们做的是 **均值的置信区间**（CI for mean）。  
- 现在换成 **比例的置信区间**，即总体中某个特征的比例 $p$。  
  - 例子：调查 Statistopia 城市中有多少人拥有汽车。

---

## 2. 样本比例
给定：
- 总样本数 $n$
- 成功次数 $x$

则样本比例为：
$$
\hat{p} = \frac{x}{n}
$$
---

## 3. 置信区间的一般形式
和均值的 CI 类似：
$$
CI = \hat{p} \pm \text{Margin of Error}
$$
- 均值：$SE = \frac{\sigma}{\sqrt{n}}$  
- **比例**：  
$$
SE = \sqrt{\frac{\hat{p}(1 - \hat{p})}{n}}
$$

$$
\text{MOE} = z_{\alpha/2} \cdot \sqrt{\frac{\hat{p}(1 - \hat{p})}{n}}
$$
其中：
- $z_{\alpha/2}$ = 临界值（95% CI → $z=1.96$）