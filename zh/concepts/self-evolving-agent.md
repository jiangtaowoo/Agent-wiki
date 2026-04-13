---
title: 自进化智能体
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [llm-agent, lifelong-learning, continual-learning, chinese]
lang: zh
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md, raw/articles/sage-multi-agent-self-evolution-for-llm-reasoning.md, raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md, raw/articles/learning-to-self-evolve.md, raw/articles/self-evolving-embodied-ai.md]
---

# 自进化智能体

**自进化智能体**是一种能够通过交互、反馈和内部重构自主提升自身能力的智能系统，无需持续的人工监督或大规模整理数据集。

## 核心特征

1. **自主性**: 改进由智能体自身驱动，而非外部训练者
2. **连续性**: 学习跨 episode/任务发生，不仅限于单次会话
3. **反馈驱动**: 利用可验证奖励、环境反馈或自一致性信号
4. **记忆/状态积累**: 随时间维持和更新知识、技能或上下文

## 主要技术路线

| 路线 | 代表工作 | 核心思想 |
|------|---------|---------|
| **记忆巩固** | [[zh/entities/evosc-framework\|EvoSC]] | 将经验压缩为参数化/非参数化记忆 |
| **多智能体协同进化** | [[zh/entities/sage-framework\|SAGE]] | 对抗智能体生成课程并解决问题 |
| **课程协同进化** | [[zh/entities/agent0-framework\|Agent0]] | 两个智能体从零数据协同进化任务和解决方案 |
| **测试时上下文进化** | [[zh/entities/lse-framework\|LSE]] | RL 训练的策略在推理时修改 prompt 上下文 |
| **具身全栈进化** | [[zh/entities/self-evolving-embodied-ai-survey\|具身智能综述]] | 记忆+任务+环境+身体+模型共进化 |

## 关键区分

- **自进化 vs. 自我纠正**: 自我纠正在*单次问题内*发生；自进化在*跨 episode*发生，将知识迁移到未来问题
- **自进化 vs. 微调**: 微调用人类数据改变模型参数；自进化可能只自主改变 prompt、记忆或训练数据
