# 通用Mapper

## 组件信息

```xml
<dependency>
    <groupId>tk.mybatis</groupId>
    <artifactId>mapper-spring-boot-starter</artifactId>
    <version>2.0.2</version>
</dependency>
```

官方 Wiki：[https://github.com/abel533/Mapper/wiki](https://github.com/abel533/Mapper/wiki)

## 代码生成

参照 [http://git.huimaiche.com/Finance/security/tree/master/security-generator](http://git.huimaiche.com/Finance/security/tree/master/security-generator)

- `application-dev.properties` 配置连接串



- `generatorConfig.xml` 配置数据库表、主键，配置 entity、mapper xml、mapper 的包名



- 执行 Maven 插件 `mybatis-generator:generate` 命令生成代码


## Spring Boot 集成

### 添加依赖

```xml
<dependency>
    <groupId>tk.mybatis</groupId>
    <artifactId>mapper-spring-boot-starter</artifactId>
    <version>2.0.2</version>
</dependency>
```

### 配置

`bootstrap.yml` 导入公共配置，包括 mybatis、DB 链接串

```yaml
apollo:
  bootstrap:
    enabled: true
    namespaces: application,Hmc.spring.datasource.security,Hmc.finance.mybatis
```

`application.yml`

```yaml
mapper:
  mappers: com.huimaiche.security.mapper
mybatis:
  mapper-locations: classpath*:/com/huimaiche/*/mapper/*.xml
  type-aliases-package: com.huimaiche.*.entity
```

`UserProviderApplication.java`

```java
import tk.mybatis.spring.annotation.MapperScan;

@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients(basePackages = {"com.huimaiche"})
@ComponentScan(basePackages = "com.huimaiche")
@MapperScan(basePackages = "com.huimaiche.security.mapper")
public class UserProviderApplication {

    public static void main(String[] args) {
        SpringApplication.run(UserProviderApplication.class, args);
    }

}
```

## 使用

### 生成代码示例

`UserInfoMapper.java`

```java
package com.huimaiche.security.mapper;

import com.huimaiche.security.entity.UserInfo;
import tk.mybatis.mapper.common.Mapper;

public interface UserInfoMapper extends Mapper<UserInfo> {

}
```

`UserInfoMapper.xml`

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="com.huimaiche.security.mapper.UserInfoMapper" >
  <resultMap id="BaseResultMap" type="com.huimaiche.security.entity.UserInfo" >
    <!--
      WARNING - @mbg.generated
    -->
    <id column="user_id" property="userId" jdbcType="INTEGER" />
    <result column="category_id" property="categoryId" jdbcType="INTEGER" />
    <result column="user_name" property="userName" jdbcType="VARCHAR" />
    <result column="true_name" property="trueName" jdbcType="VARCHAR" />
    <result column="mobile" property="mobile" jdbcType="VARCHAR" />
    <result column="email" property="email" jdbcType="VARCHAR" />
    <result column="avatar" property="avatar" jdbcType="VARCHAR" />
    <result column="is_deleted" property="isDeleted" jdbcType="TINYINT" />
    <result column="create_user_id" property="createUserId" jdbcType="INTEGER" />
    <result column="create_time" property="createTime" jdbcType="TIMESTAMP" />
    <result column="modify_user_id" property="modifyUserId" jdbcType="INTEGER" />
    <result column="modify_time" property="modifyTime" jdbcType="TIMESTAMP" />
  </resultMap>
</mapper>
```

### 新建 Service

```java
@Service
public class UserInfoService {
    @Autowired
    private UserInfoMapper userInfoMapper;
}
```

### 基本查询

```java
Example example = new Example(UserInfo.class);
example.createCriteria()
        .andEqualTo(Fn.getName(UserInfo::getIsDeleted), 0);
example.orderBy(Fn.getName(UserInfo::getUserId)).asc();
List<UserInfo> list = userInfoMapper.selectByExample(example);
```

#### 动态 SQL

```java
Example example = new Example(UserInfo.class);
Example.Criteria criteria = example.createCriteria()
        .andEqualTo(Fn.getName(UserInfo::getIsDeleted), 0);
example.orderBy(Fn.getName(UserInfo::getUserId)).asc();
if (input.getUserId() != null) {
    criteria.andEqualTo(Fn.getName(UserInfo::getUserId), input.getUserId());
}
if (input.getCategoryId() != null) {
    criteria.andEqualTo(Fn.getName(UserInfo::getCategoryId), input.getCategoryId());
}
if (StringUtils.isNotBlank(input.getMobile())) {
    criteria.andLike(Fn.getName(UserInfo::getMobile), input.getMobile() + "%");
}
if (StringUtils.isNotBlank(input.getUserName())) {
    criteria.andLike(Fn.getName(UserInfo::getUserName), input.getUserName() + "%");
}
if (StringUtils.isNotBlank(input.getTrueName())) {
    criteria.andLike(Fn.getName(UserInfo::getTrueName), input.getTrueName() + "%");
}
List<UserInfo> list = userInfoMapper.selectByExample(example);
```

### 分页查询

```java
Example example = new Example(UserInfo.class);
Example.Criteria criteria = example.createCriteria()
        .andEqualTo(Fn.getName(UserInfo::getIsDeleted), 0);
example.orderBy(Fn.getName(UserInfo::getUserId)).asc();
if (input.getUserId() != null) {
    criteria.andEqualTo(Fn.getName(UserInfo::getUserId), input.getUserId());
}
if (input.getCategoryId() != null) {
    criteria.andEqualTo(Fn.getName(UserInfo::getCategoryId), input.getCategoryId());
}
if (StringUtils.isNotBlank(input.getMobile())) {
    criteria.andLike(Fn.getName(UserInfo::getMobile), input.getMobile() + "%");
}
if (StringUtils.isNotBlank(input.getUserName())) {
    criteria.andLike(Fn.getName(UserInfo::getUserName), input.getUserName() + "%");
}
if (StringUtils.isNotBlank(input.getTrueName())) {
    criteria.andLike(Fn.getName(UserInfo::getTrueName), input.getTrueName() + "%");
}
PageHelper.startPage(input.getPageIndex(), input.getPageSize());
List<UserInfo> list = userInfoMapper.selectByExample(example);
PageInfo pageInfo = new PageInfo<>(list);
```

### 添加记录

```java
UserInfo entity = aotuMapper.map(input, UserInfo.class);
entity.setIsDeleted((byte) 0);
entity.setCreateTime(new Date());
entity.setModifyTime(new Date());
userInfoMapper.insertSelective(entity);
userInfoMapper.insert(entity);
```

### 更新记录

```java
entity.setModifyTime(new Date());
userInfoMapper.updateByPrimaryKeySelective(entity);
userInfoMapper.updateByPrimaryKey(entity);
```

## 实体自动映射工具 Dozer

### 组件信息

```xml
<dependency>
    <groupId>net.sf.dozer</groupId>
    <artifactId>dozer</artifactId>
    <version>5.5.1</version>
</dependency>
```

### 使用

```java
@Service
public class UserInfoService {
    private DozerBeanMapper aotuMapper = new DozerBeanMapper();
}
```

input vo → entity

```java
public void addStaff(UserInfoInput input) {
    UserInfo entity = aotuMapper.map(input, UserInfo.class);
    entity.setCategoryId(1);
    entity.setIsDeleted((byte) 0);
    entity.setCreateTime(new Date());
    entity.setCreateUserId(0);
    entity.setModifyTime(new Date());
    entity.setModifyUserId(0);
    userInfoMapper.insertSelective(entity);
}
```

entity → output vo

```java
WxLoginVo model = autoMapper.map(userInfo, WxLoginVo.class);
model.setAccessToken(userToken.getAccessToken());
model.setExpire(userToken.getExpire());
```

列表映射

```java
List<UserInfo> list = userInfoMapper.selectByExample(example);
List<UserInfoOutput> data = list.stream()
        .map(it -> aotuMapper.map(it, UserInfoOutput.class))
        .collect(Collectors.toList());
return data;
```
