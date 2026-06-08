---
title: Hello World
---


## 使用指南

### 创建笔记
``` bash
$ hexo new "My New Post"
```

### 本地启动（sever）
``` bash
$ hexo s
```

### 生成静态文件（generate）
``` bash
$ hexo g
```

### 远端部署（deploy）
``` bash
$ hexo d
```

### 清理缓存
```bash
$ hexo clean
```

### 一键部署
```bash
$ hexo clean && hexo g && hexo d
```

### 子站（不建议本地部署，无法加载样式）
```bash
$ hexo clean
$ hexo g --config .\_config.uw.yml
```
