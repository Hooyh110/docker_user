---
sidebar: auto
---

# 编码指南

## 概述

本页面用于摘录项目开发中需要注意点，包括并不限于编码规范、问题总结、实践实例等。

## Git 规范

#### 实名 git 账号信息

设置姓名、公司邮箱，[起步-初次运行-Git-前的配置](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%88%9D%E6%AC%A1%E8%BF%90%E8%A1%8C-Git-%E5%89%8D%E7%9A%84%E9%85%8D%E7%BD%AE)

设置头像，[Gravatar](https://cn.gravatar.com/)

#### 每次提交的改动尽量小

如只包含一个 bug 的修复、一个功能的添加

#### 提交记录的描述尽量详细，不能为空或者从简

[提交描述规范参考](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)

#### 勤拉代码，尽量避免提交线分叉

推荐使用 rebase 模式拉代码。

推荐 git 客户端 GitKraken，[下载链接](https://www.gitkraken.com/download)

#### 删除不需要了的代码段，而不是注释

#### 不提交包含敏感信息的文件

如账号密码、服务器 IP 等

## 前端项目规范

### 参考

[Vue 官方风格指南](https://cn.vuejs.org/v2/style-guide/)

### 样式规范

#### 不使用行内样式，而是定义 class

#### 总是使用 class 选择器

不使用元素选择器、:first-child、:nth-child(n)等伪类选择器

#### class 命名使用 kebab-case

#### 图片、Icon 等资源文件命名使用 snake_case

#### 页面中不定义全局样式

需要时可以使用深度作用选择器替代。

### Vue 规范

#### 组件文件命名使用 CamelCase

#### 组件标签命名使用 CamelCase

#### 页面路由命名使用 CamelCase

#### 模版中的 JS 语句也要格式化

如 `v-if`、`v-show`、`v-for`、`{{}}`、`:prop`、`@event` 中的 JS 语句

## Java 项目规范

### 参考

[唯品会 Java 开发手册](https://vipshop.github.io/vjtools/#/standard/)

[阿里巴巴 Java 开发手册](https://github.com/alibaba/p3c)

### 日志规范

#### 使用日志组件输出日志，不使用 `Throwable.printStackTrace()`、`System.out`

### DAO 规范

#### 一个实体的 Mapper 实例只在它的 Service 实例中使用，禁止在多个 Service 中使用

#### 不使用 Mapper 的 delete\* 方法，使用 update 方法逻辑删除

#### 不使用 Mapper 的 updateByPrimaryKey 方法，使用 updateByPrimaryKeySelective 更新部分字段

#### 如果要强制更新字段为 NULL，Mapper 继承接口 UpdateByPrimaryKeySelectiveForceMapper，使用 updateByPrimaryKeySelectiveForce
