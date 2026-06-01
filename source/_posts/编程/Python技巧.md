---
title: Python技巧
date: 2025-05-18 19:11:01
categories:
  - 编程
tags:
  - Python
---

### .py文件双击打开,不弹出终端界面
右键使用终端打开文件夹,使用```python xxx.py```启动文件。

### .py文件使用pyinstaller库打包.exe
````Python
Pyinstaller -F py_word.py  # 打包exe

Pyinstaller -F -w py_word.py # 不带控制台的打包
````