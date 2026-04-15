---
title: "Live-Evo: Online Evolution of Agentic Memory from Continuous Feedback"
arxiv_id: "2602.02369"
authors: "Yaolun Zhang, Yiran Wu, Yijiong Yu, Qingyun Wu, Huazheng Wang"
date: "2026-02-02"
tags: [self-evolving-agent, memory, lifelong-learning, multi-agent]
---

## Abstract

Large language model (LLM) agents are increasingly equipped with memory, which are stored experience and reusable guidance that can improve task-solving performance. Recent self-evolving systems update memory based on interaction outcomes, but most existing evolution pipelines are developed for static train/test splits and only approximate online learning by folding static benchmarks, making them brittle under true distribution shift and continuous feedback.

We introduce Live-Evo, an online self-evolving memory system that learns from a stream of incoming data over time. Live-Evo decouples memory into two banks: an Experience Bank that stores "what happened" — raw experiences from interactions, and a Meta-Guideline Bank that stores "how to use it" — compiling task-adaptive guidelines from retrieved experiences for each specific task.

Live-Evo maintains dynamic experience weights that are updated continuously from feedback. Experiences that consistently help are reinforced and retrieved more often, while misleading or stale experiences are down-weighted and gradually forgotten, analogous to reinforcement and decay in human memory.

Evaluated on the live Prophet Arena benchmark over a 10-week horizon, Live-Evo improves Brier score by +20.8% and market returns by +12.9%. The system also transfers to deep-research benchmarks, showing consistent gains over strong baselines.

## Resources

- PDF: http://arxiv.org/pdf/2602.02369
- HTML: https://arxiv.org/html/2602.02369v1
- Code: https://github.com/ag2ai/Live-Evo
