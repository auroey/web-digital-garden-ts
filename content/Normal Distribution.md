---
title: Normal Distribution
date: 2025-08-15
---

**正态分布**（也称高斯分布，Gaussian Distribution）是一种最常见、最重要的连续概率分布，广泛存在于自然界与统计模型中。

记作：

$$
X \sim \mathcal{N}(\mu, \sigma^2)
$$

- $\mu$：均值（mean），控制位置
- $\sigma$：标准差（standard deviation），控制宽度
- $\sigma^2$：方差（variance）

---

## 📈 概率密度函数（[[PDF, Probability Density Function]]）

正态分布的密度函数为：

$$
f(x) = \frac{1}{\sqrt{2\pi \sigma^2}} \cdot \exp\left(-\frac{(x - \mu)^2}{2\sigma^2}\right)
$$

- 对称于 $\mu$
- 越靠近均值概率越高
- 范围为 $(-\infty, +\infty)$
- 面积为 1

### 🧠 直觉解释：

- 看起来像个“钟形曲线”（bell curve）
- 数据围绕 $\mu$ 分布，越远离 $\mu$，概率越低

---

## 🧮 累积分布函数（[[CDF, Cumulative Distribution Function]]）

$$
F(x) = \int_{-\infty}^{x} f(t)\,dt
$$

- 没有解析解（需要查表或用软件）
- 图像为 S 型曲线
- 越靠右，累计概率越接近 1

---

## 🧠 标准正态分布

标准化后的正态分布：

$$
Z = \frac{X - \mu}{\sigma} \sim \mathcal{N}(0, 1)
$$

- 均值为 0，标准差为 1
- 常用来查表和标准化变量，便于比较不同量纲的数据

---

## 📌 期望和方差

| 名称     | 表达式                |
|----------|-----------------------|
| 期望     | $E[X] = \mu$          |
| 方差     | $\text{Var}(X) = \sigma^2$ |

---

## 🧠 中心极限定理（[[Central Limit Theorem]]）

当一个随机变量是很多独立随机变量之和时，它趋近于正态分布——这就是为什么正态分布无处不在！

---

## 🔁 总结

| 属性           | 表达式或特点                                           |
|----------------|--------------------------------------------------------|
| 分布记号       | $X \sim \mathcal{N}(\mu, \sigma^2)$                   |
| PDF            | $\frac{1}{\sqrt{2\pi\sigma^2}} e^{ - \frac{(x-\mu)^2}{2\sigma^2} }$ |
| CDF            | 无解析解，查表或用软件近似计算                         |
| 期望与方差     | $E[X] = \mu$，$\text{Var}(X) = \sigma^2$              |
| 标准正态分布   | $\mathcal{N}(0, 1)$                                    |
| 标准化公式     | $Z = \frac{X - \mu}{\sigma}$                           |

---

## 🔍 注意事项

- 所有正态分布的 PDF 积分值都是 1（是概率分布）
- 可以用 `Z` 分数比较不同分布下的值（例如考试成绩标准化）
- 在机器学习中很多模型默认特征服从正态分布（如 LDA、朴素贝叶斯）

---
