#!/bin/bash
# 全リポジトリ一覧を表示

echo "📋 SOOJUNBARNG — 全リポジトリ一覧"
echo "=================================="
gh repo list SOOJUNBARNG --limit 100 --json name,isPrivate,updatedAt \
  | jq -r '.[] | "\(.isPrivate | if . then "🔒" else "🌐" end)  \(.name)  (更新: \(.updatedAt[:10]))"' \
  | sort
