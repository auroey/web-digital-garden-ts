---
title: AIGC
date: 2025-08-14
---
采用人工智能技术来自动生产内容。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508272036197.png)
是[[multi-modal]]的一种应用，可通过[[RAG, Retrieval-Augmented Generation]]增强



## AIGC 的三个技术层次

### 1. 智能数字内容孪生

- **定义**：把数字内容从一个维度映射到另一个维度（因为新维度的内容原本不存在，需要生成）。
    
- **方向**：
    
    - **增强**：修复、去噪、细节增强（如图像超分、老照片复原）。
        
    - **转译**：不同模态的转换（如语音转字幕、文字转语音）。
        
- **应用**：
    
    - 图像超分辨率
        
    - 语音转字幕
        
    - 文本转语音
        

---

### 2. 智能数字内容编辑

- **定义**：基于对内容的理解和属性控制，实现修改和再编辑。
    
- **应用示例**：
    
    - 视频领域：自动场景剪辑
        
    - 虚拟试衣：人体部位检测 + 衣服变形/覆盖
        
    - 语音信号处理：人声与背景声分离
        

---

### 3. 智能数字内容生成

- **定义**：从海量数据中学习抽象概念，通过概念组合生成全新内容。
    
- **应用示例**：
    
    - AI 绘画：学习笔法、风格，生成新画作
        
    - 文本创作：文章、诗词、小说
        
    - 跨模态生成：文本→图像/视频/音频
        

---

## AIGC 的五类生成内容

### 1. 文本生成

- **形式**：
    
    - 非交互式：摘要/标题生成、文本风格迁移、文章生成、图像生成文本等
        
    - 交互式：ChatBot、文本游戏
        
- **代表性产品/模型**：  
    JasperAI、copy.AI、ChatGPT、Bard、AI Dungeon
    

---

### 2. 图像生成

- **形式**：
    
    - 图像编辑修改：超分、修复、人脸替换、去水印、背景去除
        
    - 图像自主生成：真实图→卡通/素描，文本→图像
        
- **代表性产品/模型**：  
    EditGAN、Deepfake、DALL-E、MidJourney、Stable Diffusion、文心一格
    

---

### 3. 音频生成

- **形式**：
    
    - 语音克隆（人声替换）
        
    - 文本→语音（数字人播报、客服）
        
    - 文本/图像→音乐、音效
        
- **代表性产品/模型**：  
    DeepMusic、WaveNet、Deep Voice、MusicAutoBot
    

---

### 4. 视频生成

- **形式**：
    
    - 视频编辑：超分、修复、老电影上色、自动场景剪辑
        
    - 视频自主生成：图像→视频、文本→视频
        
- **代表性产品/模型**：  
    Deepfake、videoGPT、Gliacloud、Make-A-Video、Imagen Video
    

---

### 5. 多模态生成

- **形式**：模态间组合/转换
    
    - 文本→图像、音频、视频
        
    - 图像→文本（标题、故事）、视频
        
- **代表性产品/模型**：  
    DALL-E、MidJourney、Stable Diffusion
    

## 核心技术

### 基础模型

|模型名称|提出时间|应用场景|
|---|---|---|
|1、深度变分自编码（VAE）|2013年|图像生成、语音合成|
|2、生成对抗神经网络（GAN）|2014年|图像生成、语音合成|
|3、扩散模型（Diffusion Model）|2015年|图像生成|
|4、Transformer|2017年|语言模型|
|5、Vision Transformer（ViT）|2020年|视觉模型|

[[VAE, Variational Autoencoder]]
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281053982.png)


[[GAN, Generative Adversarial Networks]]
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281053046.png)

[[Diffusion Model]]
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281054824.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281054506.png)
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281054979.png)

[[Transformer]]
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281102034.png)


[[ViT, Vision Transformer]]
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281103007.png)

### Pretrained LM

|计算机视觉（CV）预训练大模型|自然语言处理（NLP）预训练大模型|多模态预训练大模型|
|---|---|---|
|微软Florence（SwinTransformer）|谷歌Bert/LaMDA/PaLM|OpenAI的CLIP/DALL-E|
||OpenAI的GPT-3/ChatGPT|微软的GLIP|
|||Stability AI的Stable Diffusion|
[AIGC技术与应用全解析](https://zhuanlan.zhihu.com/p/607822576)
## AIGC的应用
![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281133546.png)

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202508281135240.png)

### 1、基础层（模型服务）

基础层为采用预训练大模型搭建的基础设施。由于开发预训练大模型技术门槛高、投入成本高，因此，该层主要由少数头部企业或研发机构主导。如谷歌、微软、Meta、OpenAI、DeepMind、Stability.ai等。基础层的产品形态主要包括两种：一种为通过受控的**api接口收取调用费**；另一种为基于基础设施开发专业的**软件平台收取费用**。

### 2、中间层（2B）

该层与基础层的最主要区别在于，中间层不具备开发大模型的能力，但是可基于开源大模型等开源技术进行改进、抽取或模型二次开发。该层为在大模型的基础上开发的场景化、垂直化、定制化的应用模型或工具。在AIGC的应用场景中基于大模型抽取出个性化、定制化的应用模型或工具满足行业需求。如基于开源的Stable Diffusion大模型所开发的二次元风格图像生成器，满足特定行业场景需求。中间层的产品形态、商业模式与基础层保持一致，分别为**接口调用费与平台软件费**。

### 3、应用层（2C）

应用层主要基于基础层与中间层开发，面向C端的场景化工具或软件产品。应用层更加关注用户的需求，将AIGC技术切实融入用户需求，实现不同形态、不同功能的产品落地。可以通过**网页、小程序、群聊、app**等不同的载体呈现。