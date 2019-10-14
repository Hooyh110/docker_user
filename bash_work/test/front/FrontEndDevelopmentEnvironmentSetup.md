# 前端开发环境搭建

## 安装 Node.js

- 安装 LTS 版 Node.js，[官网](https://nodejs.org)

* 设置 NPM 私服，解决国内访问 [NPM 官方源](https://www.npmjs.com/package/npm)慢的问题

```shell
npm config set registry https://registry.npm.taobao.org/
npm config set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver
npm config set operadriver_cdnurl http://cdn.npm.taobao.org/dist/operadriver
npm config set phantomjs_cdnurl https://npm.taobao.org/mirrors/phantomjs/
npm config set sass_binary_site https://npm.taobao.org/mirrors/node-sass/
npm config set electron_mirror https://npm.taobao.org/mirrors/electron/
npm config set selenium_cdnurl http://npm.taobao.org/mirrors/selenium
npm config set node_inspector_cdnurl https://npm.taobao.org/mirrors/node-inspector
npm config set PUPPETEER_DOWNLOAD_HOST https://npm.taobao.org/mirrors
```

- 安装 Yarn，替代 npm，提高依赖包安装速度，[最新版 Yarn](https://yarnpkg.com/zh-Hans/)

## 安装 VsCode

- 安装最新版 VsCode，[官网](https://code.visualstudio.com/)

[一键安装推荐插件和推荐设置](./QuickConfigureVsCode.md)

## 安装 Vue CLI 3

```bash
npm install -g @vue/cli
```

[Vue CLI 3 官网](https://cli.vuejs.org/zh/)

## 安装 Vue.js devtools

Chrome 扩展 [Vue.js devtools](https://chrome.google.com/webstore/detail/vuejs-devtools/nhdogjmejiglipccpnnnanhbledajbpd)

> 不能翻墙的从这离线安装：[Chrome 商店 Crx 离线安装包下载](https://cn.bing.com/search?q=Vue.js+devtools&q1=site%3Acrx4chrome.com)
