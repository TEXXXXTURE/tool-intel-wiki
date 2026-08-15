import { defineConfig } from 'vitepress'

export default defineConfig({
  title: '工具情报官',
  description: '精选工具拆解 · 情报日报 · 视频要点 · 灵感笔记',
  lang: 'zh-CN',
  lastUpdated: true,
  themeConfig: {
    nav: [
      { text: '首页', link: '/' },
      { text: '精选工具', link: '/tools/' },
      { text: '情报日报', link: '/digest/' },
      { text: '视频要点', link: '/videos/' },
      { text: '灵感笔记', link: '/notes/' },
    ],
    sidebar: {
      '/tools/': [
        { text: '精选工具', link: '/tools/', items: [] },
      ],
      '/digest/': [
        { text: '情报日报', link: '/digest/', items: [] },
      ],
      '/videos/': [
        { text: '视频要点', link: '/videos/', items: [] },
      ],
      '/notes/': [
        { text: '灵感笔记', link: '/notes/', items: [] },
      ],
    },
    outline: { label: '本页', level: [2, 3] },
    docFooter: { prev: '上一篇', next: '下一篇' },
    search: {
      provider: 'local',
      options: {
        translations: {
          button: { buttonText: '搜索', buttonAriaLabel: '搜索' },
          modal: {
            noResultsText: '未找到相关结果',
            resetButtonTitle: '清除查询',
            footer: { selectText: '选择', navigateText: '切换', closeText: '关闭' },
          },
        },
      },
    },
    footer: {
      message: '由「工具情报官」流水线自动生成 · 拆解内容基于公开信息，使用前请自行核实',
    },
  },
})
