---
title: Image Editing
date: 2025-08-13
---
### Image Editing

https://arxiv.org/pdf/2402.17525

#### 扩散模型原理及优势

  
原输入（图像或编码）逐步DDIM采样（重复性不同程度不同路径地加噪），再 Inversion（记忆确定已知的加噪过程，通过试错，逆推噪音到原图的计算方式），若 reconstruction failure 则初始化。

  

训练目标是最小化正向分布q（马尔可夫链加噪声过程）与模型分布p（去噪声过程）、或者说最大化ELBO（变分下界）。

  

模型实际使用的loss：

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=NTUxMjJkNzcwZmM3ZjU2Zjk1Zjg0Mjk1M2JkM2Y5MjZfRE0yUXRLejRTRzJsWDFLRG5zZXlmOTZaWEt0MFZITUJfVG9rZW46QkxpRGJWUk1hb1NKa1h4OFIzaWNMeTRvbmxmXzE3NTUwNTQ5Njc6MTc1NTA1ODU2N19WNA)

文本条件控制：在扩散采样时，引入文本编码 C=ψ(P) 引导图像生成。

  

Classifier-Free Guidance：给文本控制程度加权

  

Stable Diffusion 中的注意力机制：分两种。Cross-Attention（图像的空间特征（Query）和文本 token（Key, Value）对齐），和Self-Attention（图像本身的局部一致性和各局部的互动性）

  

用于无监督图像生成与编辑

  

#### 分类方法

  

##### 学习策略

  

###### Training-based：

  

需预训练大模型。适用于特定任务，常用与具有中小型数据集的特定领域。从训练的数据类型入手

  

Domain-Specific Editing

  

Reference & Attribute Guided Editing

  

Instructional Editing：text prompt guided

  

Pseudo-Target Retrieval-Based Editing：不直接编辑输入图像，而是在数据集中检索“类似的目标图”作为伪监督信号，再指导模型进行图像修改。

  

###### Testing-time finetuning

  

不训练模型，但推理时要微调。从潜在表示或表示的结构入手

  

Denoising Model Finetuning：对扩散模型（特别是 U-Net）进行微调

  

Embedding Finetuning

  

Hypernetwork Guidance

  

Latent Variable Optimization

  

Hybrid Finetuning

  

###### Training/finetuning free

  

直接推理即可。后处理，精细输入或精细从潜变量得到输出的过程

  

Input Text Refinement

  

Inversion / Sampling Modification

  

Attention Modification

  

Mask Guidance

  

Multi-Noise Redirection

  

##### 十种输入条件

  

文本、掩码、参考图、类别、布局、姿态、草图、分割图、音频、拖拽点

  

##### 编辑任务类型

  

|   |   |
|---|---|
|类别|子任务示例|
|**语义编辑**：增减或改变元素|加物体、删物体、换物体、换背景、情绪表达变换|
|**风格编辑**：改变值|颜色变化、纹理变化、整体风格变化|
|**结构编辑**：改变位置或结构|移动物体、改大小形状、动作姿态变换、视角变化|

  

##### 2D 编辑任务类型

  

###### 条件图像生成

  

Text-to-Image, T2I：图像->潜空间->扩散。Stable Diffusion、DALL·E 2、VQ-diffusion

  

beyond text

  

Personalized Image Generation

  

SVG / vector graphics

  

###### 图像修复与增强

  

基于输入图像作为条件，做超分辨率（SR）和去模糊

  

非空间域修复

  

T2I Prior：利用预训练 T2I 模型迁移做图像恢复

  

Projection-based

  

Decomposition-based

  

###### 图像合成

  

Image-Based Virtual Try-On，VTON：TryOnDiffusion（双 UNet 同时处理衣物细节和人物姿态）、LaDIVTON（将服装特征映射到 CLIP 向量并作为 LDM 条件输入）、StableVITON（引入 zero cross-attention 加强衣物和人物之间的语义关联）

  

Image-Guided Object Composition

  

##### 挑战

  

速度：few-step / one-step generation

  

成本：

  

结构感知

  

真实性

  

鲁棒

  

分辨率与效率的平衡

  

  

### Instructional image editing 方法

  

image caption：图片描述

  

instruction：动作指令

  

目标是模型根据指令，理解要操作的区域、编辑类型和预期效果，再在图像上执行修改。

  

#### Framework

  

InstructPix2Pix

  

Stable Diffusion+ Prompt-to-Prompt

  

{

"input_image": 原图,

"instruction": "Have her ride a dragon.",

"edited_image": 编辑后图,

"edited_caption": "Photograph of a girl riding a dragon."

}

  

#### Architecture Enhancement

  

MoEController（闭源）

  

Mixture-of-Expert (MOE) architecture：local translation、style transfer、local complex editing

  

FoI

  

employs cross-condition attention modulation to ensure each instruction targets its corresponding area

  

#### Data Quality Enhancement

  

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=NzAwZTM5ODZmOGZiNjcxYTMwMzA2NmMxZGIxNmY5MTVfYjk1UDZpNlBFSGpzYkxXcHkwNTJvMll5VVlGSFNvTDdfVG9rZW46T2ZxVmJ0Wjd3b2pQZVd4d0FRWmNoQ2MzbnViXzE3NTUwNTQ5Njc6MTc1NTA1ODU2N19WNA)

  

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=NTRkODBmMmFmMmJmZjI5ZWRhMWIxM2JhNzQ4MWQxMTlfTW8zRXR5NUtTcEtwVlhZZlBvOGc1Q09mY2c0TzJ0RXpfVG9rZW46SlZDRWJMT0Fzb0JiYnF4elBwc2NwZ1BlbktjXzE3NTUwNTQ5Njc6MTc1NTA1ODU2N19WNA)

可local：

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=OTMwYjFjZWNkNjcyYThkOGQwMmQwYjJlMWVjMjJmMmZfSTA4aXlYY2lLSmN2Tk8xazV6eW9udk15TGZENXZFOUNfVG9rZW46VnFXY2JMODRNb08wa0Z4M3cxRGNzckhibm1oXzE3NTUwNTQ5Njc6MTc1NTA1ODU2N19WNA)

  

Human Feedback-Enhanced Learning

  

HIVE：引入 [[RL, Reinforcement Learning]] from Human Feedback (RLHF) 机制

  

Visual Instruction

  

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=NmU0ZjA2OTU4NGI4Nzc0YWI4NzdhY2I0MjZlODdjY2NfOG1CczlCZ1F2Q1dZN0xiQ0NaOUEzMXlRaW9yU0p1bmJfVG9rZW46WTg1M2JCY0x2b0tqS214S2liNGNLYjU1bndoXzE3NTUwNTQ5Njc6MTc1NTA1ODU2N19WNA)

  

MLLM

  

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=ODgwYWM2YjIyYWRkNmUzYTg3NmI2NjlmODc5ZGQzOTZfTFEwaVMwb3J6OE5JOUxaMzAweU5sN2IxS1JpSmJiZFpfVG9rZW46RHduZ2JaWTRib3N1M2x4bmVLZWM4V1V3bmpjXzE3NTUwNTQ5Njc6MTc1NTA1ODU2N19WNA)

  

#### Pseudo-Target Retrieval Based Editing

  

使用伪目标图（pseudo-target）或 CLIP 评分作为监督信号。

可local：

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=ZjlhNTcxODA4NGI1Y2NjZmM4M2U5MzM3NWQxMjhmMWZfOTFpa0N3dXlqZlk3M3VRSlJHcXliZjVjMUtnWWhUaHRfVG9rZW46TkxzUWJEbTRtb293a054Rmp0YWNheTFGbjg4XzE3NTUwNTQ5Njc6MTc1NTA1ODU2N19WNA)

  

### Instructional image editing Dataset

  

高光黄色的是local editing数据集，已将两个标黄的添加到“现有图片编辑数据集汇总”中

  

#### 1. **InstructPix2Pix Dataset**

  

- 📄 来源：InstructPix2Pix（CVPR 2023）
    
- 🏗️ 构建方式：
    
    - 输入一张图像及其 caption
        
    - 用 GPT-3 生成一个**编辑指令**和一个**编辑后 caption**
        
    - 用 Prompt-to-Prompt + Stable Diffusion 生成目标图像
        
- 📦 规模：~450,000 图像对（自动构造）
    
- 优点：规模大，覆盖范围广，适配指令式编辑的训练范式
    
      
    

---

  

#### 2. **MagicBrush**

  

- 📄 来源：ACL 2023
    
- 🧑💻 构建方式：使用 AMT 众包进行**连续人工编辑任务**
    
- 📦 数据量：
    
    - 5313 个编辑 session
        
    - 10388 个连续编辑操作（turns）
        
- ✨ 特点：
    
    - 每条数据包含一组连续指令和图像变化
        
    - 适合研究**多轮编辑**和**复杂操作序列**
        
          
        

---

  

#### 3. **DialogPaint**

  

- 📄 来源：DialogPaint（2023）
    
- 🗣️ 特点：**多轮对话式指令图像编辑数据集**
    
- 📦 构建方式：
    
    - 利用 GPT-3 生成对话模拟指令生成过程（self-instruct）
        
    - 配合多个图像编辑模型生成图像对
        
- 📚 用途：
    
    - 多轮图像编辑任务
        
    - 支持从“对话”中提取用户意图再驱动编辑
        
          
        

---

  

#### 4. **Inst-Inpaint / GQA-Inpaint**

  

- 📄 来源：Inst-Inpaint（2023）
    
- 📦 基于 GQA 场景图数据集（真实图+语义结构）
    
- 📐 编辑内容：
    
    - 删除图中指定物体（"remove the umbrella"）
        
    - 无需用户提供 mask，系统自动提取物体位置
        
- 🤖 构建方法：
    
    - 使用 Detectron2 + CRFill 实现自动 inpainting
        
    - 使用模板生成文本指令
        
          
        

---

  

#### 5. **EmuEdit Dataset**

  

- 📄 来源：EmuEdit（2024，by Emu）
    
- 🤖 构建方式：
    
    - 使用 **LLaMA 2 + in-context prompting** 自动生成**16类任务**的图像编辑指令
        
    - 每个任务包含 instruction + 原图 + 目标图
        
- 📦 数据量：**1000 万条**
    
- ✨ 优势：
    
    - 多任务、多模态（包括分类、分割、编辑）
        
    - 强化多样性与创造性指令
        
          
        

---

  

#### 6. **InstructDiffusion Dataset**

  

- 📄 来源：InstructDiffusion（2023）
    
- 🔨 数据来源融合：
    
    - 现有公开数据集（如 COCO、CelebA-HQ）
        
    - 网络收集 Photoshop 编辑对
        
    - 自构图像增强/目标替换编辑对
        
- 强调：统一多种 vision 任务为“人类指令驱动的图像操作”
    
      
    

---

  

#### 7. **ImageBrush**

  

- 📄 来源：ImageBrush（2024）
    
- 💡 思路：用图像对（before + after）作为“视觉指令”
    
- 📐 构建方式：
    
    - 将“示例图对”作为 prompt，引导目标图编辑
        
    - 模型从中学习视觉风格迁移或编辑行为
        
- 🎯 适用于**无语言指令**、纯视觉驱动编辑任务
    
      
    

---

  

#### 辅助数据：

  

|   |   |
|---|---|
|数据集|用途|
|**CLIPSeg**|提供 mask，用于局部控制编辑|
|**GQA**|场景图辅助生成对象信息|
|**VQA2.0**|用于 instruction/question generation|
|**COCO**|常用图像来源|
|**Photoshop request dataset**|网络收集真实编辑对|

  

- **EditBench**（2023）：text + mask + image triplets，任务偏 inpainting。
    
- **EditEval**（2024）：7类 instruction，包括 object add/remove, style, background 等。