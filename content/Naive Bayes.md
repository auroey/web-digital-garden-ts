---
title: Naive Bayes
date: 2025-08-15
---
朴素贝叶斯（Naive Bayes）是一类基于贝叶斯定理的概率分类模型，因其**假设**特征之间**条件独立**，被称为“朴素”。它被广泛用于文本分类（如垃圾邮件识别、情感分析、新闻分类）、医学诊断等任务。

**Naive Bayes 的核心**：用词语在类别中出现的概率组合起来估计整体概率


## 1. 问题背景

我们想要判断一封邮件是否为垃圾邮件（Spam），初始有：

- **Prior**：$P(\text{Spam})$ = 邮件为垃圾邮件的初始概率
- **Event**：如邮件包含 "lottery"、"winning"
- **Posterior**：$P(\text{Spam} \mid \text{Words})$ = 在已知事件的前提下的更新概率

---

## 2. 单词组合下的贝叶斯推导

对一个词（如 "lottery"）：

$$
P(\text{Spam} \mid \text{lottery}) = \frac{P(\text{Spam}) \cdot P(\text{lottery} \mid \text{Spam})}{P(\text{lottery})}
$$

对多个词（如 "lottery" 和 "winning"）：

$$
P(\text{Spam} \mid \text{lottery}, \text{winning}) = \frac{P(\text{Spam}) \cdot P(\text{lottery}, \text{winning} \mid \text{Spam})}{P(\text{lottery}, \text{winning})}
$$

问题：实际中很少有邮件同时包含所有词 → 训练集中概率为 0（除法出错）。

---

## 3. Naive Bayes：朴素独立假设

> 在给定类别的前提下，假设各词 **条件独立**。

所以：

$$
P(\text{lottery}, \text{winning} \mid \text{Spam}) = P(\text{lottery} \mid \text{Spam}) \cdot P(\text{winning} \mid \text{Spam})
$$

推广到 $n$ 个词：

$$
P(w_1, ..., w_n \mid C) = \prod_{i=1}^n P(w_i \mid C)
$$

最终后验：

$$
P(C \mid w_1, ..., w_n) \propto P(C) \cdot \prod_{i=1}^n P(w_i \mid C)
$$

---

## 4. 示例计算

### 数据如下：

| 条件                                 | 频率/概率       |
| ------------------------------------ | --------------- |
| $P(\text{Spam})$                     | $20/100 = 0.2$  |
| $P(\text{Ham})$                      | $80/100 = 0.8$  |
| $P(\text{lottery} \mid \text{Spam})$ | $14/20 = 0.7$   |
| $P(\text{lottery} \mid \text{Ham})$  | $10/80 = 0.125$ |
| $P(\text{winning} \mid \text{Spam})$ | $15/20 = 0.75$  |
| $P(\text{winning} \mid \text{Ham})$  | $8/80 = 0.1$    |

---

### 应用公式：

$$
P(\text{Spam} \mid \text{lottery}, \text{winning}) =
\frac{0.2 \cdot 0.7 \cdot 0.75}{0.2 \cdot 0.7 \cdot 0.75 + 0.8 \cdot 0.125 \cdot 0.1}
= \frac{0.105}{0.105 + 0.01}
= \frac{0.105}{0.115} \approx 0.913
$$

---

## ✅ 结论

- 含有 "lottery" 和 "winning" 的邮件为垃圾邮件的概率为 **91.3%**
- Naive Bayes 通过简化的乘积模型，**有效利用多个特征的组合信息**
- 即使“词语独立”的假设不成立，实际分类效果也常常非常好

---

## 📚 Naive Bayes 的优势

- 训练速度快、实现简单
- 对高维文本特征尤其有效
- 可扩展至任意词汇维度，避免 0 概率问题