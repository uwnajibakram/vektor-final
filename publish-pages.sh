#!/usr/bin/env bash
# Create GitHub repo, push this folder, and enable GitHub Pages (branch main, /).
# Prerequisites: brew install gh  — then run once: gh auth login
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

REPO_NAME="${1:-vektor-final}"

if ! command -v gh >/dev/null 2>&1; then
  echo "Install GitHub CLI: brew install gh"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "Not logged in. In Terminal, run:"
  echo "  gh auth login"
  echo "Choose GitHub.com, then HTTPS (or SSH) and finish in the browser."
  exit 1
fi

OWNER="$(gh api user --jq .login)"
FULL="${OWNER}/${REPO_NAME}"

echo "GitHub user: $OWNER"
echo "Repository:  $FULL"

if gh repo view "$FULL" >/dev/null 2>&1; then
  echo "Repository already exists on GitHub; updating remote and pushing."
  if ! git remote get-url origin >/dev/null 2>&1; then
    git remote add origin "https://github.com/${FULL}.git"
  fi
  git push -u origin main
else
  echo "Creating public repository and pushing..."
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
fi

echo "Enabling GitHub Pages (main, /)..."
if gh api "repos/${FULL}/pages" >/dev/null 2>&1; then
  echo "Pages configuration already present. Check: https://github.com/${FULL}/settings/pages"
else
  if gh api --method POST "repos/${FULL}/pages" \
    -f build_type=legacy \
    -f source[branch]=main \
    -f source[path]=/ \
    >/dev/null 2>&1; then
    echo "GitHub Pages enabled via API."
  else
    echo "Could not enable Pages via API (your token may lack admin access to the repo)."
    echo "Enable manually: https://github.com/${FULL}/settings/pages"
    echo "  Deploy from a branch → main → / (root)"
  fi
fi

echo ""
echo "Live URL after the build finishes (~1–2 minutes):"
echo "  https://${OWNER}.github.io/${REPO_NAME}/"
echo "Repository: https://github.com/${FULL}"
