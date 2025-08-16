---
title: Critical Value
date: 2025-08-16
---
## 1. 定义
- 在假设检验中，临界值是这样一个数：  
  如果观测**统计量**比它更“极端”，则拒绝原假设 $H_0$。  
- 它依赖于显著性水平 $\alpha$。  
- 临界值常写作 $k_\alpha$。

---

## 2. 与 p 值的关系
- **p 值法**：计算样本对应的 p 值，与 $\alpha$ 比较，若 $p < \alpha$，则拒绝 $H_0$。  
- **临界值法**：先算好 $k_\alpha$，如果统计量落在临界区，就拒绝 $H_0$。  
- 二者**结论必须一致**。

---

## 3. 单尾检验

### 右尾检验
- 拒绝域：右尾  
- 临界值条件：  
  $$
  T > k_\alpha \quad\Rightarrow\quad \text{拒绝 } H_0
  $$
- 其中 $k_\alpha$ 满足：  
  $$
  P(T > k_\alpha \mid H_0) = \alpha
  $$

### 左尾检验
- 拒绝域：左尾  
- 临界值条件：  
  $$
  T < k_\alpha \quad\Rightarrow\quad \text{拒绝 } H_0
  $$
- 其中 $k_\alpha$ 满足：  
  $$
  P(T < k_\alpha \mid H_0) = \alpha
  $$

---

## 4. 双尾检验
- 显著性水平 $\alpha$ 平分到两侧：$\alpha/2$。  
- 两个临界值：
  $$
  k_{\alpha/2}^{\text{left}}, \quad k_{\alpha/2}^{\text{right}}
  $$
- 拒绝域：
  $$
  T < k_{\alpha/2}^{\text{left}} \quad \text{或} \quad T > k_{\alpha/2}^{\text{right}}
  $$
这里的 **$T$** 指的是 检验统计量 ([[Test Statistic]])

---

## 5. 例子
- 假设：$H_0:\mu = 66.7,\; H_1:\mu > 66.7$  
- 已知：$n=10,\; \sigma=3,\; \alpha=0.05$  
- 临界值计算：  
  $$
  k_{0.05} = 68.26
  $$  
- 若观测 $\bar{X} = 68.44 > 68.26$，则拒绝 $H_0$。  

如果换 $\alpha=0.01$：  
  $$
  k_{0.01} = 68.91
  $$  
此时 $68.44 < 68.91$ → 不拒绝 $H_0$。

---

## 6. 优点
- **临界值法**可以在实验前就确定拒绝规则。  
- 这样能进一步计算二类错误概率（$\beta$），进而得到检验功效（power）。  
