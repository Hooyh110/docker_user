# Maven 包管理

## 设置私服镜像

修改 maven 配置文件 `settings.xml`，目录在用户目录（`%UserProFile%`）下的 `.m2` 目录。

```sh
cd %UserProFile%/.m2
code settings.xml
```

在 `mirrors` 中加入。

```xml
<mirror>
  <id>hmcmaven</id>
  <name>huimaiche maven</name>
  <url>http://nexus.huimaiche.com/repository/maven-public/</url>
  <mirrorOf>central</mirrorOf>
</mirror>
```

完整配置下载：[settings.xml](https://gitlab.com/xmcar/devnote/raw/master/assets/settings.xml)

## 发布

在项目 pom 或父 pom 文件，添加发布仓库地址。

```xml
<distributionManagement>
	<repository>
		<id>releases</id>
		<url>${releases.repo}</url>
	</repository>
	<snapshotRepository>
		<id>snapshots</id>
		<url>${snapshots.repo}</url>
	</snapshotRepository>
</distributionManagement>
```

修改 maven 配置文件 `settings.xml`，添加发布仓库的账号。

在 `servers` 中加入。

```xml
<server>
  <id>releases</id>
  <username>hmc_maven</username>
  <password>hmc4maven</password>
</server>
<server>
  <id>snapshots</id>
  <username>hmc_maven</username>
  <password>hmc4maven</password>
</server>
```

在 `profiles` 中加入。

```xml
<profile>
  <id>dev</id>
  <activation>
    <activeByDefault>true</activeByDefault>
  </activation>
  <properties>
    <releases.repo>http://nexus.huimaiche.com/repository/maven-releases/</releases.repo>
    <snapshots.repo>http://nexus.huimaiche.com/repository/maven-snapshots/</snapshots.repo>
  </properties>
</profile>
```

完整配置下载：[settings.xml](https://gitlab.com/xmcar/devnote/raw/master/assets/settings.xml)

在项目目录执行 maven  发布命令，上传至私服。

```sh
mvn clean deploy -DskipTests
```

