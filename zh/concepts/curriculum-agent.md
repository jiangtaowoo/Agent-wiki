---
title: 课程智能体
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, curriculum-learning, multi-agent, chinese]
lang: zh
sources: [raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md]
---

# 课程智能体

[[zh/entities/agent0-framework\|Agent0]] 的核心概念：一个智能体，其明确角色是为另一个智能体生成训练任务，通常优化特定的难度目标。

## 目标

生成任务 $x$，使执行智能体 $\pi_\phi$ 受到挑战但不被压倒。在 Agent0 中，这被形式化为最大化不确定性：

$$R_{unc} = 1 - 2|\hat{p} - 0.5|$$

其中 $\hat{p}$ 是执行者的自一致性（多数投票比例）。完美课程发生在执行者恰好 50% 把握时——它足够了解以做出有根据的猜测，但不足以确定。

## 组成

- **不确定性奖励**: 将任务推到能力边界
- **工具使用奖励**: 鼓励需要外部工具的任务
- **重复惩罚**: 防止生成类似任务（基于 BLEU 聚类）

## 相关

- [[zh/concepts/executor-agent\|执行智能体]] — 解决生成任务的对应角色
- [[zh/entities/sage-framework\|SAGE]] — Challenger 智能体扮演类似角色，但有 Critic 质量过滤
