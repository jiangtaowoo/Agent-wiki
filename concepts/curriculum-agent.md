---
title: Curriculum Agent
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, curriculum-learning, multi-agent]
sources: [raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md]
---

# Curriculum Agent

An agent whose explicit role is to generate training tasks for another agent, typically optimizing for a specific difficulty target. A central concept in [[agent0-framework]].

## Objective

Generate tasks $x$ such that the executor agent $\pi_\phi$ is challenged but not overwhelmed. In Agent0, this is formalized as maximizing uncertainty:

$$R_{unc} = 1 - 2|\hat{p} - 0.5|$$

where $\hat{p}$ is the executor's self-consistency (majority vote proportion). Perfect curriculum occurs when the executor is at 50% consistency — it knows enough to make educated guesses but not enough to be certain.

## Components

- **Uncertainty Reward:** Pushes tasks to the capability frontier.
- **Tool Use Reward:** Encourages tasks that require external tools.
- **Repetition Penalty:** Prevents generating similar tasks (BLEU-based clustering).

## Related

- [[executor-agent]] — the counterpart that solves the generated tasks.
- [[sage-framework]] — the Challenger agent plays a similar role but with quality filtering by the Critic.
- [[curriculum-learning]] — the broader ML paradigm.
