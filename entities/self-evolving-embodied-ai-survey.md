---
title: Self-Evolving Embodied AI (Survey)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [survey, embodied-agent, lifelong-learning, general]
sources: [raw/articles/self-evolving-embodied-ai.md]
---

# Self-Evolving Embodied AI (Survey)

**Paper:** [arXiv:2602.04411](https://arxiv.org/abs/2602.04411)  
**Authors:** Tongtong Feng, Xin Wang, Wenwu Zhu  
**Institution:** Tsinghua University  
**Journal:** National Science Review (NSR)

## Overview

This is a **survey/framework paper** that introduces **self-evolving embodied AI**, a paradigm enabling agents to achieve **continually adaptive intelligence with autonomous evolution** in dynamic, open, in-the-wild environments. It argues that existing embodied AI is confined to human-crafted settings (fixed embodiments, static environments, given tasks) and fails in real-world deployment.

## Definition

> **Self-evolving embodied AI:** The agent operates based on its own changing internal state and external environment with **memory self-updating**, **task self-switching**, **embodiment self-adaptation**, **environment self-prediction**, and **model self-evolution**, aiming to achieve continually adaptive intelligence with autonomous evolution.

## The Five Core Components

| Component | What Evolves | Key Mechanisms |
|-----------|-------------|----------------|
| **Memory Self-updating** | Internal memory representation | Self-editing (add/update/delete/forget), self-organization (dynamic indexing), self-distillation (episodic → reusable knowledge) |
| **Task Self-switching** | Internal task objectives | Self-selection (adaptive scheduling), self-generation (online task creation) |
| **Environment Self-prediction** | World model | Understanding world models (JEPA, Dreamer), generative world models (Genie, MineWorld) |
| **Embodiment Self-adaptation** | Physical/cognitive embodiment | Morphology adaptation, skill transfer across embodiments |
| **Model Self-evolution** | Model parameters/structure | Online learning, architecture search, meta-learning |

**Key Mechanism:** The five modules form a **unified evolutionary loop** with **bidirectional information exchange**. Updates in one module induce adjustments in others.

## Framework Comparison

| Aspect | Existing Embodied AI | Self-evolving Embodied AI |
|--------|---------------------|---------------------------|
| Setting | Human-crafted | In-the-wild |
| Memory | Given, fixed | Self-updating |
| Task | Given, predefined | Self-switching |
| Environment | Relatively static | Self-predicted, dynamic |
| Embodiment | Fixed configuration | Self-adapting |
| Model | Pretrained, unidirectional optimization | Self-evolving, bidirectional coupling |

## Relationships

- **Encompasses:** [[evosc-framework]], [[sage-framework]], [[agent0-framework]], [[lse-framework]] as partial realizations of specific components.
- **Provides the roadmap** for how these point solutions can be integrated into a full stack.
- **Cites extensively:** DreamerV3, Genie, SAGE, AgentEvolver, WebRL, Mobile-Agent-E, and many others.
