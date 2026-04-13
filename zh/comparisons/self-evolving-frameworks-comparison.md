---
title: 自进化智能体框架对比速览
created: 2026-04-13
updated: 2026-04-13
type: comparison
tags: [comparison, framework, llm-agent, embodied-agent]
lang: zh
sources: 
  - zh/entities/evosc-framework.md
  - zh/entities/sage-framework.md
  - zh/entities/agent0-framework.md
  - zh/entities/lse-framework.md
  - zh/entities/self-evolving-embodied-ai-survey.md
---

# 自进化智能体框架对比速览

本页对比五篇最具影响力的自进化智能体研究工作。

## 高层概览

| 框架 | 论文 | 核心机制 | 智能体数量 | 数据需求 | 进化对象 |
|------|------|---------|-----------|---------|---------|
| **EvoSC** | [arXiv:2602.01966](https://arxiv.org/abs/2602.01966) | 双记忆巩固 | 1 | 交互历史 | Prompt 记忆 |
| **SAGE** | [arXiv:2603.15255](https://arxiv.org/abs/2603.15255) | 多智能体对抗协同进化 | 4 | ~500 种子样本 | 模型策略 |
| **Agent0** | [arXiv:2511.16043](https://arxiv.org/abs/2511.16043) | 课程-执行协同进化 + 工具 | 2 | 零数据 | 模型策略 |
| **LSE** | [arXiv:2603.18620](https://arxiv.org/abs/2603.18620) | RL 训练 Prompt 编辑器 + 树搜索 | 1 | RL 训练数据 | Prompt 上下文 |
| **具身智能综述** | [arXiv:2602.04411](https://arxiv.org/abs/2602.04411) | 五维系统路线图 | N/A | 概念性 | 全栈 |

## 各框架擅长领域

| 框架 | 最适合 | 核心优势 | 主要局限 |
|------|--------|---------|---------|
| **EvoSC** | 终身任务执行 | 通过参数化巩固避免 OOM | 需要交互历史 |
| **SAGE** | 数学/代码推理 | 通过评判者实现显式质量控制 | 限于可验证领域 |
| **Agent0** | 通用推理从零开始 | 零数据 + 工具集成 | 需要 sandbox 基础设施 |
| **LSE** | 测试时扩展 | 4B 模型击败 GPT-5 | 需要预训练进化技能 |
| **具身综述** | 机器人路线图 | 整体系统视角 | 不是具体实现 |

## 技术机制对比

### 记忆/经验处理
- **EvoSC**: 对比式提取 + FIFO 队列 + 参数化巩固（20 tokens）
- **SAGE**: 无持久记忆；每轮迭代使用新生成的数据
- **Agent0**: 按能力前沿过滤任务（$|\hat{p} - 0.5| \leq \delta$）
- **LSE**: 基于 UCB 选择的树结构上下文存档

### 优化目标
- **EvoSC**: 重构损失（教师-学生蒸馏）
- **SAGE**: 多智能体联合 RL，基于验证器和难度奖励
- **Agent0**: 课程智能体用 GRPO + 执行者用 [[zh/concepts/adpo\|ADPO]]
- **LSE**: 单步 RL，奖励为改进量 $r = \bar{R}(c_1) - \bar{R}(c_0)$

### 工具使用
- **EvoSC**: 无显式工具集成
- **SAGE**: 无显式工具集成（依赖验证器）
- **Agent0**: **原生多轮工具集成**（Python 代码执行）
- **LSE**: 无显式工具集成

## 关系图谱

```
自进化具身智能（综述）
├── 记忆自更新 → [[zh/entities/evosc-framework\|EvoSC]]（部分实现）
├── 任务自切换 → [[zh/entities/agent0-framework\|Agent0]]（部分实现）、[[zh/entities/sage-framework\|SAGE]]（部分实现）
├── 模型自进化 → [[zh/entities/sage-framework\|SAGE]]、[[zh/entities/agent0-framework\|Agent0]]、[[zh/entities/lse-framework\|LSE]]
└── 环境自预测 → （未来工作）
```

## 总结/选型建议

没有单一的"最佳"框架，它们解决了自进化光谱上的不同问题：

- **如果你有交互日志**，希望智能体越用越聪明 → **EvoSC**
- **如果你有少量种子数据集**，在可验证领域追求最大推理增益 → **SAGE**
- **如果你零数据**，但需要通用推理和工具 → **Agent0**
- **如果你想在推理时榨取更多性能**，不重训基础模型 → **LSE**
- **如果你在构建野外机器人** → 以**具身智能综述**为架构路线图

该领域正在收敛到一个共同洞见：**当生成器与求解器之间存在紧密反馈回路，并配有显式机制控制质量或难度时，自进化效果最佳。**
