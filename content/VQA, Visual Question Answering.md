---
title: VQA, Visual Question Answering
date: 2025-09-15
---

- **定义**：给定一张图像和一个自然语言问题，模型输出问题的答案（可为单词、短语、类别或句子）。
    
- **常见任务类型**：
    
    - 开放式回答（open-ended）：自由文本答案（如“有肺炎”）。
        
    - 选择题（multiple-choice）：在候选答案中选一项。
        
    - 带定位的回答：不仅给答案，还返回相关区域（bounding box / mask）。
        
- **典型架构**：
    
    1. 图像编码器：CNN / ViT / ResNet / Swin 提取视觉特征（可以是 patch-token）。
        
    2. 文本编码器：BERT / LSTM / Transformer 提取问题向量。
        
    3. 融合模块：常见有拼接+MLP、点积/双线性注意（BAN）、Transformer-based cross-attention（更强）等。
        
    4. 答案头：分类器（若答案空间有限）、生成器（若需要自由文本）。
        
- **关键技巧**：
    
    - Cross-attention（文本 query → 视觉 key/value）是主流，能对齐问题与图像区域。
        
    - 多模态预训练（如将图像与文本联合预训练）能显著提升小样本性能。
        
    - 对医学VQA，常加入临床知识或报告先验（ontology、模板）提升准确率。
        
- **评价指标**：
    
    - 准确率（Accuracy）用于分类/选择题。
        
    - BLEU/ROUGE 等用于生成型答案（但医学上更看临床一致性）。
        
    - 专业评估：通过规则或模型（CheXpert/CheXbert）判断医学条目是否匹配。
