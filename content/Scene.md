---
title: Scene
date: 2025-08-11
---
可以由多个物体（Object）组成。场景可以通过物体本身的模型以及之间的相对位置关系来描述。我们可以对每个物体赋予一个坐标系，并且定义一个世界原点。这样，无论是什么样的物体，我们都可以通过坐标系之间的相对**[[Coordinate Transformation]]** 来表示Pose（Translation、Rotation）两部分。同样的，作为拍摄场景的相机（Camera），也可以视作一个特殊的物体。