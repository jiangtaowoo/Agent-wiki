---
title: 进化树
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, test-time-scaling, chinese]
lang: zh
sources: [raw/articles/learning-to-self-evolve.md]
---

# 进化树

[[zh/entities/lse-framework\|LSE]] 引入的搜索结构，用于探索可能的 prompt 上下文空间，而不不可逆转地承诺到次优路径。

## 结构

树 $\mathcal{G}$ 中的每个节点存储：
- $c_n$: prompt 上下文
- $S_n$: 性能摘要
- $\bar{R}_n$: 平均 holdout 奖励
- $v_n$: 访问次数

## 选择

使用 **UCB1**（上置信界）平衡利用和探索：
$$n^* = \arg\max_{n \in \mathcal{G}} \bar{R}_n + C\sqrt{\frac{\ln N}{v_n}}$$

## 目的

Prompt 优化是非凸的，序列编辑可能累积错误。树并行维护多个有前途的上下文，允许智能体如果某条进化路径退化时回退到更好的节点。

## 相关

- 蒙特卡洛树搜索 (MCTS)
- UCB 算法
- [[zh/concepts/test-time-self-evolution\|测试时自进化]]
