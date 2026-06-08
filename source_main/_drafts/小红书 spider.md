---
title: 小红书 爬虫
date: 2025-04-22 01:54:56
categories:
  - 爬虫
tags:
  - 小红书
---

# 初期分析
1. 博主列表获取
无接口，电脑端无法查询关注列表，只能在excel内预填博主id
2. 博主笔记列表获取
   笔记概览接口：user_posted
   
   检查发现第一次调用user_posted接口时，cursor参数为第31条博文
   > user_posted?num=30&cursor=6729821b00000000190191a3&user_id=5ac8b22d4eacab6adf1f6a5e
   > &image_formats=jpg,webp,avif&xsec_token=ABCKlGmFDtmAfZb_f3V0xPcyKnJfFssk0Y_hEGRltB-cM%3D&xsec_source=pc_note
   
   > user_posted?num=30&cursor=66603c55000000000e0317b1&user_id=5ac8b22d4eacab6adf1f6a5e
   > &image_formats=jpg,webp,avif&xsec_token=ABCKlGmFDtmAfZb_f3V0xPcyKnJfFssk0Y_hEGRltB-cM%3D&xsec_source=pc_note
   
预先获得了第30条博文的id，然后通过user_posted接口，获取其后三十条数据

3. 笔记内容与图片/视频获取
   笔记详情接口：feed
   评论内容：page?note_id=684030d2000000002300f2a6


博主id：5ac8b22d4eacab6adf1f6a5e

6426cdff000000001303c8b5
6863ca56000000000d0274aa
685d11cb0000000010024bf1
68496a26000000002301e21a
684030d2000000002300f2a6

# 步骤分析
1. 手动获取博主id与最旧一条博文id
2. 根据最旧博文id，使用user_posted接口获取三十条博文，再根据第30条博文id继续往后获取