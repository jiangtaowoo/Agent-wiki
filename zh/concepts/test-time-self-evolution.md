---
title: 测试时自进化
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, test-time-scaling, prompt-optimization, chinese]
lang: zh
sources: [raw/articles/learning-to-self-evolve.md]
---

# 测试时自进化

一种模型在**推理时**改进自身**上下文**（prompt）而不更新底层参数 $\theta$ 的范式。[[zh/entities/lse-framework\|LSE]] 的核心概念。

## 区分

| 类型 | 改变什么 | 何时 | 例子 |
|------|---------|------|------|
| **单次问题内** | 单个问题内的推理 | 推理期间 | 思维链、自我纠正 |
| **跨问题间** | 跨多个问题的上下文 | 任务之间 | [[zh/entities/lse-framework\|LSE]] |
| **参数更新** | 模型权重 | 训练期间 | 微调、RLHF |

测试时自进化专注于**跨问题、基于 prompt** 的设置。

## 为什么重要

- 避免参数更新的灾难性遗忘
- 实现对新任务分布的快速适应
- 允许小模型通过投资更多推理时计算来超越大模型

## LSE 的方法

将上下文编辑视为策略 $f_\psi$，用 RL 训练以最大化性能改进：
$$r = \bar{R}(c_1) - \bar{R}(c_0)$$

## 相关

- Prompt 优化
- 上下文学习 (In-context learning)
- 元提示 (Meta-prompting)
