---
title: C++
date: 2025-12-25 10:00:00
categories:
  - 编程
tags:
  - 编程
---
# 命名风格
struct/class：驼峰
函数/变量：下划线

# 基础操作

# String

```C++
// 获取String长度
s.size()    // size()来自STL容器统一接口, length()来自早期字符串库，两者功能相同，推荐使用size()
s.length()

// 截取
string t = s.substr(pos, len);   // 从pos开始，取len个字符

// 排序
sort(s.begin(), s.end());

// 二维数组按照a[0]从小到大排序
sort(meetings.begin(), meetings.end(), [](const vector<int>& x, const vector<int>& y) {
    return x[0] < y[0];
});

// char数组转string
string s;
s.push_back(c1);
s.push_back(c2);

// 逐个赋值
string base;
base.resize(2);
base[0] = a[x][y];
base[1] = a[x][y + 1];
避免使用s.push_back，每次都会构造string，耗时
```


# struct

```
struct Node {
    int x, y;
};

// struct默认继承权限为public，class默认继承权限为private，其余完全相同
// 竞赛简单数据结构，一般使用struct

// 定义比较规则 - 1 - 重写< - 绑定类型本身，简单但定死
struct Node {
    int id, cnt, t;
    bool operator<(const Node& o) const {  // true的排在后面
        if (t != o.t) return t > o.t;
        return id > o.id;
    }
};
priority_queue<Node> pq;

// 定义比较规则 - 2 - 自定义比较函数 - 排序规则可自由切换
struct Cmp {
    bool operator()(const Node& a, const Node& b) const { ... }
};
priority_queue<Node, vector<Node>, Cmp> pq;

```



# vector
编程比赛中，除全局数组外，一律推荐vector
```C++
// 初始化
vector<int> a;
vector<int> a(n);  //初始化为长度为n，初值为0的数组
vector<int> a(n, -1);  // 初始化为长度为n，初值为-1的数组
vector<vector<char>> a(n, vector<char>(n, '0'));  // n*n的二维矩阵
int a[128] = {};  // 固定长度初始化为0，最快



// 常用操作
a.push_back(x);   // 尾插
a.pop_back();     // 尾删
a.clear();        // 清空
a.empty();        // 是否为空
a.size();         // 元素个数

a.insert(a.begin(), x);  // 首部插入x，时间复杂度O(n)



// vector数组遍历

// 1. 带下标遍历 (需要下标，易越界)
for (int i = 0; i < v.size(); ++i) { }    

// 2. 范围for遍历 ( 简单，安全，但是无下标 )
for (int x : v) { }  // 只读
for (int &x : v) { }  // 读写

// 3. 迭代器遍历 (适用于所有容器)
for (auto it = v.begin(); it != v.end(); ++it) { }


// vector数组从大到小排序
#include <algorithm>
#include <functional>
sort(happiness.begin(), happiness.end(), greater<int>());

// 反转
reverse(nums.begin(), nums.end());
reverse(nums.begin() + l, nums.begin() + r)  // 反转a[l]到a[r-1]
```



# map
```
// 创建
map<int, int> mp;             // 按键值顺序排列
unordered_map<int, int> ump;  // 无序map，速度更快
初始为数组时，不需要初始化，直接插入即可

// 插入
mp[3] = 10;
mp.insert({5, 20});

// 访问
mp[key]              // 务必先检查是否存在，否则会报错

// 查找
mp.count(x);         // 是否存在（0/1）
mp.find(x);          // 返回迭代器

// 删除
mp.erase(x);         // 按 key
mp.erase(it);        // 按迭代器
mp.clear();

// 遍历
for (auto &p : mp) {
    // p.first, p.second
}

for (auto& [fir, sec] : mp) {
}

// 检查是否存在，存在才调数据
auto it = map.find(key);
if (it == map.end()) return false;
auto& on_list = it->second;

```


# priority_queue
```
// 定义
priority_queue<int> pq;                    // 大根堆
priority_queue<int, vector<int>, greater<int>> pq2; // 小根堆，vector是默认的底层容易，默认将小的放在下面，使用greater将大的放在下面

// 常用操作
pq.push(x);    // 插入
pq.pop();      // 删除堆顶
pq.top();      // 访问堆顶
pq.empty();
pq.size();

// 自定义比较（结构体）
struct Node {
    int x;
    bool operator<(const Node& o) const {
        return x < o.x; // 大根堆
    }
};
priority_queue<Node> pq;


```

# queue, deque
```aiignore
q.push(x);   // 入队
q.pop();     // 出队（不返回）
q.front();   // 队首
q.back();    // 队尾
q.empty();
q.size();

```

# set, unordered_set
```
判重 + 有序 → set
只判重 → unordered_set
需要重复 → multiset

set的底层是红黑树，只要求元素定义了小于号
unordered_set是哈希表，要求元素能计算哈希值，能判断相等
因此若元素为vector，只能用set

s.insert(x);
s.erase(x);
s.count(x);   // 0 或 1
s.find(x);    // 迭代器
for (int x : s) { }


// set转vector
vector<int> v(s.begin(), s.end());

```

# multiset
```aiignore
// multiset

multiset<int> s;
multiset<int, greater<int>> s2; // 降序

auto it = s.find(x);        // 任意一个 x
int cnt = s.count(x);      // x 的个数

s.erase(x);                // 删除所有 x
s.erase(it);               // 删除一个（迭代器）
s.erase(s.find(x));        // 删除一个 x（需存在）

int mn = *s.begin();  // 最小值
int mx = *s.rbegin();  // 最大值

auto l = s.lower_bound(x); // >= x
auto r = s.upper_bound(x); // > x

s.clear();  // 清空

插入 / 删除 / 查找：O(log n)
取最值：O(1)
```


# stack


# 常用算法
```
sort
stable_sort
binary_search
lower_bound
upper_bound
reverse
unique
```

# 时间优化建议

1. 函数参数尽量引用传递，特别是map和数组，减少拷贝时间
2. dfs一定要搭配记忆化搜索
