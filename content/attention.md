---
title: attention
date: 2025-09-15
---
Attention 就是按「相似度」在一组信息里做加权平均：对每个**查询（Query）**，把它**和所有键（Key）比相似度**，得到**权重**，然后把对应的 **值（Value）** 按这些权重**加权求和**，得到最终输出。它让模型能够“有选择地关注”输入的不同部分。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509152220911.png)


- Q（Query），K（Key），V（Value）都是矩阵（通常由输入向量分别线性投影得到）。
    
- d_k​ 是 Key 的维度，除以 dk​​ 是为了数值稳定（避免点积值太大导致 softmax 梯度消失）。
    
- softmax 产生的每一行就是对所有 value 的注意力权重。


Multi-Head：
把 Q/K/V 用不同的线性变换投成若干组（head），每个 head 做独立的 scaled dot-product attention，最后把各 head 的输出拼接再线性变换一次。  
好处：每个 head 能学到不同子空间/不同类型的关系（比如局部关系、长距离关系、语义关系等）。


- **Self-attention（自注意）**：Q/K/V 都来自同一个序列（Transformer 编码器/解码器的核心）。
    
- **Cross-attention（交叉注意）**：Q 来自一种模态/序列（如解码器的当前状态），K/V 来自另一种（如编码器输出）。常见于 encoder-decoder 架构或多模态模型。
    
- **Causal/Masked attention（因果/掩码注意）**：对解码器在自回归生成时只允许看到过去的 token，通过给未来位置的 logits 加上 −∞-\infty−∞ 来掩盖。
    
- **Attention Mask（掩码）**：用于屏蔽 padding、或指定不应关注的位置（比如在多任务时隔离不同任务 token）。
    
- **Position Encoding（位置编码）**：因为 attention 本身不含序列位置信息，需要用 sin/cos 或 learnable embedding 注入位置信息。
    
- **Sparse/Local/Linear attention**：为降低 O(n2)O(n^2)O(n2) 复杂度，常用局部窗口、稀疏连接或近似方法（Performer、Linformer 等）。