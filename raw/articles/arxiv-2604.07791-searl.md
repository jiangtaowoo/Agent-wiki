---
title: "SEARL: Joint Optimization of Policy and Tool Graph Memory for Self-Evolving Agents"
arxiv_id: "2604.07791"
authors: "Xinshun Feng, Xinhao Song, Lijun Li, Gongshen Liu, Jing Shao"
date: "2026-04-13"
venue: "ACL 2026"
tags: [self-evolving-agent, tool-using-agent, reinforcement-learning, memory]
---

## Abstract

Recent advances in Reinforcement Learning with Verifiable Rewards (RLVR) have demonstrated significant potential in single-turn reasoning tasks. With the paradigm shift toward self-evolving agentic learning, models are increasingly expected to learn from trajectories by synthesizing tools or accumulating explicit experiences. However, prevailing methods typically rely on large-scale LLMs or multi-agent frameworks, which hinder their deployment in resource-constrained environments. The inherent sparsity of outcome-based rewards also poses a substantial challenge, as agents typically receive feedback only upon completion of tasks.

To address these limitations, we introduce SEARL, a Tool-Memory based self-evolving agentic framework. Unlike approaches that directly utilize interaction experiences, our method constructs a structured experience memory that integrates planning with execution. This provides a novel state abstraction that facilitates generalization across analogous contexts, such as tool reuse. Consequently, agents extract explicit knowledge from historical data while leveraging inter-trajectory correlations to densify reward signals. We evaluate our framework on knowledge reasoning and mathematics tasks, demonstrating its effectiveness in achieving more practical and efficient learning.

## Resources

- PDF: http://arxiv.org/pdf/2604.07791
- HTML: https://arxiv.org/html/2604.07791v2
