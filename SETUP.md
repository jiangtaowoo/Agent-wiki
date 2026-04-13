# GitHub Pages Setup Guide

Complete guide for setting up GitHub synchronization and GitHub Pages for this wiki.

## Prerequisites

- A GitHub account
- Access to the container running Hermes (or ability to run commands in it)

## Step 1: Create GitHub Personal Access Token (PAT)

1. Go to https://github.com/settings/tokens
2. Click **Generate new token (classic)**
3. Give it a name like "Wiki Sync"
4. Select scopes:
   - ✅ `repo` (Full control of private repositories)
   - ✅ `workflow` (Update GitHub Action workflows)
5. Click **Generate token**
6. **Copy the token immediately** (you won't see it again!)

## Step 2: Create GitHub Repository

### Option A: Using GitHub CLI

```bash
# Install gh CLI (in the container)
apt-get update && apt-get install -y gh

# Authenticate with your token
echo "YOUR_TOKEN_HERE" | gh auth login --with-token

# Create public repo (for free GitHub Pages)
cd ~/wiki
gh repo create wiki --public --source=. --remote=origin --push
```

### Option B: Manual Setup

1. Go to https://github.com/new
2. Repository name: `wiki`
3. Visibility: **Public** (required for free GitHub Pages)
4. Don't initialize with README (we already have one)
5. Click **Create repository**

Then configure git:

```bash
cd ~/wiki
git remote add origin https://YOUR_USERNAME:YOUR_TOKEN@github.com/YOUR_USERNAME/wiki.git
git branch -M main
git push -u origin main
```

## Step 3: Update Site URL

Edit `mkdocs.yml` and replace:
```yaml
site_url: https://YOUR_USERNAME.github.io/wiki
```
with your actual GitHub username.

Then commit:
```bash
git add mkdocs.yml
git commit -m "Update site URL"
git push origin main
```

## Step 4: Enable GitHub Pages

1. Go to `https://github.com/YOUR_USERNAME/wiki/settings/pages`
2. Under **Build and deployment**:
   - Source: Select **GitHub Actions**
3. The workflow in `.github/workflows/pages.yml` will handle deployment

## Step 5: Verify Deployment

1. Go to the **Actions** tab in your GitHub repo
2. Wait for the "Deploy Wiki to GitHub Pages" workflow to complete (2-3 minutes)
3. Visit `https://YOUR_USERNAME.github.io/wiki`

## Step 6: Update Cron Job (if not already done)

The cron job that fetches new papers should also sync to GitHub. Update it to call the sync script:

```bash
# After fetching new papers, add:
~/wiki/scripts/auto-sync.sh
```

Or ask Hermes to update the cron job for you.

## Troubleshooting

### "fatal: could not read Username for 'https://github.com'"
Your token is invalid or expired. Generate a new one at https://github.com/settings/tokens

### "remote: Permission to ... denied"
Your token lacks `repo` scope. Generate a new token with the correct scopes.

### "Error: .github/workflows/pages.yml: No such file or directory"
You haven't committed the workflow file. Run:
```bash
cd ~/wiki
git add .github/
git commit -m "Add GitHub Pages workflow"
git push origin main
```

### Pages not showing after 5 minutes
- Check the Actions tab for build errors
- Ensure the repository is public
- Check that Pages is enabled in Settings > Pages
- Try a manual workflow trigger: Actions > Deploy Wiki to GitHub Pages > Run workflow

## Security Notes

1. **Never share your Personal Access Token** in chat logs or commit it to git
2. **Use classic tokens** (not fine-grained) for compatibility with git HTTPS
3. **Set token expiration** to 90 days or less for security
4. **If using a public computer**, clear bash history after setting up:
   ```bash
   history -c && history -w
   ```

## Next Steps

Once setup is complete:
- [ ] Bookmark `https://YOUR_USERNAME.github.io/wiki`
- [ ] Share the link with collaborators
- [ ] Subscribe to updates (GitHub Watch > Releases)
- [ ] Consider adding custom domain (Settings > Pages > Custom domain)
