---
title: Adaptive Learning Rate Methods
date: 2025-08-15
---
常见方法

#### (1) AdaGrad
- **特点**：对每个参数单独维护学习率，历史梯度越大，学习率衰减越多。
- **优点**：适合稀疏数据（如NLP的词向量训练）。
- **缺点**：学习率会不断衰减，后期可能几乎停止更新。
- **更新公式**：
  $$
  \theta_{t+1} = \theta_t - \frac{\alpha}{\sqrt{G_t + \epsilon}} \cdot g_t
  $$
  其中 $G_t$ 是历史梯度平方和。

---

#### (2) RMSProp
- **特点**：解决 AdaGrad 学习率衰减过快的问题。
- 用指数加权平均（EMA）来记录梯度平方的移动平均值。
- **优点**：适合非平稳目标（如深度学习训练）。
- **缺点**：需要手动设置衰减系数。
- **更新公式**：
  $$
  E[g^2]_t = \beta E[g^2]_{t-1} + (1-\beta) g_t^2
  $$
  $$
  \theta_{t+1} = \theta_t - \frac{\alpha}{\sqrt{E[g^2]_t + \epsilon}} \cdot g_t
  $$

---

#### (3) Adam (Adaptive Moment Estimation)
- **特点**：结合 **动量法（Momentum）** + **RMSProp** 的优点。
- 对梯度的一阶矩（平均值）和二阶矩（方差）都做指数加权平均，并进行偏差修正。
- **优点**：几乎是深度学习的默认优化器，收敛速度快，对超参数不敏感。
- **缺点**：有时泛化性能不如 SGD。
- **更新公式**：
  $$
  m_t = \beta_1 m_{t-1} + (1-\beta_1) g_t
  $$
  $$
  v_t = \beta_2 v_{t-1} + (1-\beta_2) g_t^2
  $$
  $$
  \hat{m}_t = \frac{m_t}{1 - \beta_1^t}, \quad \hat{v}_t = \frac{v_t}{1 - \beta_2^t}
  $$
  $$
  \theta_{t+1} = \theta_t - \frac{\alpha}{\sqrt{\hat{v}_t} + \epsilon} \cdot \hat{m}_t
  $$

---

### 3. 对比总结

| 方法     | 学习率调整方式 | 优点 | 缺点 |
|----------|---------------|------|------|
| AdaGrad  | 历史梯度平方和 | 稀疏特征效果好 | 学习率衰减过快 |
| RMSProp  | 梯度平方的滑动平均 | 适合非平稳目标 | 需调衰减系数 |
| Adam     | 动量 + RMSProp | 收敛快，易用 | 泛化能力有时差 |

---
