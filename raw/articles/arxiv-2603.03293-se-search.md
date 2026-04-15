---
title: "SE-Search: Self-Evolving Search Agent via Memory and Dense Reward"
arxiv_id: "2603.03293"
authors: "Jian Li, Yizhang Jin, Dongqi Liu, Hang Ding, Jiafu Wu, Dongsheng Chen, Yunhang Shen, Yulei Qin, Ying Tai, Chengjie Wang, Xiaotong Yuan, Yabiao Wang"
date: "2026-03-06"
tags: [self-evolving-agent, tool-using-agent, memory, reinforcement-learning, reasoning]
---

## Abstract

Retrieval augmented generation (RAG) reduces hallucinations in large language models (LLMs) by conditioning generation on retrieved external knowledge. Recent approaches frame RAG as an autonomous, multi-turn information-seeking process, but suffer from two key limitations: accumulation of irrelevant or noisy documents during search, and sparse reinforcement learning (RL) signals, which hinder effective training.

We propose SE-Search (Self-Evolving Search), an agent that improves online search behavior through three core components:

1. **Think-Search-Memorize Strategy**: SE-Search follows a Think-Search-Memorize strategy that retains salient evidence while filtering irrelevant content.
2. **Atomic Query Training**: Atomic query training promotes shorter and more diverse queries, improving evidence acquisition.
3. **Dense Rewards**: Dense rewards provide fine-grained feedback that speeds training.

Evaluated on single-hop and multi-hop question answering benchmarks, SE-Search-3B achieves +10.8 points over strong baselines and +33.8% over Search-R1.

## Resources

- PDF: http://arxiv.org/pdf/2603.03293
- HTML: https://arxiv.org/html/2603.03293v1
