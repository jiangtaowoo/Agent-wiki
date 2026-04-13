# Wiki Schema

## Domain
AI Agent Self-Evolution Research — tracking emergent papers, frameworks, and techniques that enable LLM agents and embodied AI to improve autonomously without heavy human supervision.

## Conventions
- File names: lowercase, hyphens, no spaces (e.g., `evoSC-framework.md`)
- Every wiki page starts with YAML frontmatter
- Use `[[wikilinks]]` to link between pages (minimum 2 outbound links per page)
- When updating a page, always bump the `updated` date
- Every new page must be added to `index.md` under the correct section
- Every action must be appended to `log.md`

## Frontmatter
```yaml
---
title: Page Title
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: entity | concept | comparison | query | summary
tags: [from taxonomy below]
sources: [raw/articles/source-name.md]
---
```

## Tag Taxonomy
- Framework: `framework`, `methodology`, `training-paradigm`
- Agent Types: `llm-agent`, `embodied-agent`, `multi-agent`, `tool-using-agent`
- Mechanisms: `self-play`, `curriculum-learning`, `reinforcement-learning`, `memory`, `world-model`, `prompt-optimization`
- Data: `zero-data`, `few-shot`, `self-supervised`
- Scale: `test-time-scaling`, `lifelong-learning`, `continual-learning`
- Domain: `reasoning`, `code-generation`, `math`, `robotics`, `general`
- Meta: `comparison`, `survey`, `paper`, `benchmark`

## Page Thresholds
- **Create a page** when an entity/concept appears in 2+ sources OR is central to one source
- **Add to existing page** when a source mentions something already covered
- **DON'T create a page** for passing mentions, minor details, or things outside the domain
- **Split a page** when it exceeds ~200 lines
- **Archive a page** when fully superseded
