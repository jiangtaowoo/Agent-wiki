---
title: "Mem²Evolve: Towards Self-Evolving Agents via Co-Evolutionary Capability Expansion and Experience Distillation"
arxiv_id: "2604.10923"
authors: "Zihao Cheng, Zeming Liu, Yingyu Shan, Xinyi Wang, Xiangrong Zhu, Yunpu Ma, Hongru Wang, Yuhang Guo, Wei Lin, Yunhong Wang"
date: "2026-04-13"
venue: "ACL 2026 Main"
tags: [self-evolving-agent, multi-agent, tool-using-agent, memory, curriculum-learning]
---

## Abstract

Existing LLM-powered agent frameworks treat self-evolution through experience accumulation and dynamic asset creation (tools or expert agents) as isolated processes. This separation overlooks their intrinsic interdependence: the former is inherently bounded by a manually predefined static toolset, while the latter generates new assets from scratch without experiential guidance, leading to limited capability growth and unstable evolution.

We introduce Mem²Evolve, a co-evolutionary paradigm combining Capability Expansion and Experience Distillation. The framework leverages two integrated memory systems: an Experience Memory that stores accumulated operational knowledge, and an Asset Memory that houses dynamically created tools and expert agents. Mem²Evolve uses accumulated experience to guide the dynamic creation of assets, thereby expanding the agent's capability space while simultaneously acquiring new experience to achieve co-evolution.

Evaluated across 6 task categories and 8 benchmarks, Mem²Evolve achieves +18.53% over standard LLMs, +11.80% over agents evolving solely through experience, and +6.46% over agents evolving solely through asset creation.

## Resources

- PDF: http://arxiv.org/pdf/2604.10923
- HTML: https://arxiv.org/html/2604.10923v1
- Code & Project Page: https://buaa-irip-llm.github.io/Mem2Evolve
