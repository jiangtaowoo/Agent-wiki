---
title: Contrastive Experience Extraction
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, memory, llm-agent]
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md]
---

# Contrastive Experience Extraction

A technique introduced in [[evosc-framework]] where an LLM agent explicitly analyzes the divergence between **successful** and **failed** trajectories to extract pedagogical insights.

## Motivation

Traditional experience replay methods (e.g., TER, AWM) only retrieve successful past trajectories. This misses the valuable information embedded in failures — knowing *what not to do* and *why* is often as important as knowing what works.

## Mechanism

Given a successful dialog $C_s$ and a failed dialog $C_f$:

- **Error-Prone Experience:** $Exp_c = \text{LLM}(P_c \cup C_s \cup C_f)$
  - Extracts specific pitfalls, error patterns, and avoidance strategies.
- **Successful Experience:** $Exp_s = \text{LLM}(P_s \cup C_s^{(i)} \cup C_s^{(j)})$
  - Abstracts generalizable success patterns by comparing two distinct successful instances.

Both are stored in FIFO queues, keeping only the most relevant recent experiences.

## Relationship to Other Techniques

- **Contrast with RAG:** RAG retrieves facts; contrastive experience extraction retrieves *causal explanations* of success vs. failure.
- **Used by:** [[evosc-framework]]
- **Related to:** Self-reflection, error analysis, case-based reasoning.
