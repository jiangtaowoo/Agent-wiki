#!/bin/bash
set -e

WIKI_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$WIKI_DIR"

# Check if there are changes to commit
if git diff --quiet && git diff --staged --quiet; then
    echo "No changes to sync."
    exit 0
fi

# Add all changes
git add .

# Commit with timestamp and list of changes
COMMIT_MSG="Auto-sync wiki: $(date '+%Y-%m-%d %H:%M:%S')

Changes:
$(git status --short)"

git commit -m "$COMMIT_MSG" || true

# Push to remote (requires remote to be configured)
if git remote | grep -q origin; then
    git push origin main || git push origin master || true
    echo "Wiki synced successfully to GitHub."
    echo "Site will be updated at: https://YOUR_USERNAME.github.io/wiki"
else
    echo "Warning: No remote 'origin' configured. Skipping push."
    echo "Please follow the setup instructions in SETUP.md"
fi
