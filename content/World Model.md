---
title: World Model
date: 2025-08-15
pinned: true
---
## World Model is all you need

其实 world model 这个概念早就有人提出了，但最近几年几个大火的领域都表示“理想与现实差距大大滴”，并甩锅给训练的数据，说训练时用的 simulated data 毕竟是庶出，要想效果好，还得用嫡出的 real-world data。此举可谓一石二鸟，既能给自己训练结果不好洗白，又便于拉到无穷的经费。

Robotics、Reinforcement Learning、Visual Generation、Embodied AI 与 Autonomous Driving 等等领域一商量，发现大家都缺 real-world environment data，正好之前有人提出了 WM 这一概念（不过当时叫 WM 的原因仅仅是模型先在“世界”中模拟，再进行下一步思考。命名简单直接，应用领域单一，没现在这么难懂，详见‘2018 年的 *World Models*’），大家一拍脑门、统一口径：哎哟我明白了，我彻底明白了，我们得训练 World Model！大家快来给我投资吧！

功能上，WM 有这些**能力**：

- 预测未来（Future Prediction）：WM 可以根据当前环境、历史信息和外部条件，预测环境接下来会如何变化。
  - Video prediction：预测后续视频画面。
  - Imagination rollout：模型在内部“想象”未来，模拟执行不同动作后可能出现的一系列状态。
  - Environment dynamics prediction：预测环境如何随着时间自然变化，或者在动作影响下发生变化。
- 表示空间和状态（Space and State Representation）：WM 可以把复杂的现实环境整理成便于模型处理的内部表示。
  - Visual representation：把图像或视频压缩成对任务有用的内部表示，例如物体、位置、运动方向和空间关系。
  - 3D world representation：表示可从不同视角观察的三维场景，以及场景中的空间结构。
  - Structured state representation：用物体、关节、关键点、占用空间或图结构等形式表示当前世界状态。
- 学习动作后果（Action-effect Learning）：WM 可以学习某个动作会怎样改变环境。
- 学习物体与因果关系（Object and Causal Understanding）：WM 可以从数据中学习世界中的物体、关系和变化规律。
  - Causal inference：尝试区分什么是原因、什么是结果。例如，杯子移动是因为手推了它，而不是因为背景发生了变化。
  - Commonsense reasoning：学习日常世界中的常识。例如，松手后物体通常会下落，人不能直接穿过墙壁，被遮挡的物体可能仍然存在。
  - Object relations：学习物体之间的位置、遮挡、接触和运动关系。

可以在这些**领域**发挥作用：

- 内容生成（Content Generation）：WM 可以利用学到的空间关系、物体变化和运动规律生成新的内容。
  - Video：生成后续视频画面。
  - 3D world：生成可以从不同视角观察的三维场景。
  - Game environment：根据玩家操作实时生成游戏画面和环境变化。
- 策略评估（Policy Evaluation）：这里的 policy 指智能体决定“下一步做什么”的策略。WM 可以充当虚拟环境，在不进入真实世界的情况下测试某个策略是否有效。
  - Autonomous Driving closed-loop simulation：让自动驾驶系统在模拟环境中连续做出转向、加速和刹车等决策，同时环境根据这些操作不断变化。
  - Robotics closed-loop simulation：让机器人在虚拟环境中执行抓取、移动和避障等动作，并观察其结果。
- 策略训练（Policy Training）：WM 可以为智能体提供可反复交互的模拟环境，帮助训练新的策略。
  - Model-based RL：先学习一个环境模型，再让智能体在模型中尝试动作、学习策略，而不是完全依赖真实环境。
- 数据生成（Data Generation）：WM 可以生成额外的训练与测试数据。
- 规划和控制（Planning and Control）：WM 可以先预测不同动作可能产生的结果，再帮助智能体选择更合适的动作。

## 什么是 WM

WM 的定义分为广义和狭义。

### 广义

WM 是一种特殊的 **predictive model**。

model 是对现实中某个事物的抽象表示，有点像 Java 中“class”的概念，即对某事物的特点进行简化的描述。

prediction 是 model 能完成的任务之一。除了 prediction，model 还可以进行 classification、generation、ranking 等等任务。

predictive model 主要用于输出一个能被量化的结果，比如明天的天气；而 WM 在 predictive model 的基础上，还会把**外部的干预**（例如 action）纳入 modeling 过程，重点是模拟出 **environment** 是如何随着 action 和 time 演化的。

要想能够有理有据地进行 prediction，必定要遵循某种规则，否则就是瞎猜。如果遵循的**法则是人为制定的**，就相当于根据人类已知的知识进行暴力计算解方程，比如传统的数学模型、概率模型、基于马尔可夫假设定义的状态转移模型；如果这个法则大家也不知道、不知道怎么用、不知道如何用更简单的方式进行大一统的表示，就可以让计算机替我们智能地暴力推算出未知的法则，即 Artificial Intelligence。更确切地说，是 Artificial Intelligence 这个技术中的一个子集，叫 Machine Learning，它的意思是能**从数据中学习规律**，并非简单地模仿人类。进一步看，对于预测 environment 的变化这种非纯数据性的任务，Machine Learning 中叫作 Deep Learning 的技术更合适，它的架构擅长处理 image、audio、text 这类 unstructured data。

所以，WM 整体上分为两类，一类使用人类明确编写的规则和方程进行模拟，另一类让模型从数据中自主推导出规则和方程（比如 model-based Reinforcement Learning 中用于环境理解的组件就是一种 WM），归根到底都是**遵循某种规律**，根据已有的 信息（和实时的扰乱信息），去**预测 environment 变化**。

但是因为各个 WM 的细微之处又有不同，按照以下两个问题将 WM 分类，会更便于区分各个范式：

- WM 输入/输出 **action** 吗？
  - 输入
    - 无 action：无扰乱，直接预测 environment 变化
    - 有 action：在 inference 过程中施加 action，预测 environment 变化
    - 不输入但自己学习 action：model 从 training data 中自主提取类似 action 的变量，预测 environment 变化
  - 输出
    - 除了 environment 还预测 action：同时预测 future action，即 World Action Model
- **预测**什么？
  - 具象的
	  - pixel or video
	  - structured data：按照人能够阅读的数据格式整理出的量化“世界状态”，比如物体、关节、occupancy、graph 或 keypoint 的变化
	  - 3D world、physics simulation
  - 抽象的
	  - latent representation：压缩后的“世界状态”

按照此种分类方式，大致可以将 WM 的范式分为以下称呼 ↓

![World model mental map](https://liyang.page/assets/img/world-model/world-model-map.svg)

也有种特别好理解的儿童版分类方式：Language Model 能预测下一个 token，可以说它是 Text World Model。Video Model 预测下一段 video，可以说它是 Video World Model。Game Model 根据玩家输入生成下一帧，也可以叫 Interactive World Model。

### 狭义

在各个领域 WM 的称呼和定义亦有不同，因为各个领域都有其独需的 predictive model 。

在不特指时，我们日常提到的 WM 一般是指 action-conditioned dynamics world model，预测“我做了这个 action 以后，world 会怎么变”。

## World Model 的演化

人做决定前，通常会先在脑中想一遍：“如果我这样做，接下来会发生什么？”World Model 做的也是这件事。它会观察周围发生过的事情，学习这个世界大致怎样变化。之后，当它准备采取某个行动时，会先在内部推演可能出现的结果，再选择更合适的行动。

以下是功能的演变过程：

最早有人提出有关人脑思考方式的一个猜想：人类会在脑中建立一个缩小版的世界，用它理解事情、预测未来。

到了现代人工智能阶段，研究者开始让机器自己学习环境的变化规律。例如，一个机器如想自动驾驶，不用每次都在真实道路上尝试，可以先在内部模拟。具体而言，用来让小车学会驾驶的系统可分为这三个部分：负责看懂画面、负责记住世界怎样变化、负责决定下一步做什么。

后来，机器不仅能预测下一步，还能在内部连续推演很多步，从多个方案中选择更好的行动。这让它学习得更快，也减少了真实试错的次数。

另一批研究者发现，机器没有必要预测画面里的每一个细节。例如，预测汽车下一秒会向前移动很重要，但预测树叶怎样摆动可能没有那么重要。这使 World Model 从“生成看起来真实的画面”，逐渐转向“理解世界中真正重要的规律”。

近些年，world model 不只能单纯地作为 RL 中的 dynamics 部分，也能生成可交互视频、建模 3D 环境、作为 foundation model 等等。

题外话，解释下 RL dynamics 和 foundation model：RL是一种机器学习方法，根据本轮决策结果与环境的互动优劣来改善下一轮决策结果。dynamics 在rl中一般指Dynamics 指环境怎样从当前状态、在动作作用下转移到下一状态，也就是模型如何‘通过与环境的互动优劣来得到改善后的下一轮决策结果’。世界模型就能从与环境交互的数据里学出 dynamics（环境如何随动作变化），从而辅助rl的决策的优化。基础模型通常指在海量数据上预训练、可迁移到多种任务的通用模型。尤其在物理 AI 场景里，厂商会把大规模预训练的世界模型称为 **world foundation model**，这类模型先学到通用的世界表示，再针对机器人、自动驾驶等下游任务做微调。

## 目前学术界的派别

简言之，从三个维度区分不同 world model：

- 表示形式
  - 具象生成：力图用世界模型呈现世界的外表。
    - Video Generation
    - 3D／4D Spatial World

  - 理解规则：力图用世界模型的规律表示世界。
    - JEPA／Representation Prediction
    - Structured State Dynamics

- 使用目的：内容生成、规划、策略训练、控制。
- 实现机制：学习模型、物理引擎、混合模型。

视频生成最直观，适合让人眼去观察，但对算力的需求很大，而且模型内部对世界规律的理解浅薄；三维生成的稳定性最强，适合进一步操作数据本身，但同样需要大量算力、数据也更少；在潜空间中表示并预测省算力、并能忽略信噪，但可解释性不高，不好优化；让模型习得状态转移方程更符合科学的自然规律，上限最高（我认为），但因为涉及到知识的不可知性，发展很困难，在某种程度上与‘潜空间表示’面临同样的困境。

## World Model 的发展方向

说到底，World Model 还是为了帮助人类实现预测而服务的。但在这个任务领域，最好用的工具仍旧是人类本身。

把人工智能用在这个领域，问题在于，ai 既没有人脑几亿年进化出的神经元的多样性以及连接方式，又没有进化了数十亿年的人类身体的精密的生物传感器，妄想用参数量远远小于人脑突触连接（ 10^14^ 到 10^15^ 量级）的人脑造出的工具——人工智能，来代替人脑本身运算，当然会有质量不高的问题。人工智能的优势在于能够输入特定的、数量少的模态来进行高速运算，但首先世界上远远不止图片、视频、文本这几个模态，其次人脑的计算速度虽然慢、但直觉的速度更快，在模态数量多的前提下，人能利用直觉进行远超计算机速度的运算。究其原因，或许是人脑在漫长的进化过程中，已经预训练出了一套效果不错的世界模型，信息在经流突触时被赋予权重，从而力压感受器数量少得可怜且训练时长极短（相比于人类演化史）的人造世界模型。

有一种派系的说法是，让世界模型作为预训练大模型（类似大脑），再用一个小模型来快速根据大模型的指导来决策（类似膝跳反射），这样能加快实时决策速度。

## 范式赏析

| 阶段        | 代表论文 / 系统                      | 核心问题                                          |
| --------- | ------------------------------ | --------------------------------------------- |
| 2018      | _[[World Models]]_             | 能不能在模型“梦境”中训练 agent                           |
| 2019-2023 | PlaNet, Dreamer V1/V2/V3       | 从像素学 latent dynamics，并在想象 rollout 里学 policy   |
| 2020-2024 | MuZero, EfficientZero, TD-MPC2 | 不必重建像素，只预测 reward/value/policy 或控制相关状态        |
| 2023-2024 | IRIS, STORM, DIAMOND           | Transformer / diffusion 进入 world model        |
| 2023-2025 | I-JEPA, V-JEPA, V-JEPA 2       | 不预测像素，预测语义/物理表征                               |
| 2024-2025 | Genie, UniSim, Cosmos, Marble  | 世界模型变成可交互/可生成/可产品化的基础模型                       |
| 2025      | Robotic World Model, RWM-U     | 机器人控制里解决 long-horizon drift 与不确定性             |
| 2025-2026 | Motus, DreamDojo, DreamZero    | 从 world model 走向 world action model，同步建模视频和动作 |

## Ref

https://liyang.page/wm-tutorial/
