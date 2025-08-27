---
title: Function Call
date: 2025-08-27
---

支持 Fucntion Calling 能力的主流模型如下表

|模型|开发者|首次支持 Function Calling 时间|
|---|---|---|
|GPT-4|OpenAI|2023/06/13|
|Claude-3|Anthropic|2024/03/04|
|Gemini-2.0|Google|2024年12月|
|DeepSeek-R1|深度求索公司|2025/02/21|

除了上面的知名度高的模型，还有一些其他开源或闭源模型也支持了 Fucntion Calling 能力，但是截止目前为止，GPT-4 仍然是公认的 Fucntion Calling 能力最强的模型。


## 步骤

1. 预定义用户的参数格式（JSON Schema）
2. 如图
	1. 用户提问
	2. LLM解析，可调用函数
	3. 生成结构化参数
	4. 参数传入[[API]]
	5. 返回结果

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508272116689.png)
