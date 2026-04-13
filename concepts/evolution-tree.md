---
title: Evolution Tree
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, test-time-scaling]
sources: [raw/articles/learning-to-self-evolve.md]
---

# Evolution Tree

A search structure introduced in [[lse-framework]] to explore the space of possible prompt contexts without committing irreversibly to suboptimal paths.

## Structure

Each node in the tree $\mathcal{G}$ stores:
- $c_n$: the prompt context
- $S_n$: performance summary
- $\bar{R}_n$: mean holdout reward
- $v_n$: visit count

## Selection

Uses **UCB1** (Upper Confidence Bound) to balance exploitation and exploration:
$$n^* = \arg\max_{n \in \mathcal{G}} \bar{R}_n + C\sqrt{\frac{\ln N}{v_n}}$$

## Purpose

Prompt optimization is non-convex and sequential edits can compound errors. The tree maintains multiple promising contexts in parallel, allowing the agent to backtrack to better nodes if a particular evolutionary path degrades performance.

## Related

- [[monte-carlo-tree-search]]
- [[ucb]]
- [[test-time-self-evolution]]
