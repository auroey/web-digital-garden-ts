---
title: Template Metaprogramming
date: 2025-08-13
---

**作用**：

- 用 **C++ 模板** 在编译阶段生成不同版本的渲染器代码，而不是在运行时用 if/else 选择功能。
    
- 可以“替换”渲染器中所有算术类型、数据结构，甚至函数调用方式，从而快速生成新特性版本的渲染器。
    

**例子**：  
假设一个普通渲染器用 `float` 表示颜色值：

```cpp
using Color = float;
```

Mitsuba 2 可以在编译期用模板把它换成：

- **`Spectrum`**（多波长光谱）
    
- **`StokesVector`**（带偏振信息）
    
- **`Vectorized<Float>`**（SIMD 宽向量）
    
- **`Diff<Float>`**（可微分变量类型）
    

这样不需要手工重写所有函数，模板自动替换类型并生成新的渲染代码。