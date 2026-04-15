---
title: Mem²Evolve Framework
created: 2026-04-15
updated: 2026-04-15
type: entity
tags: [framework, llm-agent, multi-agent, tool-using-agent, memory, self-play]
sources: [raw/articles/arxiv-2604.10923-mem2evolve.md]
---

# Mem²Evolve Framework

**Paper:** [arXiv:2604.10923](https://arxiv.org/abs/2604.10923)  
**Authors:** Zihao Cheng, Zeming Liu, Yingyu Shan, Xinyi Wang, Xiangrong Zhu, Yunpu Ma, Hongru Wang, Yuhang Guo, Wei Lin, Yunhong Wang  
**Venue:** ACL 2026 Main

## Overview

Mem²Evolve addresses a critical limitation in self-evolving agents: the isolation between **experience accumulation** and **capability expansion** (dynamic creation of tools/expert agents). Existing frameworks either remain bounded by static toolsets or generate new assets without experiential guidance, leading to unstable evolution.

Mem²Evolve proposes a **co-evolutionary paradigm** that unifies:
1. **Capability Expansion** — dynamically generating tools and expert agents.
2. **Experience Distillation** — accumulating and reusing operational knowledge.

## Core Mechanisms

### 1. Dual-Memory Architecture

- **Experience Memory:** Stores accumulated operational knowledge from past task executions.
- **Asset Memory:** Houses dynamically created tools and expert agents.

These two memory systems are tightly coupled: experience guides asset creation, and new assets generate novel experiences.

### 2. Experience-Guided Capability Expansion

Rather than creating tools from scratch for each new task, Mem²Evolve leverages its Experience Memory to guide the generation process. This avoids the cold-start problem and enables cross-task generalization of creation strategies.

### 3. Asset-Enhanced Experience Distillation

Newly created assets (tools/agents) are deployed to solve tasks, generating fresh experiences that are distilled back into Experience Memory. This creates a **virtuous co-evolutionary cycle**.

## Experiments

- **Coverage:** 6 task categories across 8 benchmarks
- **Key Results:**
  - **+18.53%** over standard LLMs
  - **+11.80%** over experience-only agents
  - **+6.46%** over asset-creation-only agents

## Relationships

- **Contrast with** [[agent0-framework]]: Both achieve zero-data evolution, but Mem²Evolve explicitly co-evolves tools/agents alongside experience.
- **Contrast with** [[evosc-framework]]: EvoSC focuses on memory consolidation within a single agent; Mem²Evolve expands the agent's capability boundary through dynamic asset generation.
- **Enables:** [[self-evolving-agent]] paradigms that break free from static tool assumptions.
- **Related to:** [[curriculum-agent]] — both involve dynamic task generation, but Mem²Evolve generates *assets* rather than just tasks.
