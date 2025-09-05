---
title: RAG, Retrieval-Augmented Generation
date: 2025-08-27
---
像[[Prompt Engineering]]，即，将database与prompt共同作为输入，解决模型无法和外接数据交互的问题，减少幻觉提升准确性。

可以解决的LLM限制：
- overdate
- limited knowledge
- too much general
- hallucination

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508272056151.png)

### 工作流程（3 步）

1. **检索（Retrieve）**
    
    - 根据用户问题，从文档库/知识库中找到最相关的片段。
        
    - 例：问“员工有停车位吗？” → 检索公司设施文档。
        
2. **拼接上下文（Augment）**
    
    - 将检索到的片段加入 Prompt：
        
        `Use the following context to answer the question: [Parking Policy: employees may park on levels 1 and 2...] Question: Is there parking for employees?`
        
    - 避免直接塞入整个长文档，只放最相关部分。
        
3. **生成回答（Generate）**
    
    - LLM 根据扩展后的 Prompt 给出回答。
        
    - 输出中可附带 **原始文档链接**，便于用户验证。