---
title: Java
date: 2026-02-25 21:42:59
categories:
  - 编程
tags:
  - Java
---
System.out.println();

Java传递对象类型（类、数组等），传递的是对象引用的副本。虽然是按值传递，但由于传递的是引用的副本，函数内可以通过这个引用修改对象的内部状态，但不能更改这个引用指向的对象本身。
SerializationUtils.clone(person); // 深拷贝

# Map
```aiignore
import java.util.HashMap;
import java.util.Map;

Map<String, Integer> map1 = new HashMap<>();
map1.put("A", 1);

// 合并
map1.putAll(map2);   // map2的键覆盖map1的键

```

# Set
```
// LinkedHashSet 保持插入顺序
// TreeSet 自然排序

import java.util.HashSet;
import java.util.Set;

public class SetExample {
    public static void main(String[] args) {
        // 创建一个 HashSet
        Set<String> set = new HashSet<>();

        // 添加元素
        set.add("Apple");
        set.add("Banana");
        set.add("Orange");

        // 尝试添加重复元素
        boolean isAdded = set.add("Apple");  // 返回 false，因为 "Apple" 已存在

        // 显示 Set 的内容
        System.out.println(set);  // 输出: [Banana, Orange, Apple]，注意顺序不保证

        // 判断是否包含某个元素
        boolean containsBanana = set.contains("Banana");  // 返回 true

        // 删除元素
        set.remove("Orange");

        // Set 的大小
        int size = set.size();  // 返回 2

        // 遍历 Set
        for (String item : set) {
            System.out.println(item);
        }
    }
}
```