# MVSplat Intro

PAPER：https://arxiv.org/pdf/2403.14627

REF：https://www.bilibili.com/video/BV1sAWhe1ENw/?spm_id_from=333.337.search-card.all.click&vd_source=8be5ba4fcf7c69b9960ed391f70c5fb0

## Background

为了生成新视角的图像，先建构3D

![image-20250118102041719](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/image-20250118102041719.png)

选择用3DGS，速度快质量高。但速度能耗内存还能继续优化，使用Feed-Forward 3DGS网络

挑战是网络优化需要逼近，但3DGS不可导（？）

![image-20250118102809491](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/image-20250118102809491.png)

要利用Cost Volume的方式找到高斯球的位置。

Cost Volume：首先定义搜索空间并离散化，将高斯球的模板特征与搜索空间每个点的特征通过匹配代价函数计算相似度，构建记录匹配代价值的三维Cost Volume。然后，通过遍历 Cost Volume 找到代价值最低的位置，即为高斯球的最佳估计位置

## Method

![image-20250118104748826](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/image-20250118104748826.png)

1. **两个输入视图需要有重叠区域（overlap）**

2. **提取特征**：

   - Shallow CNN 提取 4 倍下采样特征。
   - Multi-view Transformer（cross-view attention）。
   - 为每个输入视图获取多视图感知特征 $F^i$。

3. **输入特征，输出 3D 高斯信息**：

   1. **每个视图生成一个 Cost Volume**：

      - 对于每个输入视图 $I^i$，通过匹配生成一个对应的 **Cost Volume**： 

        ![image-20250118114432266](C:\Users\10543\AppData\Roaming\Typora\typora-user-images\image-20250118114432266.png)

      - **$\frac{H}{4}, \frac{W}{4}$** 是特征图的下采样分辨率。

      - $D$ 是深度（视差）的候选范围。

      - 每个 $C_{d_j}^i$ 表示在某一深度假设下（如视差或三维位置）当前视图的匹配代价。

      - **作用**：记录场景中每个位置与高斯球的几何和纹理特征匹配的代价。

   2. **2D U-Net 优化 Cost Volume**：

      - **问题**：某些区域（例如纹理较少的区域）可能因为特征不足而导致 Cost Volume 的估计不准确。

      - 解决方法

        ：

        - 使用 **2D U-Net** 进行优化，改进 Cost Volume：

          ![image-20250118114541502](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/image-20250118114541502.png)

        - $C^i$：初始 Cost Volume。

        - $\Delta C^i$：通过 2D U-Net 计算的优化增量。

      - **关键点**：优化后的 $\hat{C}^i$ 更能处理纹理较少区域（如平面或阴影区域）的匹配。

   3. **CNN 上采样恢复分辨率**：

      - 在完成 Cost Volume 的优化后，将特征重新上采样回原分辨率。
      - 这样可以将优化后的深度特征投影回输入视图的原始分辨率，方便进一步计算三维高斯参数或新视角渲染。

4. **投影生成 3D 高斯分布**：

   - 从优化后的 Cost Volume 中提取三维高斯分布的参数（$\mu, \Sigma, c, \alpha$），作为场景的稀疏表示：
     1. $\mu$：位置。
     2. $\Sigma$：协方差矩阵，描述高斯球的形状。
     3. $c$：颜色。
     4. $\alpha$：透明度或权重。
   - 这些高斯分布参数被用于生成三维场景的稀疏表示，进而进行新视角渲染。

5. **渲染新视角（Novel View）**：

   - 利用高斯分布参数，渲染出从未见过的视角。
   - 优化后的 Cost Volume 和高斯分布确保了渲染结果的高保真度。

6. 获得深度

![image-20250118115325736](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/image-20250118115325736.png)

![image-20250118115340440](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/image-20250118115340440.png)

7. 获得并表示高斯信息

![image-20250118115623803](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/image-20250118115623803.png)

可以开始render并计算loss了，只需要使用2D的信息，3D信息只是载体

## Contribution（没懂）

如何使用feed-forward高效计算 3D 高斯中心？使用Geometry prior。

- **核心思想**：
  数据驱动的回归方法可能会因为数据的不可靠性导致估计误差较大。因此，引入 **几何先验**，通过 **Cost Volume** 的特征匹配方式代替直接回归的方法，使得特征的匹配更加鲁棒和可靠。
  - **数据驱动回归的局限**：直接通过神经网络预测 3D 高斯中心容易受到数据噪声或纹理缺乏区域的影响。
  - **几何先验的优势**：利用视图间的几何关系和深度一致性，通过 Cost Volume 提供可靠的匹配信息，提高估计的准确性。
- **总结**：
   凭借几何先验，转变原本不可靠的回归问题为特征匹配问题，通过精确的几何关系优化 3D 高斯中心的估计。

如何高效实现上述过程？使用特征匹配主干网络（UniMatch）+ 2D U-Net 细化，避免使用 MVS 中的 3D 卷积。

- 核心技术：
  1. **UniMatch**：
     - UniMatch 是一种高效的特征匹配主干网络，可以处理多视图的特征匹配任务，并生成初步的 Cost Volume。
     - 相较于传统方法，UniMatch 更快且内存占用更小，适用于高效计算的场景。
  2. **2D U-Net 细化**：
     - 使用 2D U-Net 对生成的 Cost Volume 进行优化，进一步提高纹理较少区域的匹配精度。
     - 相比于多视图立体（MVS）中常用的 3D 卷积，2D U-Net 更加轻量化且计算效率更高。
  3. **避免 3D 卷积**：
     - 3D 卷积通常计算量大且对硬件要求高，通过 2D U-Net 替代可以大幅降低计算复杂度，同时保持较高的估计精度。

## Limitation

无生成能力；不能建模有反光的材质（无法理解语义）

