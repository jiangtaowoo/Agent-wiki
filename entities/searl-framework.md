---
title: SEARL Framework
created: 2026-04-15
updated: 2026-04-15
type: entity
tags: [framework, llm-agent, tool-using-agent, reinforcement-learning, memory]
sources: [raw/articles/arxiv-2604.07791-searl.md]
---

# SEARL Framework

**Paper:** [arXiv:2604.07791](https://arxiv.org/abs/2604.07791)  
**Authors:** Xinshun Feng, Xinhao Song, Lijun Li, Gongshen Liu, Jing Shao  
**Venue:** ACL 2026

## Overview

SEARL (Joint Optimization of **Policy** and **Tool Graph Memory**) tackles two barriers to practical self-evolving agents:
1. **Resource intensity** — prior methods depend on large LLMs or multi-agent systems.
2. **Reward sparsity** — outcome-based rewards provide feedback only at task completion.

SEARL introduces a **structured experience memory** that integrates planning with execution, enabling generalization and denser rewards for efficient learning.

## Core Mechanisms

### 1. Tool Graph Memory

Instead of storing raw interaction trajectories, SEARL constructs a **graph-structured memory** over tools and their usage patterns. This memory serves as a state abstraction that:
- Captures tool relationships and reuse patterns.
- Generalizes across analogous task contexts.
- Reduces memory footprint for resource-constrained deployment.

### 2. Inter-Trajectory Correlation

SEARL exploits **correlations across trajectories** to densify reward signals:
- Partial successes in similar contexts provide intermediate learning signals.
- Tool reuse patterns generate auxiliary objectives beyond final outcomes.

### 3. Joint Policy-Memory Optimization

The policy and tool graph memory are trained jointly:
- The policy learns to plan and execute using the memory.
- The memory updates based on successful and failed tool invocations.

## Experiments

- **Domains:** Knowledge reasoning and mathematics tasks
- **Focus:** Practical, efficient learning in constrained-resource settings
- **Key Advantage:** Achieves meaningful learning gains without requiring large-scale LLMs or multi-agent infrastructures.

## Relationships

- **Contrast with** [[sage-framework]]: SAGE uses four specialized agents; SEARL uses a single agent with structured memory.
- **Contrast with** [[tool-r0-framework]]: Tool-R0 trains from zero data via self-play; SEARL assumes some historical trajectories and focuses on memory-efficient learning.
- **Enables:** [[tool-using-agent]] deployment in resource-constrained environments.
- **Related to:** [[parametric-consolidation]] — both aim to compress experience into efficient representations.
