[English](Solution-Overview.en.md) | [中文](Solution-Overview.md)

# Cross-Cloud SSO 解决方案：Mooncake ⇆ Global

## 执行摘要

本解决方案为中国区客户提供了完整的跨云单点登录(SSO)架构，实现Microsoft Entra ID Mooncake与Global租户间的安全身份联合。通过SAML 2.0协议，支持双向身份认证流程，满足不同业务场景下的身份管理需求。

### 核心价值主张
- **🔒 增强安全性**: 利用全球领先的身份安全技术，实现跨云统一认证
- **🌐 合规保障**: 满足中国数据主权要求，确保身份数据本地化管理  
- **⚡ 用户体验**: 单点登录消除密码疲劳，提升工作效率
- **🤖 AI赋能转型**: 合规访问Microsoft AI产品组合，包括Azure OpenAI、Copilot Studio、Security Copilot
- **�️ 全面安全防护**: 无缝集成Defenders系列和Azure Sentinel，构建端到端安全防护体系
- **📊 智能数据治理**: 通过Microsoft Purview实现数据分类、合规监控和隐私保护
- **�🔧 灵活架构**: 支持混合云场景，适配多种业务模式和合规要求

---

## 解决方案架构

### 统一身份管理架构：Mooncake 作为身份提供者(IdP)

**最佳实践场景：总部在中国，主要业务系统部署在Mooncake，需要访问Global资源**

![架构图：Mooncake作为IdP的跨云SSO方案](./assets/upstream-view.png)

#### 架构优势
- **🏢 中国总部优先**: 身份管理中心在中国，符合本土化管理要求
- **🔐 统一安全控制**: Mooncake Entra ID统一管控身份认证和授权策略
- **🌍 全球资源访问**: 无缝访问Global侧M365服务和Azure资源
- **📋 合规性保障**: 核心身份数据存储在中国境内，满足数据主权要求
- **🤖 AI能力解锁**: 合规访问Azure OpenAI、Copilot Studio等前沿AI服务
- **🛡️ 企业级安全**: 集成Microsoft Defenders全家族和Azure Sentinel SIEM能力
- **📊 智能治理**: 通过Microsoft Purview实现跨云数据治理和合规监控
- **🔒 端到端加密**: 数据传输和存储全程加密，确保安全合规

#### 核心认证流程
1. **身份认证**: 用户在Mooncake Entra ID完成身份认证（含MFA/条件访问）
2. **SAML联合**: Mooncake作为IdP向Global租户发送SAML断言
3. **权限分配**: 用户获得Global侧Azure资源和企业应用访问权限
4. **统一体验**: 单点登录实现跨云无缝工作体验

#### 支持的服务范围

**Mooncake侧核心服务（身份源）：**
- Microsoft Entra ID（统一身份管理中心）
- Teams、Outlook、SharePoint、OneDrive（M365协作平台）
- Virtual Machine、Application Gateway、SQL Database（Azure基础设施）
- Storage Account、Key Vault（数据和安全服务）

**Global侧扩展服务（联合目标）：**
- **Microsoft 365全套服务**（Teams、Outlook、SharePoint、OneDrive）
- **Azure AI平台**（Azure OpenAI、AI Foundry、Machine Learning）
- **Copilot产品家族**（Microsoft 365 Copilot、Security Copilot、Copilot Studio）
- **安全运营中心**（Azure Sentinel、Microsoft Defenders全系列）
- **数据治理平台**（Microsoft Purview、Power BI）
- **企业应用程序和SaaS服务**
- **Azure全球区域资源**（计算、存储、网络、数据库）

---

## 🚀 数字化与AI转型加速器

### AI能力全面解锁
通过这个跨云SSO架构，中国企业可以在完全合规的前提下，充分利用Microsoft全球AI产品组合：

#### 🤖 生成式AI平台
- **Azure OpenAI Service**: 访问GPT-4、DALL-E、Codex等前沿大语言模型
- **AI Foundry**: 构建、部署和管理企业级AI应用
- **Copilot Studio**: 创建定制化的AI助手和智能工作流

#### 🧠 Microsoft Copilot生态
- **Microsoft 365 Copilot**: AI赋能的办公协作体验
- **Security Copilot**: AI驱动的安全运营和威胁分析
- **GitHub Copilot**: AI辅助编程和开发效率提升

### 🛡️ 零信任安全架构
基于身份联合的安全防护体系，实现全面的企业安全保障：

#### Microsoft Defenders全家族
- **Defender for Cloud**: 云原生安全态势管理
- **Defender for Endpoint**: 终端检测与响应(EDR)
- **Defender for Office 365**: 邮件和协作安全
- **Defender for Identity**: 身份威胁检测与保护

#### 安全运营中心(SOC)
- **Azure Sentinel**: 云原生SIEM/SOAR平台
- **威胁情报集成**: 全球威胁数据和本地化分析
- **自动化响应**: AI驱动的安全事件处置

### 📊 智能数据治理
- **Microsoft Purview**: 跨云数据发现、分类和保护
- **合规自动化**: 数据主权和隐私法规遵循
- **敏感数据保护**: 端到端的数据生命周期管理

> 💡 **关键优势**: 用户身份数据始终保留在中国境内，同时能够安全合规地访问Microsoft全球最先进的AI和安全产品，实现数字化转型与合规要求的完美平衡。

---

## 中国境内合规建议

### 数据主权合规清单

#### ✅ 身份数据本地化
- [ ] 确保用户主身份对象存储在中国境内(Mooncake)
- [ ] 验证身份认证日志存储在符合要求的数据中心
- [ ] 建立数据分类和标记机制，区分敏感身份信息

#### ✅ 网络安全法合规
- [ ] 实施数据出境安全评估流程
- [ ] 建立跨境数据传输审计机制
- [ ] 配置适当的数据加密和传输安全措施

#### ✅ 个人信息保护法(PIPL)合规
- [ ] 获得用户明确同意进行跨境身份验证
- [ ] 建立用户身份数据访问和删除机制
- [ ] 实施数据最小化原则，仅传输必要的身份声明

#### ✅ 关键信息基础设施保护
- [ ] 评估身份系统是否属于关键信息基础设施范畴
- [ ] 实施相应等级的安全保护措施
- [ ] 建立安全事件应急响应机制

### 技术合规框架

本解决方案在满足中国监管要求的同时，支持全球Microsoft服务访问：

#### 数据主权保护
- **🏢 身份数据本地化**: 用户主身份对象始终保留在中国境内(Mooncake)
- **🔐 受控数据流**: 仅必要的认证令牌跨境传输，非用户数据本身
- **📊 审计跟踪**: 跨境身份认证活动的完整可见性

#### 法规遵循
- **🛡️ 网络安全法**: 合规的数据处理和安全评估流程
- **🔒 个人信息保护法**: 用户同意机制和数据最小化原则
- **⚖️ 关键信息基础设施**: 企业系统适当的安全保护等级

#### 安全控制
- **🔑 强身份认证**: 多因素认证和条件访问策略
- **📈 持续监控**: 实时安全分析和事件响应
- **🛡️ 零信任架构**: 以身份为中心的安全模型，最小权限访问

---

## 下一步行动

如需详细技术实施指导，请参考我们的完整文档：

- **[技术实施指南](MC-Mooncake-SSO-with-Global-Tenant-SAML.md)** - 完整的SAML联合设置说明
- **[中国合规检查清单](China-Compliance-Checklist.md)** - 监管合规框架
- **[PowerShell自动化脚本](../AutomationScripts/)** - 即用型部署自动化
- **[架构图资源](./assets/)** - 详细技术架构资源

### 解决方案对比

| 方面 | Cross-Cloud SSO | Cross-Cloud B2B (CCB2B) |
|------|-----------------|-------------------------|
| **身份模型** | 联合身份管理 | 来宾用户协作 |
| **用户体验** | 无缝单点登录 | 基于邀请的访问 |
| **管理方式** | 集中身份控制 | 分布式来宾管理 |
| **合规性** | 源租户数据驻留 | 跨租户数据复制 |
| **主要用例** | 企业内部访问 | 跨组织资源共享 |

### 实施方法

本解决方案采用分阶段部署方法：

1. **规划与评估** - 业务需求和合规分析
2. **试点环境** - 测试环境搭建和验证
3. **应用集成** - 优先服务联合
4. **生产部署** - 大规模推广和监控
5. **持续优化** - 改进和扩展

---

## 支持资源

### 技术文档
- [详细实施指南](MC-Mooncake-SSO-with-Global-Tenant-SAML.md)
- [PowerShell自动化脚本](../AutomationScripts/)
- [架构图源文件](./assets/)

### 联系支持
- **Microsoft中国技术支持**: 通过Azure门户提交支持票据
- **合作伙伴支持**: 联系您的Microsoft合作伙伴
- **社区支持**: Microsoft Tech Community

---

*最后更新：2025年10月*


