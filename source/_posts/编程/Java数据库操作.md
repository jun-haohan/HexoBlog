---
title: Java数据库操作
date: 2026-02-24 16:24:08
categories:
  - 编程
tags:
  - Java
  - 数据库
---

Mongo聚合查询
```aiignore
public class MyResultType {
    private int totalCount;
    private int uniqueUserCount;

    // Getters and Setters
}


import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.GroupOperation;
import org.springframework.data.mongodb.core.aggregation.MatchOperation;
import org.springframework.data.mongodb.core.aggregation.ProjectionOperation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.util.Map;
import java.util.List;

public class YourService {

    @Autowired
    private MongoTemplate mongoTemplate;

    public void yourMethod() {
        // 定义筛选条件
        MatchOperation matchOperation = Aggregation.match(
            Criteria.where("field1").is(value1)
                    .and("field2").is(value2)
                    // 添加其他条件
        );

        // 在统计之前保留userID
        ProjectionOperation projectOperation = Aggregation.project()
            .andInclude("userID");

        // 统计唯一用户量
        GroupOperation uniqueUserCountOperation = Aggregation.group("userID")
            .count().as("userNums");

        // 最终的投影操作，组合结果
        ProjectionOperation finalProjection = Aggregation.project()
            .and("userNums").as("userNums");

        // 组合聚合操作
        Aggregation aggregation = Aggregation.newAggregation(
            matchOperation,              // 第一步：筛选
            projectOperation,            // 第二步：保留userID
            uniqueUserCountOperation,    // 第三步：统计唯一用户量
            finalProjection              // 第四步：组合结果
        );

        // 执行聚合查询
        AggregationResults<Map> results = mongoTemplate.aggregate(aggregation, "collectionName", Map.class);
        List<Map> resultList = results.getMappedResults();

        // 解析结果
        Map<String, Object> result = resultList.get(0);
        int userNums = (int) result.get("userNums");

        // 使用结果
        System.out.println("Unique User Numbers: " + userNums);
    }
}




import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationOperation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import java.util.List;
import java.util.Map;

// 定义返回结果的类
public class TotalResult {
    private long firTotal;
    private long secTotal;

    // Getters and Setters
}

public TotalResult calculateTotals() {
    // 构建统计 code = "1" 的聚合操作
    AggregationOperation firTotalOperation = Aggregation.match(Criteria.where("code").is("1"))
        .group().sum("quantity").as("firTotal");
    
    // 构建统计 code = "2" 的聚合操作
    AggregationOperation secTotalOperation = Aggregation.match(Criteria.where("code").is("2"))
        .group().sum("quantity").as("secTotal");

    // 使用 facet 将两个聚合操作结合在一起
    Aggregation aggregation = Aggregation.newAggregation(
        Aggregation.facet(firTotalOperation).as("firTotalResult")
                  .and(secTotalOperation).as("secTotalResult")
    );

    // 执行聚合查询
    AggregationResults<Map> result = mongoTemplate.aggregate(aggregation, "yourCollectionName", Map.class);

    // 从结果中提取 firTotal 和 secTotal
    Map firTotalResult = ((List<Map>) result.getMappedResults().get(0).get("firTotalResult")).stream().findFirst().orElse(Map.of());
    Map secTotalResult = ((List<Map>) result.getMappedResults().get(0).get("secTotalResult")).stream().findFirst().orElse(Map.of());

    // 构建返回对象
    TotalResult totalResult = new TotalResult();
    totalResult.setFirTotal(firTotalResult.get("firTotal") != null ? (long) firTotalResult.get("firTotal") : 0L);
    totalResult.setSecTotal(secTotalResult.get("secTotal") != null ? (long) secTotalResult.get("secTotal") : 0L);

    return totalResult;
}
```

本地与mongo服务器之间的通信消耗较高，因此要尽可能减少与服务器的通信次数，减少重复查询