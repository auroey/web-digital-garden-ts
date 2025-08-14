---
title: Rendering Equation
date: 2025-08-11
---
光照、材质、几何与图片之间的映射关系，通过**渲染方程**（Rendering Equation）来描述。

逆渲染依赖全局光照（Global Illumination）理论，其核心物理量是**辐射亮度** $L(r,\omega)$，由**渲染方程**描述，包含**自发光** $L_e$、**双向反射分布函数（BRDF）** $f_r$、**入射光方向**等。

### 渲染方程（积分形式）
$$
L(r,\omega) = L_e(r,\omega) + \int_{S_i} f_r(r,\omega,\omega_i)\, L(r,\omega_i)\, \cos\theta \, d\omega_i
$$

### 算子形式
- $\hat{K}$（**局部反射算子**）：描述入射光在一次局部反射后的出射分布  
$$
(\hat{K}h)(r,\omega) \equiv \int_{S_i} k(r;\,\omega' \to \omega)\, h(r,\omega')\, d\mu(\omega')
$$

- $\hat{G}$（**场辐射算子**）：描述物体表面之间的相互照明  
$$
(\hat{G}h)(r,\omega) \equiv
\begin{cases}
h\big(p(r;-\omega),\,\omega\big), & \nu(r,\omega) < \infty \\
0, & \text{otherwise}
\end{cases}
$$

### 简洁形式
$$
L = L_e + \hat{K}\hat{G}L
$$

