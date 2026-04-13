---
title: 知识库首页 (中文)
created: 2026-04-13
updated: 2026-04-13
type: index
tags: [index, chinese]
lang: zh
---

# 智能体自进化知识库

> 关于 AI 智能体自主进化、终身学习、多智能体协同的研究资料库

**最后更新**: 2026-04-13 | **总页数**: 28 (英文) + 19 (中文)

---

## 📚 快速导航

### 🏠 首页
- [英文原版首页](index.md) — 英文完整目录
- [知识库规范](SCHEMA.md) — YAML 前置数据、标签体系、文件命名规范
- [更新日志](log.md) — 按时间顺序的所有操作记录

---

## 🧩 核心框架 (实体)

必读的五篇核心论文详解：

| 框架 | 核心创新 | 适用场景 |
|------|---------|---------|
| [[zh/entities/evosc-framework\|EvoSC]] | 双记忆架构：显式 FIFO + 隐式参数化巩固 | 终身任务执行，避免 OOM |
| [[zh/entities/sage-framework\|SAGE]] | 四智能体对抗闭环：出题者/规划者/解题者/评判者 | 数学/代码推理，500条种子数据 |
| [[zh/entities/agent0-framework\|Agent0]] | 零数据 + 多轮工具集成 + ADPO 算法 | 冷启动，通用推理 |
| [[zh/entities/lse-framework\|LSE]] | RL 训练 prompt 编辑技能 + 进化树搜索 | 测试时优化，小模型胜大模型 |
| [[zh/entities/self-evolving-embodied-ai-survey\|具身智能综述]] | 五维闭环框架：记忆/任务/环境/身体/模型 | 机器人系统设计蓝图 |

---

## 🔬 核心概念

理解自进化智能体的关键机制：

- [[zh/concepts/self-evolving-agent\|自进化智能体]] — 定义与分类
- [[zh/concepts/contrastive-experience-extraction\|对比式经验提取]] — 从失败中学习
- [[zh/concepts/parametric-consolidation\|参数化巩固]] — 经验压缩为 20 个 token
- [[zh/concepts/curriculum-agent\|课程智能体]] — 生成难度适中的训练任务
- [[zh/concepts/executor-agent\|执行智能体]] — 解决课程任务，支持工具
- [[zh/concepts/adpo\|ADPO]] — 动态信任域策略优化，处理噪声标签
- [[zh/concepts/test-time-self-evolution\|测试时自进化]] — 推理时优化 prompt
- [[zh/concepts/evolution-tree\|进化树]] — UCB1 搜索 prompt 空间

---

## 📊 对比分析

系统性比较五篇核心论文：

- [[zh/comparisons/self-evolving-frameworks-comparison\|框架对比速览]] — 横向对比表
- [[zh/comparisons/self-evolving-agents-comprehensive-survey\|综合深度对比]] — 技术路线、选型决策树、趋势预测

---

## 📖 深度分析 (12维度)

每篇核心论文的完整 12 维度深度分析：

1. 核心问题与动机
2. 关键结论与贡献
3. 详细研究方法
4. 实验结果与发现
5. 实践意义及启示
6. 局限性与未来方向
7. 影响分析
8. 关键问题及解答
9. 前人研究情况
10. 实例推演（技术版+通俗版）
11. 总结
12. 相关推荐

分析文档：
- [[zh/queries/evosc-deep-analysis\|EvoSC 深度分析]]
- [[zh/queries/sage-deep-analysis\|SAGE 深度分析]]
- [[zh/queries/agent0-deep-analysis\|Agent0 深度分析]]
- [[zh/queries/lse-deep-analysis\|LSE 深度分析]]
- [[zh/queries/embodied-ai-deep-analysis\|具身智能综述深度分析]]

---

## 📰 原始资料

- `raw/articles/` — arXiv 论文摘要
- `raw/papers/` — PDF 原文

---

## 🌐 网站访问

本知识库自动部署到 GitHub Pages：

**https://jiangtaowoo.github.io/Agent-wiki**

- 支持全文搜索
- 支持深色/浅色模式切换
- 支持手机/平板/桌面响应式浏览

---

## 🔄 自动更新

本知识库每周一上午 9:00 自动更新：
- 搜索 arXiv 最新 self-evolving agent 相关论文
- 自动下载摘要并更新 wiki
- 自动同步到 GitHub 并重建网站
- 推送通知到微信和飞书

---

## 📝 使用建议

1. **快速入门**: 从 [综合深度对比](zh/comparisons/self-evolving-agents-comprehensive-survey.md) 开始，了解全貌
2. **深入研究**: 选择感兴趣的框架，阅读对应的 [深度分析](zh/queries/)
3. **工程实践**: 查看 [选型决策树](zh/comparisons/self-evolving-agents-comprehensive-survey.md#技术选型决策树) 选择适合你场景的框架
4. **跟踪前沿**: 关注每周自动推送的新论文摘要

---

**维护者**: Hermes Agent | **协议**: MIT | **最后同步**: 2026-04-13
