---
title: hexo使用github issue存放文章与评论
categories: 
  - js
tags:
  - hexo
number: 3
abbrlink: '9414'
date: 2019-02-14 10:48:51
---

Hexo默认文章存放于source分支，没有评论系统，不过都可以通过插件进行扩展。本文介绍如何将hexo的文章与评论存放于Github Issue中。
<!-- more -->

## 使用github issue存放评论
这么做有两大好处：
1. 新增文章不需要提交推送
2. 可以直接使用GitHub的图床

### 安装插件
```bash
$ npm install hexo-migrator-github-issue --save
```
### 新建issue文章
![qq 20190214112539](https://user-images.githubusercontent.com/17662451/52760542-daea1d80-304a-11e9-88e6-b8a479c359ea.png)

使用GitHub图床非常简单，把图片文件拖到编辑框就行了~

### 导入文章
```bash
$ hexo migrate github-issue 你的Github用户名/你存放hexo的仓库名
```
例如
```bash
$ hexo migrate github-issue CloudyCity/CloudyCity.github.io
```
然后生成部署即可。

## 使用github issue存放评论
hexo的评论插件选择比较多，我使用这款插件的作者好像弃坑了，大家自行选择。

### 安装插件
我这里使用的是Next主题，自带gitment，无需另外安装。

### 创建授权应用
![qq 20190214114441](https://user-images.githubusercontent.com/17662451/52766577-88b4f680-3062-11e9-8750-65328503bfa5.png)
[点击这里](https://github.com/settings/applications/new)创建，名称随意，两个url都填hexo博客的url，创建完成就得到应用ID和密钥。

### 创建新仓库
在GitHub中创建一个新仓库，其issue将用于存放评论。

### 配置
在Next主题的配置文件`_config.yaml`中更改以下配置
```yaml
gitment:
    enable: true
    githubID: 你的github用户名
    repo: 刚刚创建的仓库名
    ClientID: 应用ID
    ClientSecret: 密钥
    lazy: false
```

然后在hexo根目录下`/node_modules/gitment/dist/gitment,js`中将以下内容（这个服务接口是作者自己搭建的，已经停止了）
```JavaScript
utils.http.post('https://gh-oauth.imsun.net', {
```
修改为
```JavaScript
_utils.http.post('https://github.com/login/oauth/access_token', {
```

还有其他问题可以参照[这篇文章](https://www.wenjunjiang.win/2017/07/02/gitment%E8%AF%84%E8%AE%BA%E6%A8%A1%E5%9D%97%E6%8E%A5%E5%85%A5hexo/)修复

## 最后
如果大家觉得上面两个插件好用的话可以去给插件的项目点个星支持开发者哦~
[hexo-migrator-github-issue](https://github.com/Yikun/hexo-migrator-github-issue)
[gitment](https://github.com/imsun/gitment)