---
title: Introduction to Probability and Probability Distributions
date: 2025-08-15
---
- experiment：会产生不确定结果的过程（如抛硬币）
    
- event：你关心的那类结果（如“都是正面”）
    
- sample space：所有可能结果的集合

- Complement of Probability：这件事**不发生**的情况  P(A′)=1−P(A)

[[Sum of Probabilities]]


- 条件概率：已知一个事件发生，求另一个事件发生的概率。已知部分信息时，概率的变化。机器学习的核心是在给定输入特征的前提下，推断某种结果的概率，也就是条件概率。
- 记号：  
  $$P(B|A)$$  
  表示在事件 $A$ 已经发生的条件下，事件 $B$ 发生的概率。

- **独立事件**：
  $$
  P(A \cap B) = P(A) \cdot P(B)
  $$
- **依赖事件**：
  $$
  P(A \cap B) = P(A) \cdot P(B|A)
  $$
  - $P(B|A)$：在 $A$ 已经发生的情况下，$B$ 发生的概率
	  - 如果 a b 独立，a发生与否不影响，概率直接视作 pb

[[Bayes Theorem]]


- **条件概率**：模型学习的核心（监督学习）
  - 如 $P(\text{Label} \mid \text{Feature})$
- **纯概率**：生成模型的核心（无监督/生成式学习）
  - 如 $P(\text{pixels form face})$

---

 [[Generative Model]]

### 👤 生成脸（StyleGAN）

训练目标：

$$
P(\text{Face} \mid \text{generated pixels}) \text{ is high}
$$

→ 模型学会“哪些像素组合看起来像人脸”

---

### 📝 生成文本（Text Generation）

目标：

$$
P(\text{Meaningful Sentence} \mid \text{words}) \text{ is high}
$$

→ 比如 GPT 模型生成连贯句子


PMF（Probability Mass Function）

**定义**：离散随机变量的**概率质量函数**，表示变量取各个值的概率：

$$
p(x) = P(X = x)
$$
- 目标变量 $X$ 是“事实结果”
### PMF 满足两个条件：

1. $p(x) \geq 0$（每个概率都是非负数）
2. $\sum_{x \in \text{range}(X)} p(x) = 1$（所有可能值的概率之和为 1）

[[Binomial Distribution]]
[[Uniform Distribution]]
[[Normal Distribution]]


[[PDF, Probability Density Function]]