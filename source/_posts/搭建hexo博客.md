---
title: 搭建hexo博客
categories: 
  - js
tags: 
  - hexo
  - blog
  - 新手村
number: 2
abbrlink: ee20
date: 2016/10/20
---

Hexo是一种使用Node.js编写的静态博客框架，快速、简洁、扩展丰富。本文介绍如何搭建Hexo博客，并部署到GitHub Page。
<!-- more -->

## 前言

个人认为，写博客是一个程序猿记录和总结的最好方式，虽然写博文没有使用笔记软件记录那么方便，需要更加严谨，但我觉得这其实是好事，可以迫使你更加认真的去钻研，而不只是浅尝辄止。长期坚持下来，可以改变你的学习态度，受益匪浅。

不过我本来并不打算写这篇博文，因为网上已经有太多的教程，没有必要重复造轮子。但是我在搭建过程遇到很多问题，花了不少时间，所以还是决定记录下来。

## 简介
[Hexo](https://hexo.io/zh-cn/)是一种使用[Node.js](http://nodejs.org/)编写的静态博客框架，快速、简洁、扩展丰富。

搭建完成后使用非常简单：
1. 在hexo项目目录下的\source\\_posts\中用[Markdown](http://markdown.tw/)语法写博文；
![qq 20190214100921](https://user-images.githubusercontent.com/17662451/52757598-306cfd00-3040-11e9-8859-2aae242647f7.png)
2. 生成静态文件（**Hexo**将MD文件其解析成HTML文件）并部署。
![qq 20190214101614](https://user-images.githubusercontent.com/17662451/52757969-81c9bc00-3041-11e9-83c4-98106ac34602.png)


## 搭建
本教程将**Hexo**部署到[GitHub Page](https://pages.github.com/) ，可以节省域名和空间的费用。

### 安装与配置Git
如果你是初次使用，安装时一路Next即可，然后打开`Git Bash`进行用户配置。
```bash
$  git config --global user.name 你的用户名
$  git config --global user.email 你的邮箱
```

生成SSH公钥。
```bash
$ ssh-keygen
```

首先 `ssh-keygen` 会确认密钥的存储位置（默认是 `.ssh/id_rsa`），然后它会要求你输入两次密钥口令。如果你不想在使用密钥，直接回车即可。
接下来使用`cat`命令查看公钥，下一步会用到。

```bash
$ cat ~/.ssh/id_rsa.pub
```

### 创建GitHub仓库
创建一个仓库，名称必须是`你的GitHub用户名.github.io`，例如我的是仓库名为`CloudyCity.github.io`。
然后进入*Setting*页面将上一步生成的公钥添加进去，以获得让你的电脑获得访问仓库的权限。


### 安装与配置Hexo
接下来就可以开始正题了，安装后使用**管理员身份**打开`Git Bash`。
```bash
$ npm install hexo-cli -g
```

进入你打算存放本地仓库的文件夹，初始化**Hexo**，并安装依赖。
```bash
$ hexo init
```

之后可以查看**Hexo**版本。
```bash
$ hexo -v
```

**Hexo 3.0** 之后需要另外安装`deployer`才能部署。
```bash
$ npm install hexo-deployer-git --save
```

现在可以先进行本地测试，首先生成静态页面。
```bash
$ hexo g
```

然后启用本地服务，用浏览器打开 [localhost:4000](localhost:4000)，如果没问题继续往下。
```bash
$ hexo s
```

打开**Hexo**文件夹下的*_config.yml*，这里只说明关于部署的配置项，其他配置项请移步至[Hexo文档](https://hexo.io/zh-cn/docs/configuration.html) 。
```bash
deploy:
  type: git
  repository: git@github.com:CloudyCity/CloudyCity.github.io.git
  branch: master
```

将这里的`repository`的值改为你的**GitHub**仓库的SSH地址即可。
激动人心的时刻来了，执行部署。
```bash
$ hexo d
```

如果你上面的步骤的都没问题的话，这时候在浏览器直接访问你的仓库名 (例:https://cloudycity.github.io) 就可以看到你的博客了。

###  上传Hexo的源码
打开**Hexo**文件夹，创建Git本地仓库
```bash
$ git init
```

创建新分支
```bash
$ git branch source
```

切换成source分支
```bash
$ git checkout source
```

追踪所有文件
```bash
$ git add .
```

提交更改（到本地仓库）
```bash
$ git commit -m 'first time upload source'
```

添加远程仓库，这里也是键入你的**GitHub**仓库的SSH地址
```bash
$ git remote add origin git@github.com:CloudyCity/CloudyCity.github.io.git
```

推送到远程仓库
```bash
$ git push origin source
```

如果没遇到问题，那恭喜你成功将**Hexo**源码推送到你在**GitHub**的名称为`你的GitHub用户名.github.io`的仓库的source分支中！这样以后你换一台设备亦可以继续写博文啦~（当然你还是需要添加新设备的公钥到**GitHub**中）

需要注意的是，因为文章存放在source分支中，所以每次写好一篇新文章，应该提交并推送到远程分支中。


### 下载Hexo的源码
这里假如你换了一台设备，打开你打算作为本地仓库的文件夹，创建本地仓库，生成与添加公钥的步骤不再赘述。

克隆远程仓库
```bash
$ git clone git@github.com:CloudyCity/CloudyCity.github.io.git
```

切换source分支
```bash
$ git checkout source
```

源码中的`package.json`已保存依赖信息，这里只需要自动安装即可。
```bash
$ npm install
```

这样子就再次搭建好**Hexo**环境啦~

## 最后
搭建完成只是开始，坚持用心写文章才是最难的，大家一起加油。
另外，hexo还有非常多好看的主题和有用的插件哦~
