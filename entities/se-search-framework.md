---
title: SE-Search Framework
created: 2026-04-15
updated: 2026-04-15
type: entity
tags: [framework, llm-agent, tool-using-agent, memory, reinforcement-learning, reasoning]
sources: [raw/articles/arxiv-2603.03293-se-search.md]
---

# SE-Search Framework

**Paper:** [arXiv:2603.03293](https://arxiv.org/abs/2603.03293)  
**Authors:** Jian Li, Yizhang Jin, Dongqi Liu, Hang Ding, Jiafu Wu, Dongsheng Chen, Yunhang Shen, Yulei Qin, Ying Tai, Chengjie Wang, Xiaotong Yuan, Yabiao Wang  
**Submitted:** 6 Feb 2026

## Overview

SE-Search (Self-Evolving Search) reframes retrieval-augmented generation as an **autonomous, multi-turn information-seeking agent** that learns to improve its own search behavior online. It addresses two core problems in search agents:
1. **Noise accumulation** — irrelevant documents clutter the agent's context.
2. **Sparse RL signals** — end-of-episode rewards provide insufficient training guidance.

## Core Mechanisms

### 1. Think-Search-Memorize Strategy

SE-Search operates in a three-step loop:
- **Think:** Analyze what evidence is needed.
- **Search:** Retrieve candidate documents.
- **Memorize:** Filter and retain only salient evidence, discarding irrelevant content.

This maintains a **purified working memory** rather than accumulating all retrieved documents.

### 2. Atomic Query Training

Search queries are decomposed into **atomic, shorter sub-queries**:
- Increases query diversity.
- Improves precision of evidence acquisition.
- Reduces noise in retrieved results.

### 3. Dense Reward Design

Instead of sparse task-completion rewards, SE-Search employs **fine-grained, step-level rewards**:
- Rewards quality of individual search actions.
- Provides continuous feedback throughout the multi-turn search process.
- Dramatically accelerates RL training convergence.

## Experiments

- **Benchmarks:** Single-hop and multi-hop question answering
- **Model:** SE-Search-3B
- **Key Results:**
  - **+10.8** absolute points over strong baselines
  - **+33.8%** relative improvement over Search-R1

## Relationships

- **Contrast with** [[lse-framework]]: LSE evolves prompts via tree search; SE-Search evolves search behavior via memory and dense rewards.
- **Related to:** [[test-time-self-evolution]] — both improve agent behavior at inference time, but SE-Search focuses specifically on information retrieval.
- **Enables:** [[tool-using-agent]] capabilities where the tool is a search engine or knowledge base.
- **Related to:** [[evosc-framework]] — both employ memory filtering mechanisms, though EvoSC uses contrastive extraction while SE-Search uses think-search-memorize purification.
