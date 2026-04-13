---
title: LSE 框架 (Learning to Self-Evolve)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [framework, llm-agent, test-time-scaling, prompt-optimization, reinforcement-learning]
lang: zh
sources: [raw/articles/learning-to-self-evolve.md]
---

# LSE 框架 (Learning to Self-Evolve)

**论文**: [arXiv:2603.18620](https://arxiv.org/abs/2603.18620)  
**作者**: Xiaoyin Chen, Canwen Xu, Yite Wang, Boyi Liu, Zhewei Yao, Yuxiong He  
**机构**: Mila / 蒙特利尔大学, Snowflake

## 概述

LSE 是一个**强化学习框架**，它显式地训练 LLM 在**测试时**改进自己的上下文。与依赖涌现推理能力的现有方法不同，LSE 将自我进化视为一种**可学习的技能**，使用单步 RL 目标和**基于改进的奖励**。

## 问题形式化

**场景**: 跨 episode、基于 prompt 的自我进化
- **Intra-episode**: 单个问题内的更新（如自我纠正）
- **Inter-episode**: 跨已完成任务的更新，将知识迁移到新问题
- **基于 prompt**: 修改上下文 $c$ 同时保持参数 $\theta$ 冻结（避免灾难性遗忘）

**目标**: 最大化 $T$ 轮内的累积奖励：
$$\sum_{t=0}^T \mathbb{E}_{x \sim X}\left[R\left(x, \pi^{(t)}(x)\right)\right]$$

其中 $\pi^{(t+1)} = f\left(\pi^{(t)}, \{(x_i, y_i, r_i)\}_{i=1}^k\right)$

## 核心方法

### 1. 树引导进化

为避免不可逆转地提交到次优路径，LSE 维护一棵**进化树** $\mathcal{G}$，每个节点存储 $(c_n, S_n, \bar{R}_n, v_n)$：上下文、性能摘要、平均 holdout 奖励、访问次数。

**UCB 选择**:
$$n^* = \arg\max_{n \in \mathcal{G}} \bar{R}_n + C\sqrt{\frac{\ln N}{v_n}}$$

其中 $N$ 是已完成轮次，$C$ 控制探索。

### 2. 学习自我进化（训练）

**关键洞察**: 多步轨迹优化成本高昂。LSE 将其简化为单步 RL，其中 $f_\psi$ 产生一次更新 $c_1 = f_\psi(c_0, S_0)$ 并接收即时奖励。

**基于改进的奖励**:
$$r_{LSE} = \bar{R}(c_1) - \bar{R}(c_0)$$

这直接激励 $f_\psi$ 产生相对于起点提升性能的编辑。

**LSE 优势**: 使用编辑前奖励作为基线：
$$A_{LSE} = \bar{R}(c_1) - \bar{R}(c_0)$$

**策略梯度**:
$$\nabla_\psi J = \mathbb{E}_{c_1 \sim f_\psi(\cdot|c_0,S_0)} \left[ A_{LSE} \nabla_\psi \log f_\psi(c_1 | c_0, S_0) \right]$$

**训练细节**:
- 生成 200 个进化 run × 20 轮 = 约 4000 个树节点
- 从树中随机采样节点作为起始上下文
- 课程式采样：优先选择改进潜力最高的节点
- On-policy 训练，4 个 epoch

## 实验结果

- **动作策略 & 自进化策略**: Qwen3-4B-Instruct
- **任务**: Text-to-SQL (BIRD)、问答 (MMLU-Redux, SuperGPQA)
- **基线**: GPT-5、Claude Sonnet 4.5、GEPA、TextGrad

**关键结果**: 经过 LSE 训练的 **4B 参数模型**在测试时自我进化任务上**超越了 GPT-5** 和 **Claude Sonnet 4.5**，且无需额外训练即可迁移指导其他模型。

## 关系

- **对比** [[zh/entities/agent0-framework\|Agent0]]: LSE 在测试时进化*上下文*（prompt）；Agent0 进化*训练数据*（课程）。
- **对比** [[zh/entities/evosc-framework\|EvoSC]]: 两者都进行测试时学习，但 LSE 使用 RL 训练显式的自进化策略，而 EvoSC 使用记忆巩固。
- **基于**: Prompt 优化、RL、MCTS/UCB 树搜索。
- **引入**: [[zh/concepts/evolution-tree\|进化树]]作为 prompt 空间的搜索机制。
