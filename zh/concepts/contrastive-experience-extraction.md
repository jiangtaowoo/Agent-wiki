---
title: 对比式经验提取
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, memory, llm-agent, chinese]
lang: zh
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md]
---

# 对比式经验提取

[[zh/entities/evosc-framework\|EvoSC]] 引入的技术：LLM 智能体显式分析**成功**与**失败**轨迹的分歧，提取教学性洞见。

## 动机

传统经验回放方法（如 TER、AWM）只检索成功过去的轨迹，错过了失败中嵌入的宝贵信息——知道*不该做什么*和*为什么*往往和知道该做什么同样重要。

## 机制

给定成功案例 $C_s$ 和失败案例 $C_f$：

- **易错经验 ($Exp_c$)**: $Exp_c = \text{LLM}(P_c \cup C_s \cup C_f)$
  - 提取具体陷阱、错误模式和避免策略
- **成功经验 ($Exp_s$)**: $Exp_s = \text{LLM}(P_s \cup C_s^{(i)} \cup C_s^{(j)})$
  - 对比两个不同成功案例，抽象出更高层次的通用策略

两者都存入 FIFO 队列，仅保留最相关的近期经验。

## 与其他技术的关系

- **对比 RAG**: RAG 检索事实；对比式经验提取检索成功 vs. 失败的*因果解释*
