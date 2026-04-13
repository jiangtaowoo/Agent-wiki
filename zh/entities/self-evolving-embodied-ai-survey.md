---
title: 自进化具身智能 (Self-Evolving Embodied AI Survey)
created: 2026-04-13
updated: 2026-04-13
type: entity
tags: [survey, embodied-agent, lifelong-learning, general]
lang: zh
sources: [raw/articles/self-evolving-embodied-ai.md]
---

# 自进化具身智能 (Self-Evolving Embodied AI Survey)

**论文**: [arXiv:2602.04411](https://arxiv.org/abs/2602.04411)  
**作者**: Tongtong Feng, Xin Wang, Wenwu Zhu  
**机构**: 清华大学  
**期刊**: National Science Review (NSR)

## 概述

这是一篇**综述/框架论文**，引入了**自进化具身智能**范式，使智能体能够在动态、开放、野外的环境中实现**持续自适应智能与自主进化**。它指出，现有的具身智能被困在人类精心打造的环境中（固定身体、静态环境、给定任务），在现实世界部署中会失败。

## 定义

> **自进化具身智能**: 智能体基于自身变化的内部状态和外部环境运作，具备**记忆自更新**、**任务自切换**、**身体自适应**、**环境自预测**和**模型自进化**能力，目标是实现持续自适应智能与自主进化。

## 五个核心组件

| 组件 | 进化内容 | 关键机制 |
|------|---------|---------|
| **记忆自更新** | 内部记忆表征 | 自编辑（增/改/删/忘）、自组织（动态索引）、自蒸馏（情节性 → 可复用知识） |
| **任务自切换** | 内部任务目标 | 自选择（自适应调度）、自生成（在线任务创建） |
| **环境自预测** | 世界模型 | 理解型世界模型（JEPA、Dreamer）、生成型世界模型（Genie、MineWorld） |
| **身体自适应** | 物理/认知身体 | 形态自适应、跨身体技能迁移 |
| **模型自进化** | 模型参数/结构 | 在线学习、架构搜索、元学习 |

**关键机制**: 五个模块形成一个**统一的进化闭环**，具有**双向信息交换**。一个模块的更新会引发其他模块的调整。

## 框架对比

| 方面 | 现有具身智能 | 自进化具身智能 |
|------|-------------|---------------|
| 环境 | 人类打造 | 野外真实环境 |
| 记忆 | 给定、固定 | 自更新 |
| 任务 | 给定、预定义 | 自切换 |
| 环境 | 相对静态 | 自预测、动态 |
| 身体 | 固定配置 | 自适应 |
| 模型 | 预训练、单向优化 | 自进化、双向耦合 |

## 关系

- **涵盖**: [[zh/entities/evosc-framework\|EvoSC]]、[[zh/entities/sage-framework\|SAGE]]、[[zh/entities/agent0-framework\|Agent0]]、[[zh/entities/lse-framework\|LSE]] 作为特定组件的部分实现。
- **提供路线图**: 说明这些点解决方案如何集成到完整堆栈中。
- **广泛引用**: DreamerV3、Genie、SAGE、AgentEvolver、WebRL、Mobile-Agent-E 等。
