# Wiki 日志

> 所有 wiki 操作的时间顺序记录。仅追加。
> 格式：`## [YYYY-MM-DD] action | subject`

## [2026-04-13] create | Wiki 初始化
- 领域：AI Agent 自我演化研究
- 创建结构：SCHEMA.md, index.md, log.md
- 目录：raw/, entities/, concepts/, comparisons/, queries/

## [2026-04-13] ingest | 5 篇 Agent 自我演化相关 arXiv 论文
- 摄入来源：
  - raw/articles/evoSC-self-consolidation-for-self-evolving-agents.md (arXiv:2602.01966)
  - raw/articles/sage-multi-agent-self-evolution-for-llm-reasoning.md (arXiv:2603.15255)
  - raw/articles/agent0-unleashing-self-evolving-agents-from-zero-data.md (arXiv:2511.16043)
  - raw/articles/learning-to-self-evolve.md (arXiv:2603.18620)
  - raw/articles/self-evolving-embodied-ai.md (arXiv:2602.04411)

## [2026-04-13] create | 5 个框架的实体页面
- entities/evosc-framework.md
- entities/sage-framework.md
- entities/agent0-framework.md
- entities/lse-framework.md
- entities/self-evolving-embodied-ai-survey.md

## [2026-04-13] create | 核心机制的概念页面
- concepts/self-evolving-agent.md
- concepts/contrastive-experience-extraction.md
- concepts/parametric-consolidation.md
- concepts/curriculum-agent.md
- concepts/executor-agent.md
- concepts/adpo.md
- concepts/test-time-self-evolution.md
- concepts/evolution-tree.md

## [2026-04-13] create | 对比页面
- comparisons/self-evolving-frameworks-comparison.md

## [2026-04-13] update | 索引和导航
- 更新 index.md，包含 14 个页面
- 将所有操作追加到 log.md

## [2026-04-13] create | 5 个深度论文分析查询
- 使用 deep-paper-analysis skill 为 5 篇自我演化 Agent 论文创建深度分析页面
- 文件：queries/evosc-deep-analysis.md, queries/sage-deep-analysis.md, queries/agent0-deep-analysis.md, queries/lse-deep-analysis.md, queries/embodied-ai-deep-analysis.md
- 每个分析覆盖全部 12 个维度：动机、贡献、方法、实验、影响、局限、影响评估、问答、相关工作、实例推演、总结、推荐

## [2026-04-13] create | 综合对比调研
- 创建 comparisons/self-evolving-agents-comprehensive-survey.md
- 内容：9 章节综合对比，涵盖横向/纵向分析、决策树、趋势预测、工程建议

## [2026-04-13] sync | 完整中文翻译同步至 zh/ 目录
- 将 root/queries/ 中的完整中文查询复制到 zh/queries/
- 将 root/comparisons/ 中的完整中文综合调研复制到 zh/comparisons/
- 验证 zh/entities/ 和 zh/concepts/ 已完整
- 创建 zh/SCHEMA.md 和 zh/log.md 实现完整双语结构
- 确保 zh/ 目录作为权威中文位置
