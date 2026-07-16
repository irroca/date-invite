#!/usr/bin/env bash
# 一键部署到 GitHub Pages（public 仓库）
# 用法：登录 GitHub 后，在项目目录执行  bash deploy.sh
set -e

REPO_NAME="${1:-date-invite}"

cd "$(dirname "$0")"

echo "==> 检查 GitHub 登录状态..."
if ! gh auth status >/dev/null 2>&1; then
  echo "尚未登录 GitHub，开始交互式登录（按提示选择 GitHub.com / HTTPS / 浏览器授权）..."
  gh auth login
fi

OWNER=$(gh api user --jq .login)
echo "==> 已登录为: $OWNER"

echo "==> 确保有一次提交..."
if ! git rev-parse HEAD >/dev/null 2>&1; then
  git add .
  git commit -m "cute date invite page"
fi
git branch -M main

if gh repo view "$OWNER/$REPO_NAME" >/dev/null 2>&1; then
  echo "==> 远程仓库已存在：$OWNER/$REPO_NAME，直接推送..."
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$OWNER/$REPO_NAME.git"
  git push -u origin main
else
  echo "==> 创建 public 仓库并推送：$OWNER/$REPO_NAME ..."
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
fi

echo "==> 开启 GitHub Pages（main / 根目录）..."
gh api --method POST "repos/$OWNER/$REPO_NAME/pages" \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  || gh api --method PUT "repos/$OWNER/$REPO_NAME/pages" \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  || echo "（Pages 可能已开启，或需稍后在 Settings→Pages 确认）"

echo ""
echo "======================================================"
echo " 部署完成！稍等 1-2 分钟生效后访问："
echo "   https://$OWNER.github.io/$REPO_NAME/"
echo "======================================================"
