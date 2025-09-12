---
title: GAI,Generative AI
date: 2025-08-13
---
能根据提示（prompt）生成文本、图像、音频/视频 的 AI 系统（如 ChatGPT、Bard、图像/音频生成器）。

### 常见 prompt 类型（举例）

- **纯文本**（你现在用的）：  
    `--prompt "Replace the object in the box with the reference image..."`
    
- **文本 + 参考图片**（你已用 `--src_ref_images`）：  
    `--src_ref_images assets/images/girl.png`  
    ——把参考图作为视觉提示，配合文本说明要替换的对象/风格/动作。
    
- **文本 + bbox / mask**（控制区域）：  
    `--mode bbox --bbox 450,150,650,400`  
    或者用 mask：`--mask assets/masks/mask1.png` ——mask 可以精确遮挡要编辑的像素。
    
- **文本 + 视频**（视频帧上下文）：  
    `--video assets/videos/allbg.mp4` ——模型能基于视频上下文保持运动连贯性。
    
- **结构化/元数据提示（JSON）**：  
    `--prompt_json '{"style":"photorealistic","keep_motion":true,"seed":42}'`  
    ——一些工具支持把参数以 JSON 字符串传给模型，更便于脚本化和解析。
    
- **Few-shot（示例式提示）**：  
    把几个“示例输入 → 期望输出”的段落放进 prompt，指导模型模仿格式（注意长度限制）。
    
- **多资源 + 多区域**（多个参考或多个 bbox）：  
    `--src_ref_images ref1.png,ref2.png --bbox 450,150,650,400;100,100,200,200`

[The AI workspace that works for you. | Notion](https://xinntao.notion.site/Generative-Modeling-1e9bb3e076ac803a918ff7ea424b7d58)



[[MMaDA]]

[[Image Editing]]




分类：

Explicit Density
- Tractable Density：[[Autoregressive Models]]、[[Flow-based models]]
- Approximate Density：[[VAE, Variational Autoencoder]]
lmplicit Density
- [[GAN, Generative adversarial network]]
- [[Diffusion Models]]
![](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509121248396.png)