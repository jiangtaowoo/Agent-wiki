---
title: SAGE 深度分析 (中文摘要)
created: 2026-04-13
updated: 2026-04-13
type: query
tags: [paper-analysis, multi-agent, self-play, curriculum-learning, reasoning, chinese]
lang: zh
sources: [raw/articles/sage-multi-agent-self-evolution-for-llm-reasoning.md]
---

# SAGE 深度分析 (中文摘要)

**原文**: [arXiv:2603.15255](https://arxiv.org/abs/2603.15255)  
**核心创新**: 四智能体对抗闭环，仅 500 条种子数据实现稳定自我进化

---

## 1. 核心问题与动机

可验证奖励的 RL 能提升 LLM 推理，但依赖大量人工标注。Self-play 虽减少数据依赖，但缺乏显式规划和质量控制（容易 curriculum drift）。

## 2. 关键贡献

1. **四智能体闭环**: Challenger（出题）/ Planner（规划）/ Solver（解题）/ Critic（评判）
2. **显式质量门控**: Critic 打分过滤低质量内容，防止 drift
3. **Plan Gating**: Solver 只在计划质量高时才遵循计划

## 3. 核心机制: Arms Race（军备竞赛）

- Solver 越强 → Challenger 出越难题 → Solver 被迫进化
- Critic 从中过滤 → 防止 Challenger 为"难"而出怪题

### 奖励设计
- **Challenger**: 难度奖励 = Solver 失败率，质量门槛 $s_q \geq 0.7$
- **Solver**: $r_s = 0.2 \cdot s_p + 0.6 \cdot s_{gt} + 0.2 \cdot r_f$

## 4. 实验结果

- **Qwen-2.5-7B**: LiveCodeBench +8.9%, OlympiadBench +10.7%
- **Qwen-3-4B**: LiveCodeBench 21.5% → 30.6%
- 仅用 ~500 条种子数据，3B/4B/7B 全尺度一致提升

## 5. 通俗理解

武术学校训练体系：
- **出题老师**: 学生越强，题越难
- **战术教练**: 告诉学生"分三步走"
- **学生**: 上场比武的人
- **裁判**: 拦住离谱的危险项目

最精妙的是：学生越强，老师出的题就越难；但裁判会拦住那些危险项目。

## 6. 适用场景

- 数学/代码竞赛类推理增强
- 数据稀缺的领域（需要 verifier 判断对错）
- 有明确答案的推理任务

---

**完整 12 维度分析**: [查看英文原版](../queries/sage-deep-analysis.md) 或阅读 [[zh/entities/sage-framework\|实体页面]]
