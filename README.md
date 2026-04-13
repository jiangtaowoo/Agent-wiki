# Self-Evolving Agents Wiki

AI Agent Self-Evolution Research Knowledge Base — automatically maintained by Hermes Agent.

## Web Access

**https://YOUR_USERNAME.github.io/wiki**

*(Replace YOUR_USERNAME with your actual GitHub username)*

## Features

- **Full-text search** across all papers and analyses
- **Auto-updated weekly** via cron job (Mondays 9:00 AM)
- **Dark/Light mode** toggle
- **Responsive design** for mobile and desktop
- **Math rendering** with MathJax
- **Bidirectional links** support (Obsidian-style)

## Directory Structure

```
wiki/
├── index.md              # Content catalog
├── SCHEMA.md             # Wiki conventions and taxonomy
├── log.md                # Activity log
├── entities/             # Frameworks, models, papers
├── concepts/             # Methods, techniques, mechanisms
├── comparisons/          # Side-by-side analyses
├── queries/              # Deep paper analyses
├── raw/                  # Source materials
│   ├── articles/         # Web articles and abstracts
│   └── papers/           # PDF papers
├── scripts/
│   └── auto-sync.sh      # Auto-sync to GitHub
└── .github/workflows/
    └── pages.yml         # GitHub Pages deployment
```

## Manual Sync

```bash
cd ~/wiki
./scripts/auto-sync.sh
```

## Setup Instructions

See [SETUP.md](SETUP.md) for initial GitHub repository configuration.

## Auto-Update Schedule

This wiki is automatically updated every **Monday at 9:00 AM** with:
- New self-evolving agent papers from arXiv
- Deep analyses of significant new works
- Updated comparison tables and trend reports
