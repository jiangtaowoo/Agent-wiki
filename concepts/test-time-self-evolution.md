---
title: Test-Time Self-Evolution
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, test-time-scaling, prompt-optimization]
sources: [raw/articles/learning-to-self-evolve.md]
---

# Test-Time Self-Evolution

A paradigm where a model improves its own **context** (prompt) during inference time, without updating its underlying parameters $\theta$. Central to [[lse-framework]].

## Distinction

| Type | What Changes | When | Example |
|------|-------------|------|---------|
| **Intra-episode** | Reasoning within one problem | During inference | Chain-of-thought, self-correction |
| **Inter-episode** | Context across multiple problems | Between tasks | [[lse-framework]] |
| **Parameter update** | Model weights | Training | Fine-tuning, RLHF |

Test-time self-evolution focuses on the **inter-episode, prompt-based** setting.

## Why It Matters

- Avoids catastrophic forgetting from parameter updates
- Enables rapid adaptation to new task distributions
- Allows a small model to outperform larger models by investing more computation at test time

## LSE's Approach

Treats context editing as a policy $f_\psi$ trained with RL to maximize performance improvement:
$$r = \bar{R}(c_1) - \bar{R}(c_0)$$

## Related

- [[prompt-optimization]]
- [[in-context-learning]]
- [[meta-prompting]]
