---
title: Tool-R0 Framework
created: 2026-04-15
updated: 2026-04-15
type: entity
tags: [framework, llm-agent, tool-using-agent, reinforcement-learning, zero-data, self-play]
sources: [raw/articles/arxiv-2602.21320-tool-r0.md]
---

# Tool-R0 Framework

**Paper:** [arXiv:2602.21320](https://arxiv.org/abs/2602.21320)  
**Authors:** Emre Can Acikgoz, Cheng Qian, Jonas Hübotter, Heng Ji, Dilek Hakkani-Tür, Gokhan Tur  
**Submitted:** 24 Feb 2026

## Overview

Tool-R0 addresses a fundamental bottleneck in tool-learning for LLM agents: the dependence on **human-curated task-solution pairs** and heavy supervision. This limits scalability and blocks the path toward open-ended self-evolution.

Tool-R0 trains **general-purpose tool-calling agents from scratch** using **self-play reinforcement learning** under a **zero-data assumption**.

## Core Mechanisms

### 1. Generator-Solver Co-Evolution

Initialized from the **same base LLM**, two agents co-evolve with complementary objectives:
- **Generator:** Proposes challenging tasks at the Solver's competence frontier.
- **Solver:** Learns to solve tasks via real-world tool calls.

They receive **complementary rewards**, creating a self-sustaining improvement loop.

### 2. Zero-Data Self-Play RL

No pre-existing tasks, datasets, or human annotations are required:
- The Generator synthesizes tasks.
- The Solver attempts them using available tools.
- Outcomes drive RL updates for both roles.

### 3. Curriculum Emergence

Because the Generator is rewarded for proposing tasks at the Solver's frontier, a **natural curriculum emerges**:
- Early: simple, solvable tasks.
- Later: progressively harder tasks as the Solver improves.
- This mirrors effective human pedagogical strategies without explicit curriculum design.

## Experiments

- **Benchmarks:** Multiple tool-use benchmarks
- **Key Results:**
  - **92.5%** relative improvement over the base model
  - Surpasses **fully supervised tool-calling baselines** under the same setting

## Relationships

- **Contrast with** [[agent0-framework]]: Both achieve zero-data evolution, but Agent0 focuses on math/code reasoning with curriculum-executor co-evolution, while Tool-R0 specializes in tool-calling with generator-solver self-play.
- **Contrast with** [[sage-framework]]: SAGE uses four adversarial agents for reasoning; Tool-R0 uses two cooperative agents for tool mastery.
- **Related to:** [[self-play]] — exemplifies self-play RL in the tool-learning domain.
- **Enables:** [[tool-using-agent]] training without expensive human-labeled trajectory data.
