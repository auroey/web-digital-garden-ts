---
title: Self-Attention
date: 2025-08-11
---
REF: [https://www.bilibili.com/video/BV1v3411r78R/?spm_id_from=333.337.search-card.all.click&vd_source=8be5ba4fcf7c69b9960ed391f70c5fb0](https://www.bilibili.com/video/BV1v3411r78R/?spm_id_from=333.337.search-card.all.click&vd_source=8be5ba4fcf7c69b9960ed391f70c5fb0)

## Self-Attention

是一个将有顺序的序列输入提取出结合位置和前后意义的序列输出的方式/层。

解决的问题：多个输入（如voice、graph）

输入向量集的两种encode方式

![[Extras/Media/816af125042224e09de0c4ff93ec2354_MD5.png]]

三种输出

![[Extras/Media/b035e7e0b929efad87d3f6f4b72ff315_MD5.png]]

中间过程

![[Extras/Media/2358484670c47befca7bba81ead184a1_MD5.png]]

缺点是结果与前后不相关，如果扩大window size导致FC的参数过多影响计算结果

![[Extras/Media/45d5bb314a13c63c601b83469f2d8e7d_MD5.png]]

![[Extras/Media/69ada731896e54aa01f770634615ffc1_MD5.png]]

得到a的两种方法

![[Extras/Media/dce4c17081d6440d017316fdb9816f26_MD5.png]]

![[Extras/Media/dd1b5c3019930d189115be70cf774e06_MD5.png]]

批次根据a获得QKV

![[Extras/Media/0dfaf5b19279c9b9ccdd7fcc56c029d4_MD5.png]]

得到attention score

![[Extras/Media/a1b60872b9f2aec1d1ddbcd01da9e842_MD5.png]]

![[Extras/Media/f3ded9a060580eec3b14947bdcd90bfb_MD5.png]]

得到本位意

![[Extras/Media/da795f273093808ea3c2a5ed7a992ca3_MD5.png]]

从输入到输出的self-atttention全过程

![[Extras/Media/9d970174d9ce452e651039689266d814_MD5.png]]

Multi-head Self-attention

![[Extras/Media/74ab4c09009d7b26467e8d820c1c1356_MD5.png]]

![[Extras/Media/0dbd2f29b9532d65de1c00756dee43b3_MD5.png]]

a的位置咨询的表示

![[Extras/Media/6cc36919aef24a4497a2bfdbcc0b7191_MD5.png]]

Attention Matrix是两两相关的I*I矩阵，占内存大。解决方法是指纳入前后一段的内容考虑

![[Extras/Media/752769eff69f3abda0cab8409b3af481_MD5.png]]

CNN is simplified self-attention.

![[Extras/Media/883bb984cb927cd5874e0c58ffaa7e34_MD5.png]]

上图没看懂。

SA vs RNN

每个vector的考虑因素？双向RNN也可以考虑全局

1. 最大区别是RNN的两端记忆难以沟通，SA修改另一端权重即可。
    

2. RNN不能平行处理所有输出，但SA可以
    

运用在graph中时不需要计算Attention score，直接取边的权重，即Graph Neural Network

![[Extras/Media/5c10f6c6ec230e7fec71bddc99c38e20_MD5.png]]

SA和transformer同时提出所以二者名字混用，之后用到SA的模型大多叫做xxformer

![[Extras/Media/dcaf458b50b7995fdedb458e42da2fa7_MD5.png]]

## Transformer

是一个Sequence-to-Sequence的model，其中输出的长度由自监督决定

![[Extras/Media/b756a4e412d6292a7aa5c0cf3bf0303e_MD5.png]]

![[Extras/Media/773890922ed698122e9f22387c71673d_MD5.png]]

### Encoder

给一排输入，得一批输出

![[Extras/Media/15647bca318bc0878edd917317243ca1_MD5.png]]

每个block起到了多个layer的作用

![[Extras/Media/e3aeeee99446235815ace2b01913ddc6_MD5.png]]

在Transformer里，与常规SA不同的是，在SA后又使用了residual connection。得到a+b后做layer normalization（而不是batch norm（多类别的意义综合），对相同dimension不同feature/example。依赖全局的统计分布。），算出的m和std（对同feature不同dimension。每个 token 的 embedding 向量会单独计算均值和标准差，因此归一化是局部的，针对当前 token 自身。）

**Feature**：在序列数据中，一个 token（或 word）的 embedding 向量。假设 embedding 的维度是 d，一个 token 就是一个包含 d 个数值的向量。

**Dimension**：指 embedding 向量的每一维度，比如一个 d=512 的向量，第 1 维、第 2 维……第 512 维。

**Example**：通常是指序列中的每个 token，或不同的输入序列（样本）。

经过norm后得到的输出再经过FC然后residual，再norm一次，就能得到Encoder整体的输出

![[Extras/Media/9fbda63647f23f83e9872836bcea24a2_MD5.png]]

Transformer的Encoder整体结构：

![[Extras/Media/98aef82fb2120738805f7ac697ae1b17_MD5.png]]

### Decoder

先输入启动向量然后逐个获得输出

![[Extras/Media/7711d392d47780a15a255301cad8c5d2_MD5.png]]

把上一时刻的输出作为新输入

![[Extras/Media/812b5587bc11c9653847c6de28cd63d2_MD5.png]]

在Transformer中的Decoder

![[Extras/Media/5ec9d78a316f0bf65bc8e03fb173ad2e_MD5.png]]

Encoder和Decoder的内部区别

![[Extras/Media/276e55a481d72755defd5dc819764a0e_MD5.png]]

masked

b2只考虑小于等于2的a的相关向量。理解为遮挡后面，先从全文经过Encoder得到每个词的意思，再从前往后参考前文决定后文的输出意

![[Extras/Media/d0610d0b329f40a36377e4c7ee4aa6c2_MD5.png]]

Autoregressive(AT)：加入END作为切断，与BEGIN的表示符号可以相同

Non-autoregressive(NAT)：一次性输出所有结果

![[Extras/Media/b6da0db01561e89a2ca9f8675fa7ba9a_MD5.png]]

Cross attention传递

![[Extras/Media/9df1904b019b8dd0b2fd9d368b3956a5_MD5.png]]

去Encoder的k和v和Decoder的q

![[Extras/Media/bfc4505dc75531ae55e6634c1b86e28c_MD5.png]]

不同的信息连接方式

![[Extras/Media/ce44eac1851a19f5e4612b0ed2d5ea21_MD5.png]]

### Training

用cross entropy表示loss

![[Extras/Media/e66dad2123e170e2a5a658f8f1e4dacf_MD5.png]]

当测试时没有ground truth如何判断loss呢？

### 介绍几个训练seq2seq的tips

用其他词作为指令提取原文；取出重要部分的原文作为摘要

![[Extras/Media/ec99d18d07794e5bec78cd8e3f61f9bf_MD5.png]]

人为指定识别什么和顺序