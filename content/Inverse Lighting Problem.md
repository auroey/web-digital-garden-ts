---
title: Inverse Lighting Problem
date: 2025-08-11
---
**光照**是场景中能量的来源。对于物体为中心的场景，常通过环境贴图（Environmental Map）来表示。

- 表示环境中光源的位置与亮度，直接影响物体的阴影与高光。
    
- 常用**[[HDRI]]**来捕捉360°环境光照。
    
- 逆渲染中需估计光源的发光度与位置。


对于光照恢复，经典方法通常构造一个[[Least Squares Optimization Problem]]或以[[Matrix Decomposition]]的方式来求解光照，使得该光照能呈现出与观测到的照片相同的效果。但由于这一问题的病态性（ill-posed），导致多种光照设定都能呈现出相同的结果，因此需要一些特殊的正则化来保证光照的合理性。