---
title: SAGE (Multi-Agent Self-Evolution for LLM Reasoning)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [framework, multi-agent, self-play, curriculum-learning, reasoning]
sources: [raw/articles/sage-multi-agent-self-evolution-for-llm-reasoning.md]
---

# SAGE (Multi-Agent Self-Evolution for LLM Reasoning)

**Paper:** [arXiv:2603.15255](https://arxiv.org/abs/2603.15255)  
**Authors:** Yulin Peng, Xinxin Zhu, Chenxing Wei, Nianbo Zeng, Leilei Wang, Ying Tiffany He, F. Richard Yu  
**Institution:** Shenzhen University, Guangdong Laboratory of AI and Digital Economy, Carleton University

## Overview

SAGE (**Self-evolving Agents for Generalized reasoning Evolution**) is a closed-loop, multi-agent framework that enables LLMs to self-evolve in **verifiable domains** (mathematics and coding) using only a **minimal seed set (~500 examples)**. It instantiates four specialized agents from a **shared LLM backbone** that interact adversarially and collaboratively.

## The Four Agents

| Agent | Role | Function |
|-------|------|----------|
| **Challenger** ($\pi_c$) | Task Generator | Generates new verifiable problems $(q, v)$ from reference seed items, rewarded for difficulty when the Solver fails. |
| **Planner** ($\pi_p$) | Strategist | Produces a structured multi-step plan $p$ for a given question $q$. |
| **Solver** ($\pi_s$) | Executor | Generates final answers $a$ based on $q$ and the verified plan $p$. Optimized via verifier-based correctness. |
| **Critic** ($\pi_{cr}$) | Quality Gatekeeper | Assigns quality scores ($s_q$ for questions, $s_p$ for plans) and enforces format compliance to filter low-quality outputs. |

The Challenger and Solver co-evolve adversarially: the Solver is rewarded for verified correctness, while the Challenger is rewarded for difficulty (Solver failure rate), pushing the curriculum toward harder yet solvable tasks.

## Training Methodology

### Reward Design

- **Format Reward ($r_f$):** Soft score in $[0, 1]$ enforcing required XML tags.
- **Challenger Composite Reward:**
  $$r_c(q, v) = \begin{cases} \frac{1}{3}s_q + \frac{1}{3}r_d + \frac{1}{3}r_f & \text{if } s_q \geq \alpha \text{ and verifier valid} \\ \frac{1}{2}s_q + \frac{1}{2}r_f & \text{otherwise} \end{cases}$$
  where $r_d = 1 - \bar{s}_{gt}$ (difficulty reward) and $\alpha = 0.7$.
- **Planner Reward:** $r_p = \lambda_{plan} \cdot s_p + \lambda_f \cdot r_f$
- **Solver Reward:** $r_s = w_p \cdot \tilde{s}_p + w_c \cdot s_{gt} + w_f \cdot r_f$
  where $\tilde{s}_p = s_p$ if $s_p \geq \beta$ (0.3), else 0.

All agents are jointly updated each iteration using their respective rewards.

## Experimental Results

- **Qwen-2.5-7B:** **+8.9%** on LiveCodeBench, **+10.7%** on OlympiadBench
- **Qwen-3-4B:** LiveCodeBench improved from **21.5% → 30.6%** (+9.1%)
- Consistent gains across 3B, 7B, and 4B scales with strong OOD generalization

## Relationships

- **Contrast with** [[evosc-framework]]: SAGE uses multi-agent adversarial co-evolution; EvoSC uses single-agent memory consolidation.
- **Contrast with** [[agent0-framework]]: Both use curriculum generation, but SAGE focuses on verifiable math/code with 4 roles, while Agent0 uses 2 agents with tool integration.
- **Builds on:** Self-play (SPIRAL), verifier-based RL, and curriculum learning.
- **Enables:** High-quality synthetic data generation for reasoning tasks with minimal seed data.
