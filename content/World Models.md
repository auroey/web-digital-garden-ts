原文：[World Models](https://worldmodels.github.io/)

供参考笔记：[用于决策的世界模型 -- 论文 World Models (2018) & PlaNet (2019) 讲解 - 伊犁纯流莱 - 博客园](https://www.cnblogs.com/tshaaa/p/18670731)
# 思想架构

本文完整提出 agent 先理解世界再行动的流程，即先观察，再推测，然后行动。

把智能体拆成两部分：

- **大型世界模型**：学习理解环境、记住变化、预测未来；
- **小型控制器**：根据世界模型提供的信息决定动作。

前置知识：
- [[Evolution Strategies]]
- [[Mixture Density Network，MDN]]

---

## 模型整体结构

（这图太不严谨了）

![img](https://worldmodels.github.io/assets/world_model_overview.svg)

Our agent consists of three components that work closely together: Vision (V), Memory (M), and Controller (C).

World Model: V+M

---

## Vision（V）

![img](https://worldmodels.github.io/assets/vae.svg)

Flow diagram of a Variational Autoencoder.

---

## Memory（M）

![img](https://worldmodels.github.io/assets/mdn_rnn_new.svg)

RNN with a Mixture Density Network output layer. The MDN outputs the parameters of a mixture of Gaussian distribution used to sample a prediction of the next latent vector *z*.

---

## Controller（C）

$$
a_t = W_c \; [z_t \; h_t]\; + \; b_c
$$

---

## Agent 完整流程

![img](https://worldmodels.github.io/assets/world_model_schematic.svg)

Flow diagram of our Agent model. The raw observation is first processed by V at each time step $t$ to produce $z_t$. The input into C is this latent vector $z_t$ concatenated with M’s hidden state $h_t$ at each time step. C will then output an action vector $a_t$ for motor control. M will then take the current $z_t$ and action $a_t$ as an input to update its own hidden state to produce $h_{t+1}$ to be used at time $t+1$.Flow diagram of our Agent model. The raw observation is first processed by V at each time step $t$ to produce $z_t$. The input into C is this latent vector $z_t$ concatenated with M’s hidden state $h_t$ at each time step. C will then output an action vector $a_t$ for motor control. M will then take the current $z_t$ and action $a_t$ as an input to update its own hidden state to produce $h_{t+1}$ to be used at time $t+1$.

```py
def rollout(controller):
  ''' env, rnn, vae are '''
  ''' global variables  '''
  obs = env.reset()
  h = rnn.initial_state()
  done = False
  cumulative_reward = 0
  while not done:
    z = vae.encode(obs)
    a = controller.action([z, h])
    obs, reward, done = env.step(a)
    cumulative_reward += reward
    h = rnn.forward([a, z, h])
  return cumulative_reward
```

------

# Experiments

## Train

### 1. 随机探索并收集数据

先让随机策略开车很多局。

在每个时间步记录：

$$
(x_t,a_t,x_{t+1})
$$

最终得到大量连续序列：

$$
x_0,a_0,x_1,a_1,x_2,\ldots
$$

这一步只负责收集数据，还没有训练 V、M 和 C。

------

### 2. 训练 VAE（V）

使用收集到的所有画面训练 VAE：

$$
z_t=V(x_t)
$$

VAE 学习把每张画面压缩成一个低维向量 $z_t$，并尽量从 $z_t$ 重建原画面。

训练好 V 后，将连续画面转换成：

$$
z_0,a_0,z_1,a_1,z_2,\ldots
$$

------

### 3. 训练 MDN-RNN（M）

首先初始化隐藏状态：

$$
h_0=0
$$

然后按照时间顺序更新隐藏状态：

$$
h_{t+1}=RNN(z_t,a_t,h_t)
$$

同时，MDN-RNN 学习预测：

$$
P(z_{t+1}\mid a_t,z_t,h_t)
$$

这里需要注意：

> $h_t$ 不是单独训练出来的固定参数。

真正被训练的是 M 内部的网络参数。

训练完成后，$h_t$ 是 M 根据之前的状态和动作实时计算出来的：

$$
h_t=RNN(z_{t-1},a_{t-1},h_{t-1})
$$

因此，$h_t$ 可以理解为过去画面和动作的动态摘要。

------

### 4. 训练 Controller（C）

训练 C 时，V 和 M 已经训练完成并保持固定。

在每个时间步：

#### V 压缩当前画面

$$
z_t=V(x_t)
$$

#### C 决定动作

$$
a_t=C(z_t,h_t)
$$

#### 环境执行动作并返回反馈

$$
(x_{t+1},r_t,\text{done})=Env(x_t,a_t)
$$

#### M 更新隐藏状态

$$
h_{t+1}=M(z_t,a_t,h_t)
$$

一整局结束后，得到累计奖励：

$$
R=\sum_t r_t
$$

CMA-ES 会生成多组不同的 Controller 参数，让它们分别跑完整局。

然后：

1. 比较每个 Controller 的累计奖励；
2. 保留奖励较高的参数；
3. 根据高分参数生成新一代参数；
4. 重复测试和筛选；
5. 最终得到表现较好的 Controller。

------

## Inference

首先初始化环境和隐藏状态：

$$
x_0=Env.reset()
$$

$$
h_0=0
$$

之后，在每个时间步重复以下过程。

### 1. V 压缩当前画面

$$
x_t\xrightarrow{V}z_t
$$

### 2. C 决定动作

$$
(z_t,h_t)\xrightarrow{C}a_t
$$

### 3. 环境执行动作

$$
(x_t,a_t)\xrightarrow{Env}(x_{t+1},r_t,\text{done})
$$

### 4. M 更新隐藏状态

$$
(z_t,a_t,h_t)\xrightarrow{M}h_{t+1}
$$

然后进入下一个时间步：

$$
x_{t+1}\xrightarrow{V}z_{t+1}
$$

### 注

- 论文默认采用的是**从 0 开始编号**的时间索引，第一帧 t=0。
- $h_0$ = RNN.initial_state()

# 优缺点

研究证明，智能体可以完全在模型想象出的虚拟世界中训练，而不必一直运行真实环境。

这样做有几个优点：

- 真实游戏需要渲染画面和计算物理过程，消耗很多算力。
- 虚拟世界更轻量，可以反复训练很多次。
- 在虚拟世界中学到的策略，有可能再用于真实环境。
- 世界模型可以在多块 GPU 上并行运行，提高训练速度。
- 因为整个模型可以计算梯度，未来还可能直接通过反向传播优化智能体的策略。

但这种方法也有明显问题。

首先，VAE 是单独训练的，它只负责压缩画面，却不知道哪些内容对任务真正重要。

例如，它可能认真保留墙上的砖块纹理，却忽略赛车道路上真正影响驾驶的信息。

如果让 VAE 和负责预测奖励的世界模型一起训练，它就可能更关注任务相关内容。但这样训练出的视觉模型会更专用，换一个任务后可能需要重新训练。

第二，世界模型的记忆容量有限。

即使保存了大量历史数据，LSTM 也未必能把所有信息都记进参数中。神经网络学习新内容时，还可能忘掉以前学过的内容，也就是“灾难性遗忘”。

因此，未来可以：

- 使用容量更大的模型；
- 加入外部记忆模块；
- 改进防止遗忘的方法。

第三，现在的世界模型还是一步一步预测未来，缺少人类那种抽象思考和分层规划能力。

人类做计划时，不会预测每一个像素和每一个细节，而是会直接思考“先去哪里，再完成什么任务”。

未来的模型可以学习调用内部不同的“子程序”，重复利用已经掌握的能力，进行更高级的规划。

还有一种方向，是把控制器和世界模型合并成一个大网络，并不断复习旧能力，避免学习新任务时忘掉以前的技能。