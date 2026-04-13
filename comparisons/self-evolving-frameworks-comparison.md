---
title: Comparison of Self-Evolving Agent Frameworks (2025-2026)
created: 2026-04-13
updated: 2026-04-13
type: comparison
tags: [comparison, framework, llm-agent, embodied-agent]
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md, raw/articles/sage-multi-agent-self-evolution-for-llm-reasoning.md, raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md, raw/articles/learning-to-self-evolve.md, raw/articles/self-evolving-embodied-ai.md]
---

# Comparison of Self-Evolving Agent Frameworks (2025-2026)

This page compares the five most prominent recent frameworks for agent self-evolution.

## High-Level Overview

| Framework | Paper | Core Mechanism | #Agents | Data Need | What Evolves |
|-----------|-------|----------------|---------|-----------|--------------|
| **EvoSC** | [arXiv:2602.01966](https://arxiv.org/abs/2602.01966) | Dual-memory consolidation | 1 | Interaction history | Prompt memory |
| **SAGE** | [arXiv:2603.15255](https://arxiv.org/abs/2603.15255) | Multi-agent adversarial co-evolution | 4 | ~500 seed examples | Model policy |
| **Agent0** | [arXiv:2511.16043](https://arxiv.org/abs/2511.16043) | Curriculum-executor co-evolution + tools | 2 | Zero data | Model policy |
| **LSE** | [arXiv:2603.18620](https://arxiv.org/abs/2603.18620) | RL-trained prompt editor + tree search | 1 | RL training data | Prompt context |
| **Embodied AI Survey** | [arXiv:2602.04411](https://arxiv.org/abs/2602.04411) | 5-dimensional system roadmap | N/A | Conceptual | Full stack |

## What Each Framework Excels At

| Framework | Best For | Key Strength | Key Limitation |
|-----------|----------|--------------|----------------|
| **EvoSC** | Lifelong task execution | Avoids OOM via parametric consolidation | Requires task interaction history |
| **SAGE** | Math / code reasoning | Explicit quality control via Critic | Restricted to verifiable domains |
| **Agent0** | General reasoning from scratch | Zero-data + tool integration | Needs sandbox infrastructure |
| **LSE** | Test-time scaling | 4B model beats GPT-5 | Needs pre-training on evolution skill |
| **Embodied Survey** | Robotics roadmap | Holistic system view | Not an implementation |

## Technical Mechanism Comparison

### Memory / Experience Handling
- **EvoSC:** Contrastive extraction + FIFO queues + parametric consolidation (20 tokens)
- **SAGE:** No persistent memory; uses fresh generated data each iteration
- **Agent0:** Filters tasks by capability frontier ($|\hat{p} - 0.5| \leq \delta$)
- **LSE:** Tree-structured context archive with UCB selection

### Optimization Objective
- **EvoSC:** Reconstruction loss (teacher-student distillation)
- **SAGE:** Multi-agent joint RL with verifier-based and difficulty rewards
- **Agent0:** GRPO for curriculum agent + [[adpo]] for executor agent
- **LSE:** Single-step RL with improvement-based reward $r = \bar{R}(c_1) - \bar{R}(c_0)$

### Tool Use
- **EvoSC:** No explicit tool integration
- **SAGE:** No explicit tool integration (relies on verifiers)
- **Agent0:** **Native multi-turn tool integration** (Python code execution)
- **LSE:** No explicit tool integration

## Relationship Map

```
Self-Evolving Embodied AI (Survey)
├── Memory Self-updating → [[evosc-framework]] (partial)
├── Task Self-switching → [[agent0-framework]] (partial), [[sage-framework]] (partial)
├── Model Self-evolution → [[sage-framework]], [[agent0-framework]], [[lse-framework]]
└── Environment Self-prediction → (future work)
```

## Verdict / Synthesis

There is no single "best" framework; they solve different problems along the self-evolution spectrum:

- **If you have interaction logs** and want the agent to get better over time → **EvoSC**
- **If you have a small seed dataset** in a verifiable domain and want maximum reasoning gains → **SAGE**
- **If you have zero data** but need general reasoning with tools → **Agent0**
- **If you want to squeeze more performance at inference time** without retraining the base model → **LSE**
- **If you are building robots** for unstructured environments → Use the **Embodied AI Survey** as the architectural roadmap.

The field is converging on a shared insight: **self-evolution works best when there is a tight feedback loop between a generator and a solver, with an explicit mechanism to control quality or difficulty.**
