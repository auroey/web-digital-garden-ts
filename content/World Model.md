---
title: World Model
date: 2025-08-15
---
# World Model 入门（1）：背景、定义

## World Model is all you need

其实 world model 这个概念早就有人提出了，但最近几年几个大火的领域都表示“理想与现实差距大大滴”，并甩锅给训练的数据，说训练时用的 simulated data 毕竟是庶出，要想效果好，还得用嫡出的 real-world data。此举可谓一石二鸟，既能给自己训练结果不好洗白，又便于拉到无穷的经费。

Robotics、Reinforcement Learning、Visual Generation、Embodied AI 与 Autonomous Driving 等等领域一商量，发现大家都缺 real-world environment data，正好之前有人提出了 WM 这一概念（不过当时叫 WM 的原因仅仅是模型先在“世界”中模拟，再进行下一步思考。命名简单直接，应用领域单一，没现在这么难懂，详见‘2018 年的 *World Models*’），大家一拍脑门、统一口径：哎哟我明白了，我彻底明白了，我们得训练 World Model！大家快来给我投资吧！

功能上，WM 可以在这些领域发挥作用：

- **Content Generation**：WM 可以学习世界中的空间关系、物体变化和运动规律，然后生成新的内容。
  - video：预测或生成后续视频画面。
  - 3D world：生成可从不同视角观察的三维场景。
  - game environment：根据玩家操作实时生成游戏画面和环境变化。
- **Policy Evaluation**：这里的 policy 指智能体决定“下一步做什么”的策略。WM 可以充当一个虚拟环境，在不进入真实世界的情况下，测试某个策略是否有效。
  - Autonomous Driving closed-loop simulation：让自动驾驶系统在模拟环境中连续做出转向、加速、刹车等决策，同时环境根据这些操作不断变化。
  - Robotics closed-loop simulation：让机器人在虚拟环境中执行抓取、移动、避障等动作，并观察结果。
- **Policy Training**：WM 还可以帮助训练新的策略。
  - model-based RL：先学习一个环境模型，再让智能体在这个模型中尝试动作、学习策略，而不是完全依赖真实环境。
  - imagination rollout：模型在内部“想象”未来。它会模拟执行不同动作后可能出现的一系列状态。
  - data generation：生成额外的训练数据，例如机器人操作视频、自动驾驶危险场景或游戏交互轨迹。
- **Physical Understanding**：WM 从数据中能习得世界的结构、关系和变化规律。
  - visual representation：把图像或视频压缩成对任务有用的内部表示，例如识别物体、位置、运动方向和空间关系。
  - causal inference：理解什么是原因、什么是结果。例如杯子移动是因为手推了它，而不是因为背景发生了变化。
  - commonsense reasoning：学习日常世界中的常识。例如松手后物体通常会下落，人不能直接穿过墙壁，遮挡后的物体可能仍然存在。

## 什么是 WM

WM 的定义分为广义和狭义。

### 广义

WM 是一种特殊的 **predictive model**。

model 是对现实中某个事物的抽象表示，有点像 Java 中“class”的概念，即对某事物的特点进行简化的描述。

prediction 是 model 能完成的任务之一。除了 prediction，model 还可以进行 classification、generation、ranking 等等任务。

predictive model 主要用于输出一个能被量化的结果，比如明天的天气；而 WM 在 predictive model 的基础上，还会把**外部的干预**（例如 action）纳入 modeling 过程，重点是模拟出 **environment** 是如何随着 action 和 time 演化的。

要想能够有理有据地进行 prediction，必定要遵循某种规则，否则就是瞎猜。如果遵循的**法则是人为制定的**，就相当于根据人类已知的知识进行暴力计算解方程，比如传统的数学模型、概率模型、定义好的状态转移模型（如马尔可夫）；如果这个法则大家也不知道、不知道怎么用、不知道如何用更简单的方式进行大一统的表示，就可以让计算机替我们智能地暴力推算出未知的法则，即 Artificial Intelligence。更确切地说，是 Artificial Intelligence 这个技术中的一个子集，叫 Machine Learning，它的意思是能**从数据中学习规律**，并非简单地模仿人类。进一步看，对于预测 environment 的变化这种非纯数据性的任务，Machine Learning 中叫作 Deep Learning 的技术更合适，它的架构擅长处理 image、audio、text 这类 unstructured data。

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

按照此种分类方式，一共可以将 WM 的范式分为 4 × 4 = 16 种 ↓

![World model mental map](https://liyang.page/assets/img/world-model/world-model-map.svg)

也有种特别好理解的儿童版分类方式：Language Model 能预测下一个 token，可以说它是 Text World Model。Video Model 预测下一段 video，可以说它是 Video World Model。Game Model 根据玩家输入生成下一帧，也可以叫 Interactive World Model。

### 狭义

在不特指时，我们日常提到的 WM 一般是指 action-conditioned dynamics world model，预测“我做了这个 action 以后，world 会怎么变”。

# World Model 入门（2）：演化、现行派别

## World Model 的演化

人做决定前，通常会先在脑中想一遍：“如果我这样做，接下来会发生什么？”World Model 做的也是这件事。它会观察周围发生过的事情，学习这个世界大致怎样变化。之后，当它准备采取某个行动时，会先在内部推演可能出现的结果，再选择更合适的行动。

以下是功能的演变过程：

最早有人提出有关人脑思考方式的一个猜想：人类会在脑中建立一个缩小版的世界，用它理解事情、预测未来。不过这个猜想并没有格外突出的学术价值，顶多给人研究灵感。

到了现代人工智能阶段，研究者开始让机器自己学习环境的变化规律。例如，一个机器如想自动驾驶，不用每次都在真实道路上尝试，可以先在内部模拟。具体而言，用来让小车学会驾驶的系统可分为这三个部分：负责看懂画面、负责记住世界怎样变化、负责决定下一步做什么。

后来，机器不仅能预测下一步，还能在内部连续推演很多步，从多个方案中选择更好的行动。这让它学习得更快，也减少了真实试错的次数。

另一批研究者发现，机器没有必要预测画面里的每一个细节。例如，预测汽车下一秒会向前移动很重要，但预测树叶怎样摆动可能没有那么重要。这使 World Model 从“生成看起来真实的画面”，逐渐转向“理解世界中真正重要的规律”。

近些年，world model 不只能单纯地作为 RL 中的 dynamics 部分，也能生成可交互视频、建模 3D 环境、作为 foundation model 等等。

题外话，解释下RL dynamics和 foundation model：RL是一种机器学习方法，根据本轮决策结果与环境的互动优劣来改善下一轮决策结果。dynamics 在rl中一般指用来优化决策的法则，也就是模型如何‘通过与环境的互动优劣来改善下一轮决策结果’。世界模型就能从与环境交互的数据里学出 dynamics（环境如何随动作变化），从而辅助rl的决策的优化。基础模型通常指在海量数据上预训练、可迁移到多种任务的通用模型。尤其在物理 AI 场景里，厂商会把大规模预训练的世界模型称为 **world foundation model**，这类模型先学到通用的世界表示，再针对机器人、自动驾驶等下游任务做微调。

## 目前学术界的派别

简言之，做如下分类：

- （生成了什么）具象生成派：力图用世界模型呈现世界的外表。
  - 视频生成派
  - 3D／4D 空间世界派
- （生成了什么）理解规则派：力图用世界模型的规律表示世界。
  - JEPA／表征预测派
  - 结构化状态动力学派
- （目的是什么）辅助决策派：将世界模型作为智能体训练决策能力的平台。
  - 强化学习与规划派
  - 具身行动与 World Action Model 派
- （如何做到的）物理引擎与神经模型混合派：用现有的规则明确的物理模型辅助神经网络得到产出。

下面挨个聊。

### 视频生成派



### 3D／4D 空间世界派



### JEPA／表征预测派



### 结构化状态动力学派



### 强化学习与规划派



### 具身行动与 World Action Model 派



### 物理引擎与神经模型混合派



# World Model 入门（3）：优缺点、发展方向

人工智能的瓶颈是没有人脑几亿年的进化的神经元的多样性以及连接方式，又没有进化了千亿年的人类身体的精密感受器、传导、作用器...有一种派系的说法是，让世界模型作为大脑预训练，身体作为小模型，这样能加快实时决策速度，小模型起到膝跳反射这种功能，最好能无意识一步推导结果。





## Ref

https://liyang.page/wm-tutorial/