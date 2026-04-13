---
title: Agent0 框架 (Unleashing Self-Evolving Agents from Zero Data)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [framework, llm-agent, zero-data, tool-using-agent, curriculum-learning, reinforcement-learning]
lang: zh
sources: [raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md]
---

# Agent0 框架 (Unleashing Self-Evolving Agents from Zero Data)

**论文**: [arXiv:2511.16043](https://arxiv.org/abs/2511.16043)  
**作者**: Peng Xia, Kaide Zeng, Jiaqi Liu, Can Qin, Fang Wu, Yiyang Zhou, Caiming Xiong, Huaxiu Yao  
**机构**: 北卡罗来纳大学教堂山分校, Salesforce Research, 斯坦福大学  
**代码**: https://github.com/aiming-lab/Agent0

## 概述

Agent0 是一个**完全自主、零数据**的框架，通过**多步协同进化**和**无缝工具集成**来培养高性能的 LLM 智能体。它消除了对人类整理数据的依赖，通过在同一个基础 LLM 上初始化的两个智能体之间建立共生竞争关系来实现进化。

## 核心架构

### 1. 课程智能体 ($\pi_\theta$)

通过 RL 提出越来越具有挑战性的前沿任务。奖励设计旨在最大化执行者在"甜蜜点"上的不确定性时的任务难度。

**不确定性奖励**（在 $\hat{p} = 0.5$ 时最大化）：
$$R_{unc}(x; \pi_\phi) = 1 - 2|\hat{p}(x; \pi_\phi) - 0.5|$$
其中 $\hat{p}$ 是执行者的自一致性（10 个样本中多数投票的比例）。

**工具使用奖励**:
$$R_{tool}(x; \pi_\phi) = \gamma \cdot \min(N_{tool}(y), C)$$
其中 $N_{tool}(y)$ 统计工具响应标记的数量，$C=4$ 限制过度调用。

**复合奖励**:
$$R_C(x_i) = R_{format}(x_i) \cdot \max(0, (\lambda_{unc} R_{unc} + \lambda_{tool} R_{tool}) - R_{rep}(x_i))$$

### 2. 执行智能体 ($\pi_\phi$)

通过**模糊感知动态策略优化（ADPO）**学习解决任务，这是 GRPO 的扩展，能够处理多数投票产生的噪声伪标签。

**ADPO 创新点**:
1. **模糊感知优势缩放**: 降低高模糊度（低一致性）样本的权重：
   $$\tilde{A}_i(x) = \hat{A}_i \cdot s(x)$$
   其中 $s(x) = f(\hat{p}(x))$ 随自一致性增加而增加。
2. **动态信任域**: 对模糊输入放宽裁剪边界以允许探索：
   $$\epsilon_{high}(x) = \text{关于 } \hat{p}(x) 	ext{ 的减函数}$$

**ADPO 目标**:
$$\mathcal{L}_{ADPO}(\theta) = -\mathbb{E}\left[\min\left(r_i(\theta) \tilde{A}_i(x), \text{clip}(r_i(\theta), 1-\epsilon_{low}, 1+\epsilon_{high}(x)) \tilde{A}_i(x)\right)\right]$$

### 3. 多轮工具集成

执行者生成 Python 代码（```python...```），执行暂停，结果作为 ```output...``` 追加，执行者基于 [历史 + 反馈] 继续推理，直到最终答案输出为 \boxed{}。

## 实验结果

| 模型 | 数学平均 | 通用平均 |
|------|---------|---------|
| Qwen3-8B-Base | 49.2 | 34.5 |
| **+ Agent0** | **58.2** (+18%) | **42.1** (+24%) |
| Qwen3-4B-Base | 42.6 | 27.1 |
| **+ Agent0** | **52.5** (+23%) | **37.6** (+39%) |

超越了 Socratic-Zero、R-Zero 和 Absolute Zero。

## 关系

- **对比** [[zh/entities/sage-framework\|SAGE]]: Agent0 使用 2 个智能体并支持工具；SAGE 使用 4 个智能体但无工具。
- **对比** [[zh/entities/lse-framework\|LSE]]: Agent0 进化任务分布（数据）；LSE 进化 prompt 上下文（推理）。
- **基于**: GRPO、课程学习、工具增强 LLM。
- **引入**: [[zh/concepts/adpo\|ADPO]]（模糊感知动态策略优化）。
