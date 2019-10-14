# 接口凭证

### 获取 accessToken

#### 基本信息

**Path：** /auth/getAccessToken

**Method：** GET

**接口描述：**
获取接口访问凭证

#### 请求参数

**Headers**

| 参数名称     | 参数值 | 是否必须 | 示例 | 备注             |
| ------------ | ------ | -------- | ---- | ---------------- |
| Accept       |        | 否       |      | application/json |
| Content-Type |        | 否       |      | application/json |

**Query**

| 参数名称  | 是否必须 | 示例 | 备注         |
| --------- | -------- | ---- | ------------ |
| appId     | 是       |      | 应用 ID      |
| appSecret | 是       |      | 应用凭证密钥 |

#### 返回数据

<table>
  <thead class="ant-table-thead">
    <tr>
      <th key=name>名称</th><th key=type>类型</th><th key=required>是否必须</th><th key=default>默认值</th><th key=desc>备注</th><th key=sub>其他信息</th>
    </tr>
  </thead><tbody className="ant-table-tbody"><tr key=0-0><td key=0><span style="padding-left: 0px"><span style="color: #8c8a8a"></span> code</span></td><td key=1><span>integer</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">编码</span></td><td key=5><p key=2><span style="font-weight: '700'">format: </span><span>int32</span></p></td></tr><tr key=0-1><td key=0><span style="padding-left: 0px"><span style="color: #8c8a8a"></span> message</span></td><td key=1><span>string</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">信息</span></td><td key=5></td></tr><tr key=0-2><td key=0><span style="padding-left: 0px"><span style="color: #8c8a8a"></span> result</span></td><td key=1><span>object</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">获取访问凭证结果类</span></td><td key=5></td></tr><tr key=0-2-0><td key=0><span style="padding-left: 20px"><span style="color: #8c8a8a">├─</span> accessToken</span></td><td key=1><span>string</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">访问凭证</span></td><td key=5></td></tr><tr key=0-2-1><td key=0><span style="padding-left: 20px"><span style="color: #8c8a8a">├─</span> expireTime</span></td><td key=1><span>string</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">访问凭证过期时间</span></td><td key=5><p key=4><span style="font-weight: '700'">format: </span><span>date-time</span></p></td></tr><tr key=0-2-2><td key=0><span style="padding-left: 20px"><span style="color: #8c8a8a">├─</span> expiresIn</span></td><td key=1><span>integer</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">凭证的有效时间（秒）</span></td><td key=5><p key=2><span style="font-weight: '700'">format: </span><span>int64</span></p></td></tr><tr key=0-3><td key=0><span style="padding-left: 0px"><span style="color: #8c8a8a"></span> success</span></td><td key=1><span>boolean</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">是否成功</span></td><td key=5></td></tr>
               </tbody>
              </table>

**注意事项：**

开发者需要缓存 accessToken，用于后续接口的调用（注意：不能频繁调用 getAccessToken 接口，否则会受到频率拦截）。当 accessToken 失效或过期时，需要重新获取。

accessToken 的有效期通过返回的 expiresIn 来传达，有效期内重复获取返回相同结果，过期后获取会返回新的 accessToken。

### accessToken 有效性测试

#### 基本信息

**Path：** /auth/hello

**Method：** GET

**接口描述：**

#### 请求参数

**Headers**

| 参数名称     | 参数值 | 是否必须 | 示例 | 备注             |
| ------------ | ------ | -------- | ---- | ---------------- |
| Accept       |        | 否       |      | application/json |
| Content-Type |        | 否       |      | application/json |

**Query**

| 参数名称    | 是否必须 | 示例 | 备注     |
| ----------- | -------- | ---- | -------- |
| accessToken | 是       |      | 访问凭证 |

#### 返回数据

<table>
  <thead class="ant-table-thead">
    <tr>
      <th key=name>名称</th><th key=type>类型</th><th key=required>是否必须</th><th key=default>默认值</th><th key=desc>备注</th><th key=sub>其他信息</th>
    </tr>
  </thead><tbody className="ant-table-tbody"><tr key=0-0><td key=0><span style="padding-left: 0px"><span style="color: #8c8a8a"></span> code</span></td><td key=1><span>integer</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">编码</span></td><td key=5><p key=2><span style="font-weight: '700'">format: </span><span>int32</span></p></td></tr><tr key=0-1><td key=0><span style="padding-left: 0px"><span style="color: #8c8a8a"></span> message</span></td><td key=1><span>string</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">信息</span></td><td key=5></td></tr><tr key=0-2><td key=0><span style="padding-left: 0px"><span style="color: #8c8a8a"></span> result</span></td><td key=1><span>string</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">返回数据</span></td><td key=5></td></tr><tr key=0-3><td key=0><span style="padding-left: 0px"><span style="color: #8c8a8a"></span> success</span></td><td key=1><span>boolean</span></td><td key=2>非必须</td><td key=3></td><td key=4><span style="white-space: pre-wrap">是否成功</span></td><td key=5></td></tr>
               </tbody>
              </table>
