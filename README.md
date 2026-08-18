# 工具情报官 Wiki

> **把「找工具 → 验证 → 拆解 → 吸收灵感」沉淀成可检索的 wiki，让大脑不再承担记忆负担。**

「工具情报官」流水线的静态知识站，基于 VitePress，自动构建发布到 GitHub Pages。

## 栏目结构

| 栏目 | 路径 | 内容 |
|------|------|------|
| 精选工具 | `docs/tools/` | 每个工具一篇拆解，带验证状态与推荐度 |
| 情报日报 | `docs/digest/` | 每日工具情报汇总（视频要点/新工具/验证结果/待办） |
| 视频要点 | `docs/videos/` | 只做视频总结、不拆解工具的条目 |
| 灵感笔记 | `docs/notes/` | 可借鉴到自有工具的具体做法与方法论沉淀 |

## 快速开始

```bash
npm install          # 安装依赖
npm run docs:dev     # 本地预览
npm run docs:build   # 构建静态站
pwsh publish.ps1     # 构建并推送到 gh-pages（发布）
```

## 发布机制

- `publish.ps1` 构建 VitePress → 推送到 `gh-pages` 分支 → GitHub Pages 自动托管
- 由「工具情报官」流水线每日自动执行
- 栏目索引（`<!-- XXX-INDEX:START -->` 标记内）由流水线自动维护，**不要手动编辑**

## 内容约定

- 工具拆解必须带：验证状态（✅/⚠️/❌）+ 推荐度（⭐1-5）
- 日报按日期命名：`YYYY-MM-DD-工具情报日报.md`
- 只收录经过验证的工具，未验证不收录

## 关联

- 仓库：[tool-intel-wiki](https://github.com/TEXXXXTURE/tool-intel-wiki)
- 开源知识库：[ai-knowledge-base](https://github.com/TEXXXXTURE/ai-knowledge-base)
