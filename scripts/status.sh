#!/bin/bash
# ローカルにcloneされている全リポジトリのgit statusを確認

BASE_DIR="$HOME"
REPOS=$(gh repo list SOOJUNBARNG --limit 100 --json name -q '.[].name')

echo "📊 ローカルリポジトリ ステータス確認"
echo "======================================"

for repo in $REPOS; do
  # よくあるローカルパスを探す
  for dir in "$BASE_DIR/$repo" "$BASE_DIR/Documents/$repo" "$BASE_DIR/Desktop/$repo"; do
    if [ -d "$dir/.git" ]; then
      echo ""
      echo "📁 $repo ($dir)"
      cd "$dir"
      STATUS=$(git status --short)
      BRANCH=$(git branch --show-current)
      AHEAD=$(git rev-list @{u}..HEAD 2>/dev/null | wc -l | tr -d ' ')
      echo "  branch: $BRANCH | push待ち: $AHEAD件"
      if [ -n "$STATUS" ]; then
        echo "  変更あり:"
        echo "$STATUS" | sed 's/^/    /'
      else
        echo "  ✅ クリーン"
      fi
      break
    fi
  done
done

echo ""
echo "======================================"
echo "完了"
