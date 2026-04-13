---
title: Parametric Consolidation
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, memory, prompt-optimization]
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md]
---

# Parametric Consolidation

A mechanism from [[evosc-framework]] that distills non-parametric textual experiences into a compact, **learnable prompt** $P_\theta$ to avoid context-window exhaustion.

## Problem

Continually accumulating textual experiences linearly increases retrieval time and eventually exhausts the LLM's context window, causing OOM errors and performance degradation.

## Solution

Learn a short prompt vector (20 tokens) that encodes the "essence" of many historical trajectories.

- **Teacher:** Uses many historical trajectories $E_{many}$ to generate expert actions.
- **Student:** Uses only a few trajectories $E_{few}$ plus $P_\theta$ to reconstruct the same expert actions.
- **Loss:** Token-level cross-entropy minimization between teacher and student outputs.

This mimics human cognitive consolidation — converting explicit episodic memory into implicit procedural intuition.

## Trade-offs

| Aspect | Textual Replay | Parametric Consolidation |
|--------|---------------|--------------------------|
| Scalability | Poor (linear growth) | Good (fixed size) |
| Interpretability | High | Low |
| Fine-grained detail | Preserved | Compressed/lossy |

## Related

- [[prompt-optimization]]
- [[soft-prompt]]
- [[knowledge-distillation]]
