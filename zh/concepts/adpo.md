---
title: ADPO (模糊感知动态策略优化)
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, reinforcement-learning, chinese]
lang: zh
sources: [raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md]
---

# ADPO (Ambiguity-Dynamic Policy Optimization)

[[zh/entities/agent0-framework\|Agent0]] 引入的 RL 算法，扩展了 GRPO 以处理自一致性多数投票产生的**噪声伪标签**。

## 问题

在自进化环境中，真实标签不可用。执行者使用 $k$ 个样本的多数投票作为伪标签。当自一致性 $\hat{p}$ 低时，这个标签有噪声，可能误导策略优化。

## 解决方案

### 1. 模糊感知优势缩放

降低高模糊度（低一致性）样本的权重：
$$\tilde{A}_i(x) = \hat{A}_i \cdot s(x)$$
其中 $s(x) = f(\hat{p}(x))$ 是自一致性的增函数。

### 2. 动态信任域

标准 PPO/GRPO 使用固定裁剪边界 $\epsilon$。ADPO 将上界设为 $\hat{p}$ 的减函数：
- 对于**模糊输入**（低 $\hat{p}$）→ 放宽裁剪，允许模型探索更多非常规推理路径
- 对于**清晰输入**（高 $\hat{p}$）→ 收紧裁剪，防止偏离可靠的伪标签

## 目标函数

$$\mathcal{L}_{ADPO}(\theta) = -\mathbb{E}\left[\min\left(r_i(\theta) \tilde{A}_i(x), \text{clip}(r_i(\theta), 1-\epsilon_{low}, 1+\epsilon_{high}(x)) \tilde{A}_i(x)\right)\right]$$

## 相关

- GRPO — ADPO 扩展的基础算法
- PPO — 基础策略梯度方法
