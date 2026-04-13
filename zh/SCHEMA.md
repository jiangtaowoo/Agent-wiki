# Wiki 结构规范

## 领域
AI Agent 自我演化研究 — 追踪让 LLM Agent 和具身 AI 在无需大量人工监督的情况下自主改进的论文、框架与技术。

## 约定
- 文件名：小写，连字符，无空格（如 `evosc-framework.md`）
- 每个 wiki 页面必须以 YAML frontmatter 开头
- 使用 `[[wikilinks]]` 在页面之间链接（每页至少 2 个出站链接）
- 更新页面时，始终更新 `updated` 日期
- 每个新页面必须添加到 `index.md` 的正确章节下
- 每个操作必须追加到 `log.md`

## Frontmatter
```yaml
---
title: 页面标题
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: entity | concept | comparison | query | summary
tags: [见下方分类]
sources: [raw/articles/source-name.md]
---
```

## 标签分类
- 框架: `framework`, `methodology`, `training-paradigm`
- Agent 类型: `llm-agent`, `embodied-agent`, `multi-agent`, `tool-using-agent`
- 机制: `self-play`, `curriculum-learning`, `reinforcement-learning`, `memory`, `world-model`, `prompt-optimization`
- 数据: `zero-data`, `few-shot`, `self-supervised`
- 规模: `test-time-scaling`, `lifelong-learning`, `continual-learning`
- 领域: `reasoning`, `code-generation`, `math`, `robotics`, `general`
- 元信息: `comparison`, `survey`, `paper`, `benchmark`

## 页面阈值
- **创建页面**：当一个实体/概念出现在 2+ 个来源中，或是某一来源的核心内容时
- **添加到现有页面**：当来源提到已有页面覆盖的内容时
- **不要创建页面**：对于顺带提及、次要细节，或超出领域的内容
- **拆分页面**：当页面超过约 200 行时
- **归档页面**：当被完全取代时
