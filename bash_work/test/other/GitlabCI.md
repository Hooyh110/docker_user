# Gitlab 持续集成配置

## GitLab CI 介绍

文档：http://git.huimaiche.com/help/ci/quick_start/README.md

## 安装 GitLab Runner

文档：http://git.huimaiche.com/help/ci/runners/README.md

## 配置 `.gitlab-ci.yml`

文档：http://git.huimaiche.com/help/ci/yaml/README.md

### 前端样例

http://git.huimaiche.com/MaiCheWang/WebSites/HuiMaiChe.Contract/HuiMaiChe.Contract.OpApp/blob/master/.gitlab-ci.yml

```yaml
stages:
  - build
  - deploy

before_script:
  - |
    chcp 65001
  - |
    set RepoDir= %cd%

build_Dll:
  stage: build
  script:
    - |
      echo "yarn install..."
    - |
      call yarn install
    - |
      echo "build Dll..."
    - |
      call npm run dll
  only:
    - master
  when:  manual
  cache:
    paths:
    - node_modules/
    - libs/

build_OpApp:
  stage: build
  script:
    - |
      echo "yarn install..."
    - |
      call yarn install
    - |
      if NOT EXIST "libs" (echo "build Dll..." && call npm run dll)
    - |
      echo "build OpApp Sit..."
    - |
      call npm run build:sit
    - |
      echo "build OpApp Prod..."
    - |
      call npm run deploy:prod
  only:
    - master
  cache:
    paths:
    - node_modules/
    - libs/
  artifacts:
    paths:
    - dist

deploy_Sit_OpApp:
  stage: deploy
  script:
    - |
      echo "Deploy OpApp dist\sit..."
    - |
      robocopy .\dist\sit \\192.168.10.159\webroot\productsites\op\HMCContractOpApp /E /XF *.config & if %errorlevel% leq 7 set errorlevel=0
  environment:
    name: Sit_OpApp
    url: http://test2.op.maiche.biz/HMCContractOpApp
  only:
    - master
  when:  manual

deploy_Prod_OpApp:
  stage: deploy
  script:
    - |
      echo "Deploy OpApp dist\prod..."
    - |
      robocopy .\dist\prod \\172.17.2.57\webroot\huimaiche.com\op\HMCContractOpApp /E /XF *.config & if %errorlevel% leq 7 set errorlevel=0
  environment:
    name: Prod_OpApp
    url: http://opy.huimaiche.com/HMCContractOpApp
  only:
    - master
  when:  manual
```

### 服务端样例

http://git.huimaiche.com/MaiCheWang/WebSites/HuiMaiChe.Contract/HuiHaiChe.Contract.Server/blob/master/.gitlab-ci.yml

```yaml
stages:
  - build
  - deploy

before_script:
  - |
    chcp 65001
  - |
    set RepoDir= %cd%

build_WebApi:
  stage: build
  script:
    - |
      echo "Fetch Lib..."
    - |
      if EXIST "..\..\..\Lib\.git" (cd ..\..\..\Lib & git pull git@git.huimaiche.com:MaiCheWang/Lib.git & cd %RepoDir%) else (git clone git@git.huimaiche.com:MaiCheWang/Lib.git ..\..\..\Lib)
    - |
      echo "Fetch Common..."
    - |
      if EXIST "..\..\Common\.git" (cd ..\..\Common & git pull git@git.huimaiche.com:MaiCheWang/WebSites/Common.git & cd %RepoDir%) else (git clone git@git.huimaiche.com:MaiCheWang/WebSites/Common.git ..\..\Common)
    - |
      nuget restore "HuiHaiChe.Contract.Server.sln"
    - |
      echo "build Web&Api Release..."
    - |
      MSBuild /consoleloggerparameters:ErrorsOnly /maxcpucount /nologo /property:Configuration=Release /p:DeployOnBuild=true /verbosity:quiet "Src\HuiHaiChe.Contract.Server\HuiHaiChe.Contract.Server.csproj"
    - |
      echo "copy Document xml..."
    - |
      robocopy .\Src\HuiHaiChe.Contract.Server\bin .\Src\HuiHaiChe.Contract.Server\obj\Release\Package\PackageTmp\bin "HuiHaiChe.Contract.*.xml" & if %errorlevel% leq 7 set errorlevel=0
  only:
    - master
  cache:
    paths:
    - Src/packages/
  artifacts:
    paths:
    - Src\HuiHaiChe.Contract.Server\obj\Release\Package\PackageTmp

deploy_Sit_WebApi:
  stage: deploy
  script:
    - |
      echo "Deploy Web&Api package..."
    - |
      robocopy .\Src\HuiHaiChe.Contract.Server\obj\Release\Package\PackageTmp \\192.168.10.159\webroot\productsites\op\HMCContract /E /XF log4net.config Web.config & if %errorlevel% leq 7 set errorlevel=0
  environment:
    name: Sit_WebApi
    url: http://test2.op.maiche.biz/HMCContract
  only:
    - master
  when:  manual

deploy_Prod_WebApi:
  stage: deploy
  script:
    - |
      echo "Deploy Web&Api package..."
    - |
      robocopy .\Src\HuiHaiChe.Contract.Server\obj\Release\Package\PackageTmp \\172.17.2.57\webroot\huimaiche.com\op\HMCContract /E /XF log4net.config Web.config & if %errorlevel% leq 7 set errorlevel=0
  environment:
    name: Prod_WebApi
    url: http://op.huimaiche.com/HMCContract
  only:
    - master
  when:  manual
```
