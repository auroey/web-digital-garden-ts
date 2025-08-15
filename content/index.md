---
title: Index
date: 2025-08-11
---
这是我的个人知识库，记录我在科研、学习与创作中的点滴思考。我目前的研究兴趣在于 **[[3DV]]** 、 **[[AIGC]]** 、 **[[LLM]]** 和 **[[CG]]**，笔记大多围绕这些课题展开。

你可以：

1. 点击任何 `[[链接]]` 跳转到相关页面  
2. 查看或搜索页面左侧的所有链接  
3. 使用右上方的图谱视图查看知识网络

最新更新：
```dataview
TABLE WITHOUT ID "[[" + file.name + "]]" AS 标题, dateformat(file.mtime, "yyyy-MM-dd") AS 更新时间
FROM "ResearchNotes/content"
SORT file.mtime DESC
LIMIT 5
```

推荐入口：
```dataview
TABLE WITHOUT ID "[[" + file.name + "]]" AS 标题, length(file.inlinks) AS 链接数
FROM "ResearchNotes/content"
SORT length(file.inlinks) DESC
LIMIT 5
```