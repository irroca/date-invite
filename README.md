# 约会邀请网页 💕

一个可爱浪漫的单页网页，向女朋友发出约会邀请。她点「不要」时会俏皮地换话术挽留，「好」按钮越变越大、「不要」按钮越变越小还会躲闪；她选「好」之后进入选餐厅、选接她时间、留言的页面，最后生成一段甜甜的文案可一键复制，或生成一个分享链接发回给你。

零依赖，纯静态单文件 `index.html`，本地双击即可打开，也能一键部署到网上。

## 本地预览

直接双击 `index.html`，或起个本地服务器：

```bash
cd date-invite
python3 -m http.server 8777
# 浏览器打开 http://localhost:8777/
```

## 怎么用（送给她的流程）

1. 把网页部署到网上（见下方），拿到一个链接。
2. 把链接发给她。
3. 她选好餐厅和时间后，点「生成分享链接」或「一键复制」，把结果发回给你。
4. 你点开她发来的链接，会看到「她答应啦 💕」的约定卡片，还能一键「加入我的日历」。

## 部署到网上

### 方式一：Vercel（推荐，最快）

```bash
cd date-invite
npx vercel        # 首次会让你登录（浏览器授权），一路回车用默认设置
npx vercel --prod # 部署到正式环境，产出公开链接
```

### 方式二：GitHub Pages

1. 在 GitHub 新建一个仓库，比如 `date-invite`。
2. 推送代码：

```bash
cd date-invite
git add .
git commit -m "cute date invite page"
git branch -M main
git remote add origin https://github.com/<你的用户名>/date-invite.git
git push -u origin main
```

3. 仓库 Settings → Pages → Source 选 `main` 分支、`/ (root)` 目录，保存。
4. 稍等一会即可通过 `https://<你的用户名>.github.io/date-invite/` 访问。

## 自定义（都在 `index.html` 里）

打开 `index.html`，找到顶部的 `CONFIG` 对象修改即可：

- `askTitle` / `askSub`：开场问候语。
- `persuasions`：点「不要」时循环切换的俏皮话术和表情。
- `restaurants`：餐厅候选清单（emoji + 名称）。
- 配色在 `<style>` 顶部的 `:root` 变量里改（`--pink`、`--mint` 等）。

祝约会顺利~ 🌷
