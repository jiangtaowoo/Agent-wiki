---
title: ADPO (Ambiguity-Dynamic Policy Optimization)
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, reinforcement-learning]
sources: [raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md]
---

# ADPO (Ambiguity-Dynamic Policy Optimization)

An RL algorithm introduced in [[agent0-framework]] that extends GRPO to handle **noisy pseudo-labels** from self-consistency majority voting.

## Problem

In self-evolution settings, ground-truth labels are unavailable. The executor uses majority voting across $k$ samples as a pseudo-label. When self-consistency $\hat{p}$ is low, this label is noisy and can mislead policy optimization.

## Solutions

### 1. Ambiguity-Aware Advantage Scaling

Down-weight high-ambiguity (low consistency) samples:
$$\tilde{A}_i(x) = \hat{A}_i \cdot s(x)$$
where $s(x) = f(\hat{p}(x))$ is an increasing function of self-consistency.

### 2. Dynamic Trust Regions

Standard PPO/GRPO uses a fixed clipping bound $\epsilon$. ADPO makes the upper bound a function of ambiguity:
$$\epsilon_{high}(x) = \text{decreasing function of } \hat{p}(x)$$

For ambiguous inputs (low $\hat{p}$), the trust region is widened to allow more exploration of low-probability reasoning paths. For clear inputs (high $\hat{p}$), the region is tightened to prevent divergence from the reliable pseudo-label.

## Objective

$$\mathcal{L}_{ADPO}(\theta) = -\mathbb{E}\left[\min\left(r_i(\theta) \tilde{A}_i(x), \text{clip}(r_i(\theta), 1-\epsilon_{low}, 1+\epsilon_{high}(x)) \tilde{A}_i(x)\right)\right]$$

## Related

- [[grpo]] — the base algorithm ADPO extends.
- [[ppo]] — the foundational policy gradient method.
