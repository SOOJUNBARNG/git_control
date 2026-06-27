#!/bin/bash
# ローカルにcloneされている全リポジトリをpull（最新化）

BASE_DIR="$HOME"
REPOS=$(gh repo list SOOJUNBARNG --limit 100 --json name -q '.[].name')

echo "⬇️  全リポジトリ pull（最新化）"
echo "================================"

for repo in $REPOS; do
  for dir in "$BASE_DIR/$repo" "$BASE_DIR/Documents/$repo" "$BASE_DIR/Desktop/$repo"; do
    if [ -d "$dir/.git" ]; then
      echo ""
      echo "📁 $repo"
      cd "$dir"
      git pull --ff-only 2>&1 | sed 's/^/  /'
      break
    fi
  done
done

echo ""
echo "================================"
echo "完了"
