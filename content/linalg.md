---
title: linalg
date: 2025-08-14
---
`linalg` 通常指 **线性代数（linear algebra）** 模块；在 Python 里多指 `numpy.linalg`（基础）或 `scipy.linalg`（更全更稳）。给你一份极简速查👇

# NumPy `numpy.linalg` 常用函数速查

- **解线性方程**  
    `np.linalg.solve(A, b)`：解方阵线性方程组 Ax=bA x=b（要求 det⁡(A)≠0\det(A)\neq0）
    
- **最小二乘**  
    `np.linalg.lstsq(A, b, rcond=None)`：解过定/欠定系统的最小二乘解
    
- **行列式/秩/范数**  
    `np.linalg.det(A)`：det⁡(A)\det(A)  
    `np.linalg.matrix_rank(A)`：秩  
    `np.linalg.norm(A, ord=2)`：向量/矩阵范数（按 `ord` 选择）
    
- **逆/伪逆**  
    `np.linalg.inv(A)`：矩阵逆（仅非奇异方阵）  
    `np.linalg.pinv(A)`：Moore–Penrose 伪逆
    
- **特征分解 / SVD**  
    `np.linalg.eig(A)`：一般方阵的特征值与特征向量  
    `np.linalg.eigh(A)`：对称/厄米矩阵特征分解（更稳定）  
    `np.linalg.svd(A, full_matrices=True)`：奇异值分解 A=UΣVTA=U\Sigma V^T
    
- **其他**  
    `np.linalg.qr(A)`：QR 分解  
    `np.linalg.cholesky(A)`：Cholesky 分解（要求对称正定）  
    `np.linalg.slogdet(A)`：返回 (sign,log⁡∣det⁡(A)∣)(\text{sign}, \log|\det(A)|)（数值稳定）
    

## 迷你示例

```python
import numpy as np

A = np.array([[3., 2.],
              [1., 4.]])
b = np.array([7., 5.])

x = np.linalg.solve(A, b)           # 解 Ax=b
detA = np.linalg.det(A)             # 行列式
rankA = np.linalg.matrix_rank(A)    # 秩
vals, vecs = np.linalg.eig(A)       # 特征分解
U, S, VT = np.linalg.svd(A)         # SVD
A_inv = np.linalg.inv(A)            # 逆
x_ls, *_ = np.linalg.lstsq(A, b, rcond=None)  # 最小二乘
```


