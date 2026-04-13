---
title: Self-Evolving Agent
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [llm-agent, lifelong-learning, continual-learning]
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md, raw/articles/sage-multi-agent-self-evolution-for-llm-reasoning.md, raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md, raw/articles/learning-to-self-evolve.md, raw/articles/self-evolving-embodied-ai.md]
---

# Self-Evolving Agent

A **self-evolving agent** is an intelligent system that can autonomously improve its capabilities over time through interaction, feedback, and internal restructuring, without requiring continuous human supervision or large-scale curated datasets.

## Core Characteristics

1. **Autonomy:** Improvement is driven by the agent itself, not external trainers.
2. **Continuity:** Learning happens across episodes/tasks, not just within a single session.
3. **Feedback-driven:** Uses verifiable rewards, environmental feedback, or self-consistency signals.
4. **Memory/State accumulation:** Maintains and updates knowledge, skills, or contexts over time.

## Major Technical Routes

| Route | Representative Work | Core Idea |
|-------|---------------------|-----------|
| **Memory Consolidation** | [[evosc-framework]] | Compress experience into parametric/non-parametric memory |
| **Multi-Agent Co-evolution** | [[sage-framework]] | Adversarial agents generate curriculum and solve problems |
| **Curriculum Co-evolution** | [[agent0-framework]] | Two agents co-evolve tasks and solutions from zero data |
| **Test-Time Context Evolution** | [[lse-framework]] | RL-trained policy modifies prompt context at inference |
| **Embodied Full-Stack Evolution** | [[self-evolving-embodied-ai-survey]] | Memory + Task + Environment + Embodiment + Model co-evolve |

## Key Distinctions

- **Self-evolution vs. Self-correction:** Self-correction happens *intra-episode* (fixing a single mistake); self-evolution happens *inter-episode* (transferring knowledge to future problems).
- **Self-evolution vs. Fine-tuning:** Fine-tuning changes model parameters with human data; self-evolution may only change prompts, memory, or training data autonomously.

## Related Concepts

- [[lifelong-learning]]
- [[curriculum-learning]]
- [[reinforcement-learning]]
- [[test-time-scaling]]
