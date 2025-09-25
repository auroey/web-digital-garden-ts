---
title: SentencePiece
date: 2025-09-16
---
SentencePiece 是一个**无须先做空格切分**的子词分词器（tokenizer），支持多种子词模型（常见的是 **unigram** 和 **BPE**）。它把原始文本直接当作字节/字符流来处理，训练出一个固定大小的词表（vocabulary），并提供编码（text→subwords/ids）与解码（ids→text）接口。关键优点是对语言中间态（如中文、日文、没有空格的语言）友好，并且非常适合端到端神经网络训练。