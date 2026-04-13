---
title: 执行智能体
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, llm-agent, tool-using-agent, chinese]
lang: zh
sources: [raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md]
---

# 执行智能体

负责解决[[zh/concepts/curriculum-agent\|课程智能体]]生成任务的智能体。在 [[zh/entities/agent0-framework\|Agent0]] 中，它通过 [[zh/concepts/adpo\|ADPO]]（模糊感知动态策略优化）训练，支持多轮工具集成。

## 特征

- 接收课程智能体的任务
- 可以调用外部工具（如 Python 解释器）进行多轮交互
- 基于自生成解决方案的 RL 训练，使用多数投票作为伪标签

## 训练挑战

多数投票产生噪声伪标签。当一致性低（高模糊度）时，标签不可靠。[[zh/concepts/adpo\|ADPO]] 通过基于模糊度动态调整信任域来解决这个问题。

## 相关

- [[zh/concepts/curriculum-agent\|课程智能体]]
- [[zh/concepts/adpo\|ADPO]]
- [[zh/entities/sage-framework\|SAGE]] 中的 Solver — 等效角色
