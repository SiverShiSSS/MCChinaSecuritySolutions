[English](MC-Mooncake-SSO-with-Global-Tenant-SAML.en.md) | [中文](MC-Mooncake-SSO-with-Global-Tenant-SAML.md)

## Monncake China租户对接全球租户 SAML SSO 方案（非官方）

> 适用场景：在中国云（Mooncake/世纪互联）中的 Microsoft Entra 租户（下称“MC 租户”）需要与全球 Azure（下称“全球租户”）通过 SAML 进行单点登录（SSO），MC租户作为SP，global租户作为真正的IDP，用户数据存储在Mooncake China，以合规地复用全球租户的身份与认证能力。可以与CCB2B配合使用，也可以按需求替换CCB2B。

> 重要声明：本方案为实践型绕行方案，非 Microsoft 官方支持特性，仅供参考与试点。请在非生产环境充分验证后再行上线。由此带来的风险与影响请自行评估与承担。

---

### 演示视频

优先使用 Raw 直链在线播放；若浏览器或 GitHub 预览受限，可使用仓库页面或下载到本地播放。

内嵌播放（使用 Raw 链接）：

<video src="https://raw.githubusercontent.com/SiverShiSSS/MCChinaSecuritySolutions/main/EntraID/MCSSOwithGBL/assets/demo.mp4" controls width="720">
  您的浏览器不支持内嵌视频。请使用下方“Raw 直链”或“仓库文件链接/下载”。
</video>

- Raw 直链（可右键另存/复制到播放器）：
  - https://raw.githubusercontent.com/SiverShiSSS/MCChinaSecuritySolutions/main/EntraID/MCSSOwithGBL/assets/demo.mp4
- 仓库文件页面（GitHub 界面查看/下载）：
  - https://github.com/SiverShiSSS/MCChinaSecuritySolutions/blob/main/EntraID/MCSSOwithGBL/assets/demo.mp4

相对路径（备用）：[./assets/demo.mp4](./assets/demo.mp4)

---

### 目录
- 背景与目标
- 方案架构概览
- 前置条件与边界
- 实施步骤
  - 在全球租户创建非图库 SAML2 应用并配置断言
  - 在 MC 租户配置域联合（Domain Federation）
  - ImmutableID 暴露与映射策略
  - 端到端验证
- 关键参数与属性要求
- 演示命令（PowerShell）
- 常见问题与排错
- 安全与合规注意事项
- 回滚与退出策略
- 参考链接

新增企业级章节：
- 方案价值与优势（Why this）
- 实施投入与交付物（Effort & Deliverables）
- 安全与合规控制强化（Controls）
- 风险与限制（Risks & Limits）
- 运维与监控（Ops & Monitoring）
- 发布与回滚计划（Release & Rollback）
- 决策清单（Decision Checklist）

---

## 背景与目标
- 目标：让 MC 租户用户在访问 MC 资源时，跳转到全球租户的 SAML 身份提供方（IdP）完成认证，并将 SAML 断言回传给 MC 租户实现登录。
- 动机：复用全球租户的现有身份、MFA 与治理能力；减少多地多套身份系统的建设与运维成本。

## 方案架构概览
- 全球租户：承载一个非图库 SAML2 企业应用（IdP 端配置），负责发起认证并签发 SAML 断言。
- MC 租户：对自有自定义域启用 “域联合（Federation）”，将被动登录/主动登录请求重定向至全球租户的 SAML 端点。
- 断言关键：SAML 响应中的 `NameID` 必须与 MC 租户中 Microsoft Entra 用户的 `ImmutableID` 一致；此外可携带 `IDPEmail` 等辅助属性。

逻辑流程（高层）：
1. 用户访问 MC 资源（如 MC 门户/应用）。
2. MC 租户基于域联合配置，将认证流转发至全球租户的 SAML 端点。
3. 用户在全球租户完成认证（含 MFA 策略）。
4. 全球租户向 MC 租户回送 SAML 断言，MC 租户校验签名与属性并完成会话建立。

## 方案价值与优势（Why this）
- 复用既有全球身份与策略：无需在 MC 重建一套完整 IdP/MFA/治理策略，降低建设与运维成本。
- 降低变更面：MC 端主要为“域联合”与入口切换，业务系统改造最小化。
- 合规可控：用户驻留在中国区，认证由全球租户执行，能在合规边界内达到风控与便利的平衡。
- 架构可回退：不侵入业务代码，出现问题时可快速切回托管模式（Managed）或原有路径。

## 实施投入与交付物（Effort & Deliverables）
- 投入类型：
  - 配置为主：通过 UI/Portal 与 Graph 脚本完成配置；无需部署应用代码。
  - 脚本自动化（可选）：将联邦配置、声明映射、测试校验封装为 PowerShell 脚本，便于复用与审计。
- 主要交付物：
  - 设计与差异说明文档（本文件 + 架构图）。
  - 全量联邦配置脚本与参数清单（含证书与端点）。
  - 验证用测试用例与通过截图/日志。
  - 运行手册与回滚手册。

> 是否需要“部署代码”？一般不需要。若需与现有应用网关/身份中间层联动，可补充少量自动化脚本，但不涉及业务应用代码改造。

## 前置条件与边界
- 拥有全球租户与 MC 租户的全局管理员或等效权限。
- MC 租户已验证自定义域名（例如：`contoso.cn`）。
- 可获取并维护全球租户 SAML 应用的签名证书（Base64/PEM）。
- 对 Azure 全球与世纪互联云环境的终端访问已打通（网络、DNS、代理）。
- 边界与限制：
  - 此方案不改变官方支持矩阵；部分控制面能力在世纪互联云可能存在差异。
  - `ImmutableID` 必须稳定、一致地在两边可计算/可流转，否则会导致登录不匹配。

## 实施步骤

### 步骤一：在全球租户创建非图库 SAML2 应用并配置断言
1. 在全球租户 `Microsoft Entra admin center` 创建“企业应用” → “非图库应用”。
2. 选择“基于 SAML 的单一登录”。
3. 配置 `Identifier(Entity ID)`、`Reply URL (Assertion Consumer Service URL)`、`Sign-on URL` 等（与 MC 域联合端点对应，详见下文命令中的被动/主动登录地址）。
4. 上传并启用签名证书（建议启用断言签名与加密，至少签名）。
5. 声明与映射：
   - 将 SAML `NameID` 设置为 MC 租户用户的 `ImmutableID` 对应值（详见“ImmutableID 暴露与映射策略”）。
   - 新增自定义声明 `IDPEmail`，值为用户 UPN（userPrincipalName）。
   - 其他所需声明按业务需求配置。

### 步骤二：在 MC 租户配置域联合（Domain Federation）
- 使用 Microsoft Graph PowerShell（MC 环境）为自定义域设置联合：
  - 配置 `IssuerUri`、被动/主动登录地址、元数据地址、签名证书、协议类型（SAML）。
  - 指向全球租户对应的登录与元数据端点。

### 步骤三：ImmutableID 暴露与映射策略（关键）
- 要求：SAML 响应中的 `NameID` 必须等于 MC 租户用户的 `ImmutableID`。
- 难点：企业应用默认不会直接暴露 `ImmutableID`，需将其稳定映射到可用的声明源：
  - 方案 A（推荐）：在全球租户为用户准备一个可同步/可计算的属性（如 `extensionAttributeX` 或自定义目录扩展），其值与 MC 中对应用户的 `ImmutableID` 一致；在 SAML 声明中将 `NameID` 指向该属性。
  - 方案 B：通过自建同步规则（如：Azure AD Connect/Cloud Sync/HR 驱动）在全球与 MC 之间对齐一个共同标识，并在全球租户应用声明中引用该标识。
- 注意：
  - 值长度≤64，需 URL/HTML 安全编码（如 `+` 编码为 `.2B`）。
  - 值必须稳定，任何变更会造成登录故障。

### 步骤四：端到端验证
1. 在全球租户中选择测试用户，确保其声明中的 `NameID` 解析为目标值。
2. 在 MC 租户中确认对应用户对象的 `ImmutableID` 值匹配。
3. 使用 MC 域账号登录，观察是否跳转至全球租户登录并成功返回。
4. 使用浏览器/网络跟踪工具（F12、Fiddler）验证 SAML 响应与断言内容。

## 关键参数与属性要求
- `NameID`：必须等于 MC 租户用户的 `ImmutableID`；最长 64 个字母数字字符；非 HTML 安全字符需编码（如 `+` → `.2B`）。
- `IDPEmail`：全球租户 SAML 响应中的元素，值为用户的 `userPrincipalName`（邮箱格式）。
- `Issuer`：为 IdP 的唯一 URI，必须与在 MC 租户联合配置中声明的一致；不可复用样例值。

参考：Microsoft Learn 的“必需属性”章节（见“参考链接”）。

## 安全与合规控制强化（Controls）
- 最小权限与分权：联邦配置、证书管理、声明映射分离角色；对变更强制审批、审计与告警。
- 密钥与证书：集中管理、定期轮换、到期前告警；证书存储与备份遵循企业密钥策略。
- 条件式访问：在 IdP 执行设备/网络/风险/地理位置等策略；MC 端配合会话控制。
- 日志与留痕：开启 MC/Global 侧审计日志与登录日志，集中到 SIEM（中国区可用方案）。

## 运维与监控（Ops & Monitoring）
- 指标：登录成功率、MFA 触发率、断言失败原因（NameID 不匹配、证书错误、Issuer 不一致）。
- 告警：证书到期、失败率飙升、端点不可达、声明变更。
- 演练：定期故障演练（回退到 Managed、证书轮换、端点切换）。

## 风险与限制（Risks & Limits）
- 功能可用性差异：世纪互联环境与全球在 API/控制面存在不对齐，需版本与可用性核对。
- 标识对齐困难：`ImmutableID` 不稳定或映射链路复杂会导致登录失败。
- 依赖跨云网络：需要保证到全球端点的稳定可达与带宽。

## 发布与回滚计划（Release & Rollback）
- 分阶段发布：灰度特定人群与应用，逐步扩大范围。
- 变更窗口：在非高峰期进行证书/端点/声明变更，预留回退窗口。
- 回滚快捷路径：保留 Managed 配置备份与脚本，必要时一键回退。

## 决策清单（Decision Checklist）
- 是否已确认业务系统无需改代码或仅需极少配置变更？
- 是否有稳定、可审计的 `ImmutableID` 对齐方案？
- 条件式访问与会话保护策略是否达标？
- 证书与密钥轮换计划是否完善并已演练？
- 监控与告警是否覆盖登录链路关键点？

## 演示命令（PowerShell）
> 在 MC 环境使用 Microsoft Graph PowerShell 执行，将占位符替换为你的实际值。

```powershell
# 示例：更新 MC 租户的域联合配置（请替换域名、租户/应用 ID、证书）
update-MgDomainFederationConfiguration \
  -DomainId "yourdomain.cn" \
  -IssuerUri "https://sts.windows.net/<GlobalTenantId>/" \
  -DisplayName "GlobalSAML-Fed" \
  -FederatedIdpMfaBehavior "rejectMfaByFederatedIdp" \
  -PassiveSignInUri "https://login.microsoftonline.com/<GlobalTenantId>/saml2" \
  -ActiveSignInUri  "https://login.microsoftonline.com/<GlobalTenantId>/saml2" \
  -SignOutUri       "https://login.microsoftonline.com/<GlobalTenantId>/saml2" \
  -MetadataExchangeUri "https://login.microsoftonline.com/<GlobalTenantId>/federationmetadata/2007-06/federationmetadata.xml?appid=<AppId>" \
  -SigningCertificate "<Base64-Encoded-Certificate>" \
  -preferredAuthenticationProtocol "saml"
```

> 说明：
> - `<GlobalTenantId>`：全球租户的租户 ID（GUID）。
> - `<AppId>`：全球租户 SAML 应用的应用程序 ID（应用对象的 AppId）。
> - `<Base64-Encoded-Certificate>`：SAML 应用的签名证书（Base64），建议定期轮换。

如你已验证过的真实命令样例（仅供参考，不可直接复用证书/ID）：
```powershell
update-MgDomainFederationConfiguration -DomainId sivershisss.biz -IssuerUri https://sts.windows.net/c9fc3f4b-049a-41fe-818e-f9d7d581a069/ -DisplayName "SiverTest3" -FederatedIdpMfaBehavior "rejectMfaByFederatedIdp" -PassiveSignInUri https://login.microsoftonline.com/c9fc3f4b-049a-41fe-818e-f9d7d581a069/saml2 -ActiveSignInUri https://login.microsoftonline.com/c9fc3f4b-049a-41fe-818e-f9d7d581a069/saml2 -SignOutUri https://login.microsoftonline.com/c9fc3f4b-049a-41fe-818e-f9d7d581a069/saml2 -MetadataExchangeUri https://login.microsoftonline.com/c9fc3f4b-049a-41fe-818e-f9d7d581a069/federationmetadata/2007-06/federationmetadata.xml?appid=0eb2f522-5370-41d0-a03d-0b183cc4c9d5  -SigningCertificate "MIIC8DCCAdigAwIBAgIQL4AcUIqXRbVJev0mQv4jjzANBgkqhkiG9w0BAQsFADA0MTIwMAYDVQQDEylNaWNyb3NvZnQgQXp1cmUgRmVkZXJhdGVkIFNTTyBDZXJ0aWZpY2F0ZTAeFw0yNTA5MTIwNjI0MDBaFw0yODA5MTIwNjI0MDBaMDQxMjAwBgNVBAMTKU1pY3Jvc29mdCBBenVyZSBGZWRlcmF0ZWQgU1NPIENlcnRpZmljYXRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnr0012idmhIszn2Bo04xYX8PciXzq3LNaIifrSPjwy3KGmvI4G3b2FRAuQa8YkFkZQxSDGsWaoJ/ezHQec5+xULEZVii/AG6JpRhboWjOjyiYSlOAnjDrihJUvc8ZQa/a3/sr057XPPuLhcbrMGdiVykaNSjt04qVO2Txs+SNa5Haa8WwrqKlcfSFpLn5jawvNQhGb8s9QVkEY/jHjgg9tzpwihT9s9oMhDDZUMLHeZFJwZZQcJPoBY705MZvLQLQi26E2zMWBydwj/L01hu3qtrfMkal0AOwXXom4WXhDNfe5l7tAQ1WOpEGcRMnnAqPDuQXTZ8QALPX+jabn53nQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBjEgEqqIzcwW4dPXFt3AE4Jo8y4XA/MgEmA4cjHasqP7ICtXj4UYjv0hiK2PrVc+rEWQRNZ+Uo9WBl0oivSqfK0I1WOtarzIfwSdyNH8cVfAOVgSqHpoNDYsQqDFFbQ6fCH/4gKF6PhYP84qYCnqVh+zhdvC1/ZwZrR5BfkGfDzwo5roeAhGo1+P7GHvu8BL7y3kb5g1sIa4JdCqcHwnPoHXWF6Z3lGEBAcdy0D7PA9vAXEdDG2rU3w3iuj7//P4pci1JPQW9SmeWNsBDTd5S+5nVvxMmEZdq0fMLont/GBtP/BWNr8Ild29g09lK8EDhWCJ01jHr8qscncDf0FIU3" -preferredAuthenticationProtocol "saml"
```

## 常见问题与排错
- 登录失败，错误为用户未找到：
  - 检查 `NameID` 是否与 MC 用户的 `ImmutableID` 完全一致（包括大小写与编码）。
  - 确认联合配置的 `IssuerUri` 与全球租户 SAML 应用的 `Issuer` 一致。
- MFA 行为与预期不符：
  - 检查 `FederatedIdpMfaBehavior` 设置；如需在 IdP 执行 MFA，请确保策略启用并与此参数匹配。
- 证书相关错误：
  - 确认证书为最新且未过期。更新证书后需同步更新 MC 联合配置与应用元数据。
- 端点 404/跳转错误：
  - 校验被动/主动登录地址、元数据地址是否使用全球租户真实 `TenantId` 与 `AppId`。

## 安全与合规注意事项
- 证书与密钥妥善管理，建立轮换计划与告警。
- 全局与 MC 两侧都应启用条件访问与必要的会话保护策略。
- 严控谁能修改 SAML 声明映射与联合配置，落地变更审批与审计。
- 谨慎对待跨云环境的网络与日志留存，避免数据越界与合规风险。

## 回滚与退出策略
- 变更前导出当前域联合配置（Graph 导出）以便快速回滚。
- 准备应急本地管理员账号，避免因联合失败而锁定租户。
- 回滚步骤：
  1) 暂时禁用或移除联合，将域改回托管模式（Managed）或恢复旧配置。
  2) 移除/禁用全球租户 SAML 应用的签发。

## 参考链接
- 必需属性说明（Microsoft Learn）：`https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/how-to-connect-fed-saml-idp#required-attributes`
- Microsoft Graph PowerShell（MC/世纪互联与全球环境的差异以官方文档为准）。

---

## 免责声明（必读）
本方案并非 Microsoft 官方支持的标准功能，而是基于实践经验总结的绕行方案。请在评估风险与影响后再行采用。作者不对因使用本方案而产生的任何问题负责。
