---
title: Weibo spider
date: 2025-06-11 23:17:53
categories:
  - 爬虫
tags:
---



# 初步检查

1. 获取个人关注列表
2. 获取博主博文列表
    > https://weibo.com/ajax/statuses/mymblog?uid=1699432410&page=1&feature=0
    > 
    > 接口按照最新博文返回，每次返回十条
3. 获取博文信息 - 图片列表

# 获取思路
1. 获取博主列表，和最近获取时间
2. 循环博主，获取全部未爬取博文的信息
3. 从旧往新循环，每次更新记录