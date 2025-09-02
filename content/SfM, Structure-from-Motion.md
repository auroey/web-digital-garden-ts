---
title: SfM, Structure-from-Motion
date: 2025-09-02
---
# 主流 SfM 方法分类与特点

## 两大类型
目前主流的 **SfM（Structure from Motion，运动结构恢复）** 方法主要分为两类：

1. **全局式 SfM（Global SfM）**
2. **增量式 SfM（Incremental SfM）**

---

## 全局式 SfM
- **基本思路**  
  一次性求解所有相机的位姿，然后通过三角化获得场景点。  
- **位姿估计分两步**：  
  1. **全局旋转估计**  
  2. 在已知旋转的基础上，**全局平移估计**  
- **关键问题**  
  - 第二步依赖第一步，因此 **全局旋转估计的精度** 决定了最终结果质量。  
- **优缺点**  
  - 优点：只需在最后进行一次 **Bundle Adjustment (BA)**，效率高。  
  - 缺点：鲁棒性差，容易被 outlier 干扰导致重建失败。  

---

## 增量式 SfM
- **基本思路**  
  一边进行 **三角化 (Triangulation)** 与 **PnP (Perspective-n-Points)**，一边执行局部 **BA 优化**。  
- **优缺点**  
  - 优点：鲁棒性高，对 outlier 不敏感。  
  - 缺点：效率较低，每加入一张图像都要 BA；误差会累积，可能产生漂移。  

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202509021507458.png)

### 流程步骤

1. **Image Acquisition**
   - 从不同角度获取场景的多张重叠图像。  
   - 图像重叠越多、视角越丰富，重建效果越好。  

2. **Feature Detection**
   - 使用 **SIFT / SURF / ORB** 等算法在每张图像中检测显著特征点。  
   - 这些特征对尺度、旋转和光照变化具有鲁棒性。  

3. **Feature Matching**
   - 在不同图像之间进行特征匹配，找到对应的物理点。  
   - 匹配的可靠性直接决定 3D 重建精度。  

4. **Camera Pose Estimation**
   - 根据匹配的特征点，估计相机的外参（位置与姿态）。  
   - 常用方法是求解 **Essential Matrix / Fundamental Matrix**。  

5. **Triangulation**
   - 利用相机位姿，将多视角下的对应点进行三角化，计算出 3D 点坐标。  

6. **Bundle Adjustment**
   - 同时优化 3D 点位置和相机参数，最小化 **Reprojection Error**。  
   - 这是一个非线性优化问题，是获得高精度重建的关键。  

7. **Dense Reconstruction (可选)**
   - 在稀疏点云基础上，利用插值或深度学习方法获得稠密重建，生成更详细的 3D 模型。  

8. **Texturing and Model Generation**
   - 生成网格，并从原始图像中提取纹理贴图，使模型更逼真。  
   - 
---

## 常见开源实现
- **Colmap**：采用 **增量式 SfM pipeline**，鲁棒性强，应用广泛。  
- **OpenMVG**：同时实现了 **增量式** 和 **全局式** 两种 pipeline，供用户选择。  

---

## 总结
- **全局式 SfM**：高效，但脆弱。适合图像质量高、匹配准确的场景。  
- **增量式 SfM**：鲁棒，但效率低。更适合无序、多噪声的实际应用场景。  