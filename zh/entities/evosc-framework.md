---
title: EvoSC 框架 (Self-Consolidation for Self-Evolving Agents)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [framework, llm-agent, memory, lifelong-learning]
lang: zh
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md]
---

# EvoSC 框架 (Self-Consolidation for Self-Evolving Agents)

**论文**: [arXiv:2602.01966](https://arxiv.org/abs/2602.01966)  
**作者**: Hongzhuo Yu, Fei Zhu, Guo-Sen Xie, Ling Shao  
**机构**: UCAS-Terminus AI Lab, HKISI-CAS, 南京理工大学

## 概述

EvoSC 针对 LLM 智能体的"无状态"问题——每次会话结束后就会重置，无法积累知识。它提出了一个**模型无关、即插即用的框架**，用于演化式测试时学习，采用**双记忆架构**：
1. **非参数化对比式反思** — 从成功和失败中提取经验教训。
2. **参数化自我巩固** — 将冗长的文本轨迹蒸馏为紧凑、可学习的 prompt 参数。

## 核心机制

### 1. 对比式经验提取

与传统方法只重放成功轨迹不同，EvoSC 同时检索成功对话 ($C_s$) 和失败对话 ($C_f$)。

- **易错经验 ($Exp_c$)**: 使用对比式 prompt 模板 $P_c$ 分析成功与失败的分歧，提取具体陷阱和避免策略。
  $$Exp_c = \text{LLM}(P_c \cup C_s \cup C_f)$$
- **成功经验 ($Exp_s$)**: 使用成功 prompt 模板 $P_s$ 从两个不同的成功案例中抽象通用模式。
  $$Exp_s = \text{LLM}(P_s \cup C_s^{(i)} \cup C_s^{(j)})$$

两种经验都存储在 **FIFO 队列**中，优先保留最新经验，淘汰过时信息。

### 2. 参数化轨迹巩固

为避免 prompt 爆炸和上下文窗口耗尽，积累的轨迹被压缩为**可学习的 prompt** $P_\theta$（长度 = 20 个 token）。

- **教师模型**: 使用大量历史轨迹 $E_{many}$ 生成专家动作 $A^*_{k,s}$。
- **学生模型**: 仅使用少量轨迹 $E_{few}$ 加上可学习 prompt $P_\theta$ 重构动作。

**巩固损失**: 最小化所有交互轮次 $s$ 的 token 级交叉熵：
$$\mathcal{L}_{consolid} = -\sum_{s=1}^{r} \sum_{j} \log P_\theta \left( A^*_{k,s,j} \mid P_\theta, I_k, H_{k,s-1}, A_{k,s,<j} \right)$$

### 3. 增强推理

测试时，智能体的输入为多个信息源的组合：
$$I_k = P_\theta \oplus P_{sys} \oplus Exp_c \oplus Exp_s \oplus C_s \oplus t_k$$

这种设计平衡了隐式参数化直觉与显式文本指导。

## 实验

- **基准**: LifelongAgentBench（DB: 500 任务, OS: 500 任务, KG: 396 任务）
- **模型**: Llama 3.1-8B-Instruct, Qwen 2.5-7B-Instruct
- **基线**: AWM（工作流记忆）, TER（文本重放）, SCM（自控记忆）, A-MEM（智能体记忆）

**关键结果**: EvoSC 始终优于所有基线，并避免了基于重放的方法在经验增长时出现的 OOM 错误。

## 关系

- **对比** [[zh/entities/sage-framework\|SAGE]]: EvoSC 使用单智能体双记忆；SAGE 使用四个对抗智能体。
- **对比** [[zh/entities/agent0-framework\|Agent0]]: EvoSC 基于交互历史运作；Agent0 从零数据生成任务。
- **受启发于**: 人类认知学习（显式记忆 → 隐式知识巩固）。
- **使能**: [[zh/concepts/self-evolving-agent\|自进化智能体]]的终身学习，无需线性上下文增长。
