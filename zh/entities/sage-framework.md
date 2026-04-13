---
title: SAGE 框架 (Multi-Agent Self-Evolution for LLM Reasoning)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [framework, multi-agent, self-play, curriculum-learning, reasoning]
lang: zh
sources: [raw/articles/sage-multi-agent-self-evolution-for-llm-reasoning.md]
---

# SAGE 框架 (Multi-Agent Self-Evolution for LLM Reasoning)

**论文**: [arXiv:2603.15255](https://arxiv.org/abs/2603.15255)  
**作者**: Yulin Peng, Xinxin Zhu, Chenxing Wei, Nianbo Zeng, Leilei Wang, Ying Tiffany He, F. Richard Yu  
**机构**: 深圳大学, 广东人工智能与数字经济实验室, Carleton University

## 概述

SAGE（**Self-evolving Agents for Generalized reasoning Evolution**）是一个闭环多智能体框架，使 LLM 能够在**可验证领域**（数学和编程）中通过仅**少量种子数据（约 500 个示例）**实现自我进化。它将同一个 LLM  backbone 实例化为四个专业智能体，进行对抗性和协作性交互。

## 四个智能体

| 智能体 | 角色 | 功能 |
|--------|------|------|
| **挑战者** ($\pi_c$) | 任务生成器 | 从参考种子项生成新的可验证问题 $(q, v)$，当解题者失败时获得难度奖励。 |
| **规划者** ($\pi_p$) | 策略家 | 为给定问题 $q$ 生成结构化的多步计划 $p$。 |
| **解题者** ($\pi_s$) | 执行者 | 基于 $q$ 和验证后的计划 $p$ 生成最终答案 $a$。通过基于验证器的正确性进行优化。 |
| **评判者** ($\pi_{cr}$) | 质量守门员 | 分配质量分数（问题 $s_q$、计划 $s_p$），并强制执行格式合规以过滤低质量输出。 |

挑战者和解题者对抗式协同进化：解题者因验证正确性获得奖励，而挑战者因难度（解题者失败率）获得奖励，推动课程向更难但可解的任务发展。

## 训练方法

### 奖励设计

- **格式奖励 ($r_f$)**: 软分数 $[0, 1]$，强制执行必需的 XML 标签。
- **挑战者复合奖励**:
  $$r_c(q, v) = \begin{cases} \frac{1}{3}s_q + \frac{1}{3}r_d + \frac{1}{3}r_f & \text{若 } s_q \geq \alpha \text{ 且通过验证器} \\ \frac{1}{2}s_q + \frac{1}{2}r_f & \text{否则} \end{cases}$$
  其中 $r_d = 1 - \bar{s}_{gt}$（难度奖励），$\alpha = 0.7$。
- **规划者奖励**: $r_p = \lambda_{plan} \cdot s_p + \lambda_f \cdot r_f$
- **解题者奖励**: $r_s = w_p \cdot \tilde{s}_p + w_c \cdot s_{gt} + w_f \cdot r_f$
  其中 $\tilde{s}_p = s_p$ 若 $s_p \geq \beta$（0.3），否则为 0。

每个迭代中，所有智能体都基于各自的奖励进行联合更新。

## 实验结果

- **Qwen-2.5-7B**: LiveCodeBench 提升 **+8.9%**，OlympiadBench 提升 **+10.7%**
- **Qwen-3-4B**: LiveCodeBench 从 **21.5% → 30.6%** (+9.1%)
- 在 3B、7B 和 4B 规模上都有一致的提升，且 OOD 泛化能力强

## 关系

- **对比** [[zh/entities/evosc-framework\|EvoSC]]: SAGE 使用多智能体对抗式协同进化；EvoSC 使用单智能体记忆巩固。
- **对比** [[zh/entities/agent0-framework\|Agent0]]: 两者都使用课程生成，但 SAGE 专注于可验证的数学/代码，有 4 个角色；Agent0 使用 2 个智能体并集成工具。
- **基于**: Self-play（SPIRAL）、基于验证器的 RL、课程学习。
- **使能**: 在可验证推理任务中，用极少种子数据生成高质量合成数据。
