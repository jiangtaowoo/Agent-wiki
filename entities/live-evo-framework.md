---
title: Live-Evo Framework
created: 2026-04-15
updated: 2026-04-15
type: entity
tags: [framework, llm-agent, memory, lifelong-learning, continual-learning]
sources: [raw/articles/arxiv-2602.02369-live-evo.md]
---

# Live-Evo Framework

**Paper:** [arXiv:2602.02369](https://arxiv.org/abs/2602.02369)  
**Authors:** Yaolun Zhang, Yiran Wu, Yijiong Yu, Qingyun Wu, Huazheng Wang  
**Code:** [github.com/ag2ai/Live-Evo](https://github.com/ag2ai/Live-Evo)

## Overview

Live-Evo tackles the brittleness of existing self-evolving memory systems, which are typically validated on **static train/test splits** rather than true online learning scenarios. Under real distribution shift and continuous feedback, these batch-trained systems fail to adapt.

Live-Evo is an **online self-evolving memory system** that learns from a continuous stream of incoming data over time.

## Core Mechanisms

### 1. Dual-Bank Memory Decoupling

Live-Evo separates memory into two complementary banks:
- **Experience Bank:** Stores raw interaction records — *what happened*.
- **Meta-Guideline Bank:** Stores compiled, task-adaptive guidelines — *how to use it*.

For each new task, the system retrieves relevant experiences and compiles adaptive guidelines tailored to that task's context.

### 2. Dynamic Experience Weighting

Experiences are not treated equally. Live-Evo maintains **dynamic weights** updated continuously from feedback:
- **Reinforcement:** Helpful experiences gain weight and are retrieved more frequently.
- **Decay:** Misleading or stale experiences are down-weighted and gradually forgotten.

This mimics human memory consolidation and enables genuine adaptation under distribution shift.

### 3. Online Learning from Streams

Unlike prior work that folds static benchmarks to simulate online learning, Live-Evo is explicitly designed for:
- Continuous data arrival.
- Non-stationary task distributions.
- Long-horizon deployment.

## Experiments

- **Benchmark:** Live Prophet Arena over a **10-week horizon**
- **Key Results:**
  - **+20.8%** improvement in Brier score
  - **+12.9%** increase in market returns
- **Transfer:** Consistent gains on deep-research benchmarks

## Relationships

- **Contrast with** [[evosc-framework]]: EvoSC consolidates experience into parametric prompts; Live-Evo maintains explicit, weighted experience banks for online adaptation.
- **Related to:** [[test-time-self-evolution]] — both modify behavior at inference time, but Live-Evo does so through memory evolution rather than prompt search.
- **Enables:** [[lifelong-learning]] and [[continual-learning]] in deployed agent systems.
- **Related to:** [[curriculum-agent]] — both handle non-stationary distributions, but Live-Evo focuses on memory adaptation rather than task generation.
