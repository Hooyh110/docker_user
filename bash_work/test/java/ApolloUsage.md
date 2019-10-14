# Apollo配置中心使用

## 介绍

官方 wiki

[Apollo 配置中心介绍](https://github.com/ctripcorp/apollo/wiki/Apollo%E9%85%8D%E7%BD%AE%E4%B8%AD%E5%BF%83%E4%BB%8B%E7%BB%8D)

[Apollo 使用指南](https://github.com/ctripcorp/apollo/wiki/Apollo%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97)

## 管理页面

Apollo 管理页面 Portal ：[http://apollo.maiche.biz/](http://apollo.maiche.biz/)

[Apollo 项目列表](./ApolloAppList.md)

## Java 客户端使用指南

官方 wiki ：[Java 客户端使用指南](https://github.com/ctripcorp/apollo/wiki/Java客户端使用指南)

Meta Server 信息

```ini
dev_meta=http://192.168.10.35:8080
fat_meta=http://192.168.10.34:8080
uat_meta=http://172.17.2.202:8080
pro_meta=http://172.17.2.203:8080
```

### pom 文件添加依赖

> 需要先设置 Maven 私服镜像，因为 Apollo 客户端 Jar 包含了上述 Meta Server 信息

```xml
<dependency>
    <groupId>com.ctrip.framework.apollo</groupId>
    <artifactId>apollo-client</artifactId>
    <version>0.10.2</version>
</dependency>
```

### 设置 AppId

添加 `/META-INF/app.properties` 文件，如

```ini
app.id=finance-provider
```

参照官方 wiki [appid](https://github.com/ctripcorp/apollo/wiki/Apollo%E9%85%8D%E7%BD%AE%E4%B8%AD%E5%BF%83%E4%BB%8B%E7%BB%8D)

### 设置 Environment

添加 `C:\opt\settings\server.properties` 文件。

参照官方 wiki [environment](https://github.com/ctripcorp/apollo/wiki/Java%E5%AE%A2%E6%88%B7%E7%AB%AF%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97#122-environment)

### 注入配置

`bootstrap.properties` 配置。

```ini
apollo.bootstrap.enabled=true
apollo.bootstrap.namespaces=application,Hmc.spring.datasource
```

```yaml
apollo:
  bootstrap:
    enabled: true
    namespaces: application,Hmc.spring.datasource
```

> Hmc.spring.datasource 是在 Apollo 管理页面添加的 公共 namespace

参照官方 wiki [在 spring-boot 初始 bootstrap 阶段注入配置](https://github.com/ctripcorp/apollo/wiki/Java%E5%AE%A2%E6%88%B7%E7%AB%AF%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97#3213-%E5%9C%A8spring-boot%E5%88%9D%E5%A7%8Bbootstrap%E9%98%B6%E6%AE%B5%E6%B3%A8%E5%85%A5%E9%85%8D%E7%BD%AE)

> Properties 格式与 YAML 格式转换工具：(http://www.toyaml.com/)[http://www.toyaml.com/]

### 用法

- @Value

```java
@Value("${value}")
String value;
```

- @ConfigurationProperties

```java
@Bean
@ConfigurationProperties(prefix="spring.datasource")
public DataSource dataSource() {
    return new DataSource();
}
```

更多参照官方 wiki [客户端用法](https://github.com/ctripcorp/apollo/wiki/Java%E5%AE%A2%E6%88%B7%E7%AB%AF%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97#%E4%B8%89%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%94%A8%E6%B3%95)

### 更多用法

- 用法 1

定义配置类

```java
@Configuration
@Data
public class AppConfig {
    /**
     * 有超级登录权限的用户白名单列表(逗号分隔用户ID)
     */
    @Value("${user.provider.superLoginWhiteList}")
    private String superLoginWhiteList;
}
```

使用

```java
@RestController
public class UserController {
    @Autowired
    private AppConfig appConfig;
}
```

- 用法 2

定义配置类

```java
@Configuration
@ConfigurationProperties(prefix = "common.jwttoken")
@Data
public class JwtTokenProperties {
    /**
     * Jwt签名密钥
     */
    private String secretKey;

    /**
     * Token有效期，单位秒
     */
    private long ttlSeconds;


    /**
     * 签发者
     */
    private String issuer;
}
```

使用

```java
@Component
public class JwtTokenFactory {
    @Autowired
    private JwtTokenProperties properties;
}
```

## 敏感配置加密方案

参照 [spring-boot-encrypt](https://github.com/ctripcorp/apollo-use-cases/blob/master/spring-boot-encrypt) 实现 Apollo 中存储加密配置。

敏感配置项(如生产环境的数据库连接串、外部 API 调用 Token 等)加密后存储到 Apollo 中，Spring Boot 应用使用组件 [jasypt-spring-boot](https://github.com/ulisesbocchio/jasypt-spring-boot) 自动解密配置项。

### pom 文件添加依赖

```xml
<dependency>
    <groupId>com.github.ulisesbocchio</groupId>
    <artifactId>jasypt-spring-boot-starter</artifactId>
    <version>1.16</version>
</dependency>
```

### 配置解密密钥

`bootstrap.properties` 配置解密密钥 `jasypt.encryptor.password`。

```yaml
jasypt:
  encryptor:
    password: ${JASYPT_ENCRYPTOR_PASSWORD:nopassword}
```

配置说明：

生产环境配置 JVM 环境变量 `JASYPT_ENCRYPTOR_PASSWORD`。

开发、仿真环境使用默认值 `nopassword`。

### 加密配置项的生成

- 下载解压 `Jasypt Cli` ：[http://www.jasypt.org/download.html](http://www.jasypt.org/download.html)

- 加密配置项，如下

```shell
$encrypt input=datasource_password password=nopassword algorithm=PBEWithMD5AndDES

----ENVIRONMENT-----------------

Runtime: Oracle Corporation Java HotSpot(TM) 64-Bit Server VM 25.144-b01

----ARGUMENTS-------------------

algorithm: PBEWithMD5AndDES
input: datasource_password
password: nopassword

----OUTPUT----------------------

F6WrTTSVNHYUK+XTCbQbvROWnlmL1Acp/jgRdWrFZ98=
```

参数说明：

`input`：要加密的配置项

`password`：加密密钥

`algorithm`：加密算法，固定 `PBEWithMD5AndDES`

- Apollo 中配置加密后的字符串，如下

```ini
spring.datasource.password = ENC(F6WrTTSVNHYUK+XTCbQbvROWnlmL1Acp/jgRdWrFZ98=)
```

- 解密验证

```shell
$decrypt input=F6WrTTSVNHYUK+XTCbQbvROWnlmL1Acp/jgRdWrFZ98= password=nopassword algorithm=PBEWithMD5AndDES

----ENVIRONMENT-----------------

Runtime: Oracle Corporation Java HotSpot(TM) 64-Bit Server VM 25.144-b01

----ARGUMENTS-------------------

algorithm: PBEWithMD5AndDES
input: F6WrTTSVNHYUK+XTCbQbvROWnlmL1Acp/jgRdWrFZ98=
password: nopassword

----OUTPUT----------------------

datasource_password
```
