---
title: LSE (Learning to Self-Evolve)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [framework, llm-agent, test-time-scaling, prompt-optimization, reinforcement-learning]
sources: [raw/articles/learning-to-self-evolve.md]
---

# LSE (Learning to Self-Evolve)

**Paper:** [arXiv:2603.18620](https://arxiv.org/abs/2603.18620)  
**Authors:** Xiaoyin Chen, Canwen Xu, Yite Wang, Boyi Liu, Zhewei Yao, Yuxiong He  
**Institution:** Mila / University of Montreal, Snowflake

## Overview

LSE is a **reinforcement learning framework** that explicitly trains LLMs to improve their own contexts at **test time**. Unlike existing approaches that rely on emergent reasoning abilities, LSE treats self-evolution as a **learnable skill** using a single-step RL objective with **improvement-based rewards**.

## Problem Formulation

**Setting:** Inter-episode, prompt-based self-evolution
- **Intra-episode:** Updates within a single problem (e.g., self-correction)
- **Inter-episode:** Updates across completed episodes to transfer knowledge to new problems
- **Prompt-based:** Modifies context $c$ while keeping parameters $\theta$ frozen (avoids catastrophic forgetting)

**Objective:** Maximize cumulative reward over $T$ rounds:
$$\sum_{t=0}^T \mathbb{E}_{x \sim X}\left[R\left(x, \pi^{(t)}(x)\right)\right]$$

where $\pi^{(t+1)} = f\left(\pi^{(t)}, \{(x_i, y_i, r_i)\}_{i=1}^k\right)$

## Core Methodology

### 1. Tree-Guided Evolution

To avoid committing irreversibly to suboptimal paths, LSE maintains an **evolution tree** $\mathcal{G}$ where each node stores $(c_n, S_n, \bar{R}_n, v_n)$: context, performance summary, mean holdout reward, and visit count.

**UCB Selection:**
$$n^* = \arg\max_{n \in \mathcal{G}} \bar{R}_n + C\sqrt{\frac{\ln N}{v_n}}$$

where $N$ is completed rounds, $C$ controls exploration.

### 2. Learning to Self-Evolve (Training)

**Key Insight:** Multi-step trajectory optimization is costly. LSE reduces to single-step RL where $f_\psi$ produces one update $c_1 = f_\psi(c_0, S_0)$ and receives immediate reward.

**Improvement-Based Reward:**
$$r_{LSE} = \bar{R}(c_1) - \bar{R}(c_0)$$

This directly incentivizes $f_\psi$ to produce edits that improve performance relative to the starting point.

**LSE Advantage:** Uses pre-edit reward as baseline:
$$A_{LSE} = \bar{R}(c_1) - \bar{R}(c_0)$$

**Policy Gradient:**
$$\nabla_\psi J = \mathbb{E}_{c_1 \sim f_\psi(\cdot|c_0,S_0)} \left[ A_{LSE} \nabla_\psi \log f_\psi(c_1 | c_0, S_0) \right]$$

**Training Details:**
- Generate 200 evolution runs × 20 rounds = ~4,000 tree nodes
- Randomly sample nodes from tree as starting contexts
- Curriculum: Preferentially sample nodes with highest improvement potential
- On-policy training, 4 epochs

## Experimental Results

- **Action Policy & Self-Evolving Policy:** Qwen3-4B-Instruct
- **Tasks:** Text-to-SQL (BIRD), Question Answering (MMLU-Redux, SuperGPQA)
- **Baselines:** GPT-5, Claude Sonnet 4.5, GEPA, TextGrad

**Key Result:** A **4B-parameter model** trained with LSE outperforms **GPT-5** and **Claude Sonnet 4.5** on test-time self-evolution tasks, and can transfer to guide other models without additional training.

## Relationships

- **Contrast with** [[agent0-framework]]: LSE evolves the *context* (prompt) at test time; Agent0 evolves the *training data* (curriculum).
- **Contrast with** [[evosc-framework]]: Both do test-time learning, but LSE uses RL to train an explicit self-evolution policy, while EvoSC uses memory consolidation.
- **Builds on:** Prompt optimization, RL, MCTS/UCB tree search.
- **Introduces:** [[evolution-tree]] as a search mechanism for prompt space.
