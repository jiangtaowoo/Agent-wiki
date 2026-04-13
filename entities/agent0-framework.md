---
title: Agent0 (Self-Evolving Agents from Zero Data)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [framework, llm-agent, zero-data, tool-using-agent, curriculum-learning, reinforcement-learning]
sources: [raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md]
---

# Agent0 (Self-Evolving Agents from Zero Data)

**Paper:** [arXiv:2511.16043](https://arxiv.org/abs/2511.16043)  
**Authors:** Peng Xia, Kaide Zeng, Jiaqi Liu, Can Qin, Fang Wu, Yiyang Zhou, Caiming Xiong, Huaxiu Yao  
**Institution:** UNC-Chapel Hill, Salesforce Research, Stanford University  
**Code:** https://github.com/aiming-lab/Agent0

## Overview

Agent0 is a **fully autonomous, data-free framework** that evolves high-performing LLM agents through **multi-step co-evolution** and **seamless tool integration**. It eliminates dependency on human-curated data by establishing a symbiotic competition between two agents initialized from the same base LLM.

## Core Architecture

### 1. Curriculum Agent ($\pi_\theta$)

Proposes increasingly challenging frontier tasks via RL. The reward is designed to maximize task difficulty at the "sweet spot" where the Executor is uncertain.

**Uncertainty Reward** (maximized at $\hat{p} = 0.5$):
$$R_{unc}(x; \pi_\phi) = 1 - 2|\hat{p}(x; \pi_\phi) - 0.5|$$
where $\hat{p}$ is the executor's self-consistency (majority voting proportion among $k=10$ samples).

**Tool Use Reward:**
$$R_{tool}(x; \pi_\phi) = \gamma \cdot \min(N_{tool}(y), C)$$
where $N_{tool}(y)$ counts tool response markers and $C=4$ caps excessive calls.

**Composite Reward:**
$$R_C(x_i) = R_{format}(x_i) \cdot \max(0, (\lambda_{unc} R_{unc} + \lambda_{tool} R_{tool}) - R_{rep}(x_i))$$

### 2. Executor Agent ($\pi_\phi$)

Learns to solve tasks via **Ambiguity-Dynamic Policy Optimization (ADPO)**, an extension of GRPO that handles noisy pseudo-labels from majority voting.

**ADPO Innovations:**
1. **Ambiguity-Aware Advantage Scaling:** Down-weights high-ambiguity (low consistency) samples:
   $$\tilde{A}_i(x) = \hat{A}_i \cdot s(x)$$
   where $s(x) = f(\hat{p}(x))$ increases with self-consistency.
2. **Dynamic Trust Regions:** Relaxes clipping bounds for ambiguous inputs to allow exploration:
   $$\epsilon_{high}(x) = \text{decreasing function of } \hat{p}(x)$$

**ADPO Objective:**
$$\mathcal{L}_{ADPO}(\theta) = -\mathbb{E}\left[\min\left(r_i(\theta) \tilde{A}_i(x), \text{clip}(r_i(\theta), 1-\epsilon_{low}, 1+\epsilon_{high}(x)) \tilde{A}_i(x)\right)\right]$$

### 3. Multi-Turn Tool Integration

The executor generates Python code (```python...```), execution pauses, result is appended as ```output...```, and the executor continues conditioning on [history + feedback] until final answer in \boxed{}.

## Experimental Results

| Model | Math AVG | General AVG |
|-------|----------|-------------|
| Qwen3-8B-Base | 49.2 | 34.5 |
| **+ Agent0** | **58.2** (+18%) | **42.1** (+24%) |
| Qwen3-4B-Base | 42.6 | 27.1 |
| **+ Agent0** | **52.5** (+23%) | **37.6** (+39%) |

Outperforms Socratic-Zero, R-Zero, and Absolute Zero.

## Relationships

- **Contrast with** [[sage-framework]]: Agent0 uses 2 agents with tools; SAGE uses 4 agents without tools.
- **Contrast with** [[lse-framework]]: Agent0 evolves task distributions (data); LSE evolves prompt contexts (inference).
- **Builds on:** GRPO, curriculum learning, tool-augmented LLMs.
- **Introduces:** [[adpo]] (Ambiguity-Dynamic Policy Optimization).
