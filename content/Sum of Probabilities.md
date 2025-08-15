---
title: Sum of Probabilities
date: 2025-08-15
---
- **互斥事件（Disjoint Events）**：两个事件不能同时发生。
  - 例如：一次掷骰子，掷出 2 和掷出 3 不能同时发生。
- **概率加法法则**：如果两个事件互斥，则：
  $$
  P(A \cup B) = P(A) + P(B)
  $$
  其中 $A \cup B$ 表示事件 A 或事件 B 发生。

- **非互斥事件（Joint Events / Non-Mutually Exclusive Events）**：
  两个事件可能同时发生（有交集）。
  - 例如：今天下雨（Rain）和今天刮风（Wind）可以同时发生。
- 对于这类事件，直接相加会**重复计算交集部分**，所以需要**减去交集的概率**：
  $$
  P(A \cup B) = P(A) + P(B) - P(A \cap B)
  $$Independence Event：一个事件发生与否，不会影响另一个事件发生的概率。


