---
title: "Tool-R0: Self-Evolving LLM Agents for Tool-Learning from Zero Data"
arxiv_id: "2602.21320"
authors: "Emre Can Acikgoz, Cheng Qian, Jonas Hübotter, Heng Ji, Dilek Hakkani-Tür, Gokhan Tur"
date: "2026-02-24"
tags: [self-evolving-agent, tool-using-agent, reinforcement-learning, zero-data, self-play]
---

## Abstract

Large language models (LLMs) are becoming the foundation for autonomous agents that can use tools to solve complex tasks. Reinforcement learning (RL) has emerged as a common approach for injecting such agentic capabilities, but typically under tightly controlled training setups. It often depends on carefully constructed task-solution pairs and substantial human supervision, which creates a fundamental obstacle to open-ended self-evolution toward superintelligent systems.

We propose Tool-R0 framework for training general purpose tool-calling agents from scratch with self-play RL, under a zero-data assumption. Initialized from the same base LLM, Tool-R0 co-evolves a Generator and a Solver with complementary rewards: one proposes targeted challenging tasks at the other's competence frontier and the other learns to solve them with real-world tool calls. This creates a self-evolving cycle that requires no pre-existing tasks or datasets.

Evaluation on different tool-use benchmarks show that Tool-R0 yields 92.5% relative improvement over the base model and surpasses fully supervised tool-calling baselines under the same setting.

## Resources

- PDF: http://arxiv.org/pdf/2602.21320
- HTML: https://arxiv.org/html/2602.21320v1
