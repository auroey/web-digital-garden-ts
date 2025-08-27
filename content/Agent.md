---
title: Agent
date: 2025-08-27
---
能够**感知**环境、自主**决策**并采取**行动**以实现特定目标的实体或系统。它可以是软件程序、机器人硬件，甚至是生物实体（如人类或动物），但在 AI 领域**通常指软件**智能体。

[[AIGC]] 是 Agent 系统里面的一个子模块。

比[[RAG, Retrieval-Augmented Generation]]强的点在于，不仅能检索外界信息，还能生成结构化参数更精准地调用外界Function/tool

是一个集[[Function Call]]模型、软件工程于一体的复杂的系统，需要处理模型和外界的信息交互。

## 流程

Agent 每次完成任务会多次调用Function calling，流程大致如下

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508272122792.png)


## 本地实现

最简单的方法就是把 Agent 的提示词（prompt）、工具、llm 调用，工具执行都硬编码到代码中，但普适性不强，不好微调。解决办法是用“**配置**驱动 + **插件**化 + 通用**执行**引擎”的**平台化**方案，可复用。

智能体开发平台的架构

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508272131765.png)

插件配置：所有 Agent 的工具都统一管理起来，而不是散落在各个 Agent 内部，这样可以做到工具的复用。一般平台会自带一些插件，比如网络搜索、文件上传、AIGC 工具等，同时也支持开发者添加自己的自定义插件。

Agent 配置：配置 Agent 的 提示词 (prompt)，使用的模型，以及选择插件配置中的一批工具提供给模型做选择。

发布配置：开发者把自己的 Agent 开发调试稳定以后，发布成稳定版本就可以提供给用户使用了。

Agent 执行：实现通用的 Agent 执行流程，调用插件执行模块实现工具调用。

插件执行：执行某个特定的插件，返回结果。

## Multi-Agent

OpenAI Agent [[SDK, Software Development Kit|SDK]] 实现代码级开发，更可控

|维度|平台（Coze、腾讯云智能体平台）|SDK（OpenAI Agent SDK）|
|---|---|---|
|**开发方式**|配置/拖拽|代码（Python/JS 等）|
|**门槛**|低|中等，需要编程|
|**灵活性**|较低（平台约束）|高（自己写逻辑）|
|**适用场景**|快速原型、非程序员|高度定制、复杂系统集成|

可采用 Multi-Agent

- 开发者可以定义多个不同领域的 Agent（如：文档检索 Agent、代码执行 Agent、图像生成 Agent）。
    
- 通过 **转交机制** 配置：当某个 Agent 检测到任务超出自身能力时，可以将任务交给更合适的 Agent。
    
- 形成 **Agent 间的协作网络**，共同完成复杂任务。

采用 [[MCP, Model Context Protocol]] 协议作为工具之间的接口