---
title: Linux
date: 2026-02-25 22:24:30
categories:
tags:
---


# 文件与目录
```aiignore
ls -l            # 列出目录
pwd              # 当前路径
cd /path         # 切换目录
mkdir dir        # 创建目录
rm -rf dir       # 删除目录
cp a b           # 复制
mv a b           # 移动/重命名

du -sh           # 当前文件夹内文件总大小
du -sh --block-size=G *   # 以MB为单位显示各文件大小
```


vi
```aiignore
i → 编辑
Esc → 退出编辑
:wq → 保存退出
:q! → 强制退出

```

chmod
600
700