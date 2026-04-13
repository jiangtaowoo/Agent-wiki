---
title: 参数化巩固
created: 2026-04-13
updated: 2026-04-13
type: concept
tags: [methodology, memory, prompt-optimization, chinese]
lang: zh
sources: [raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md]
---

# 参数化巩固

[[zh/entities/evosc-framework\|EvoSC]] 中的机制：将非参数化文本经验蒸馏为紧凑的**可学习 prompt** $P_\theta$，以避免上下文窗口耗尽。

## 问题

持续积累文本经验会线性增加检索时间，最终耗尽 LLM 的上下文窗口，导致性能下降甚至 OOM。

## 解决方案

学习一个短 prompt 向量（20 个 token），编码大量历史轨迹的"精髓"。

- **教师**: 用大量历史轨迹 $E_{many}$ 生成专家动作
- **学生**: 用少量轨迹 $E_{few}$ + $P_\theta$ 重构相同的专家动作
- **损失**: Token 级交叉熵最小化

这模仿了人类认知巩固——将外显的情节记忆转化为内隐的程序性知识。

## 权衡

| 方面 | 文本回放 | 参数化巩固 |
|------|---------|-----------|
| 可扩展性 | 差（线性增长） | 好（固定大小） |
| 可解释性 | 高 | 低 |
| 细粒度细节 | 保留 | 压缩/有损 |
