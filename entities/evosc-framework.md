---
title: EvoSC (Self-Consolidation for Self-Evolving Agents)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [framework, llm-agent, memory, lifelong-learning]
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md]
---

# EvoSC (Self-Consolidation for Self-Evolving Agents)

**Paper:** [arXiv:2602.01966](https://arxiv.org/abs/2602.01966)  
**Authors:** Hongzhuo Yu, Fei Zhu, Guo-Sen Xie, Ling Shao  
**Institution:** UCAS-Terminus AI Lab, HKISI-CAS, Nanjing University of Science and Technology

## Overview

EvoSC addresses the "stateless" problem of LLM agents — they reset after every session and cannot accumulate knowledge. It proposes a **model-agnostic, plug-and-play framework** for evolutionary test-time learning with a **dual-memory architecture**:
1. **Non-parametric contrastive reflection** — extracts guidance from both successes and failures.
2. **Parametric self-consolidation** — distills verbose textual trajectories into compact, learnable prompt parameters.

## Core Mechanisms

### 1. Contrastive Experience Extraction

Instead of only replaying successful trajectories (like traditional textual experience replay), EvoSC retrieves both successful ($C_s$) and failed ($C_f$) dialogs.

- **Error-Prone Experience ($Exp_c$):** Uses a contrastive prompt template $P_c$ to analyze divergence between success and failure, extracting specific pitfalls and avoidance strategies.
  $$Exp_c = \text{LLM}(P_c \cup C_s \cup C_f)$$
- **Successful Experience ($Exp_s$):** Uses a success prompt template $P_s$ to abstract generalizable patterns from two distinct successful instances.
  $$Exp_s = \text{LLM}(P_s \cup C_s^{(i)} \cup C_s^{(j)})$$

Both types of extracted insights are stored in **FIFO queues** to prioritize recent lessons and prune outdated information.

### 2. Parametric Trajectory Consolidation

To avoid prompt explosion and context-window exhaustion, accumulated trajectories are compressed into a **learnable prompt** $P_\theta$ (length = 20 tokens).

- **Teacher:** Generates an expert action $A^*_{k,s}$ using many historical trajectories $E_{many}$.
- **Student:** Reconstructs the action using only a few trajectories $E_{few}$ plus the learnable prompt $P_\theta$.

**Consolidation Loss:** Minimizes token-level cross-entropy across all interaction rounds $s$:
$$\mathcal{L}_{consolid} = -\sum_{s=1}^{r} \sum_{j} \log P_\theta \left( A^*_{k,s,j} \mid P_\theta, I_k, H_{k,s-1}, A_{k,s,<j} \right)$$

### 3. Experience-Augmented Inference

At test time, the agent composes a hybrid input:
$$I_k = P_\theta \oplus P_{sys} \oplus Exp_c \oplus Exp_s \oplus C_s \oplus t_k$$

This balances implicit parametric intuition with explicit textual guidance.

## Experiments

- **Benchmark:** LifelongAgentBench (DB: 500 tasks, OS: 500 tasks, KG: 396 tasks)
- **Models:** Llama 3.1-8B-Instruct, Qwen 2.5-7B-Instruct
- **Baselines:** AWM (workflow memory), TER (textual replay), SCM (self-controlled memory), A-MEM (agentic memory)

**Key Result:** EvoSC consistently outperforms all baselines and avoids Out-of-Memory (OOM) errors that plague replay-based methods as experience count grows.

## Relationships

- **Contrast with** [[sage-framework]]: EvoSC uses a single agent with dual-memory; SAGE uses four adversarial agents.
- **Contrast with** [[agent0-framework]]: EvoSC operates from interaction history; Agent0 generates tasks from zero data.
- **Influenced by:** Human cognitive learning (explicit memory → implicit knowledge consolidation).
- **Enables:** [[lifelong-learning]] in LLM agents without linear context growth.
