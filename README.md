[English](README.en.md) | [中文](README.md)

# MC China Security Solutions

🚧 **项目状态：持续开发中** | **Status: Under Active Development** 🚧

面向中国客户的商业与安全合规、运营（Operations）需求，通过对技术与解决方案的系统性探索与沉淀，提供在中国（21V Mooncake）场景下可落地、可复用的最佳实践与参照实现。本仓库会持续覆盖微软的安全与身份相关产品与能力，并结合中国区平台特性与限制进行适配与优化。

## 🎯 目标与原则
- **聚焦中国（21V Mooncake）环境**：优先验证和输出在中国运营环境下可行的设计与实现
- **兼顾全球/中国双环境互通**：在合规边界内探索与全球租户、全球服务的集成方式与限制点
- **强调可操作性**：提供架构说明、配置步骤、脚本与样例，以便快速落地
- **安全与合规优先**：遵循数据驻留、合规要求与最小权限原则，强调可审计与可运维

## 📋 覆盖范围（持续扩展）

### 🔐 身份与访问（Identity & Access）
- **Microsoft Entra ID**（含 21V Mooncake 环境差异与最佳实践）
- **单点登录**（SAML/OIDC）、条件式访问、多重身份验证、特权身份管理（PIM）
- **跨租户/跨云集成模式**（在合规边界内与限制条件下）

### 🛡️ 安全产品与能力
- **威胁防护**（Defender 家族在中国区的可用性与替代方案分析）
- **基础设施安全**（网络隔离、WAF、防火墙、密钥与证书管理、密钥保管）
- **日志与监控**（在中国区可用的日志采集、告警与运营方案）

### 📊 治理与合规（Governance & Compliance）
- **角色与权限**、基线策略、变更与配置合规
- **数据驻留**、跨境传输考量与整改路径

> ⚠️ **重要提示**：由于不同阶段中国区与全球的功能/API 可用性存在差异，具体落地建议以 21V Mooncake 实际可用为准，并在文档中标注差异与替代方案。

## 📁 仓库结构

### 🌟 重点解决方案
- **`EntraID/MCSSOwithGBL/`** - 🔥 **跨云SSO解决方案**
  - Mooncake与Global租户间的SAML单点登录集成
  - 📖 [解决方案概览](EntraID/MCSSOwithGBL/Solution-Overview.md) | [English](EntraID/MCSSOwithGBL/Solution-Overview.en.md)
  - 📋 [技术实施指南](EntraID/MCSSOwithGBL/MC-Mooncake-SSO-with-Global-Tenant-SAML.md)
  - 🏛️ [架构图](EntraID/MCSSOwithGBL/assets/upstream-view.png)

### 🔧 自动化脚本与工具
- **`EntraID/AutomationScripts/`** - PowerShell自动化脚本集
  - 身份管理、同步、安全配置等场景的自动化工具

### 🚀 其他安全解决方案（已创建结构）
- **`DefenderForCloud&Sentinel/`** - 云安全与SIEM解决方案 📂 *待开发*
- **`EOP(DefenderForOffice)/`** - Office 365安全防护 📂 *待开发*
- **`Intune/`** - 移动设备管理与安全（含部分自动化脚本）
- **`M365/`** - Microsoft 365综合安全方案 📂 *待开发*
- **`Purview/`** - 数据治理与合规 📂 *待开发*
- **`PenetrationTest/`** - 渗透测试与安全评估 📂 *待开发*

## 🚧 开发状态

| 解决方案模块 | 状态 | 完成度 | 说明 |
|-------------|-----|-------|-----|
| **EntraID跨云SSO** | ✅ **已完成** | 90% | 核心架构与实施指南完整 |
| EntraID自动化脚本 | 🔄 **开发中** | 60% | 部分脚本可用，持续增加 |
| Intune移动设备管理 | 📂 **已创建** | 15% | 基础脚本可用，架构规划中 |
| Defender for Cloud & Sentinel | � **已创建** | 0% | 文件夹已创建，待开发 |
| EOP (Defender for Office) | � **已创建** | 0% | 文件夹已创建，待开发 |
| M365综合安全方案 | 📂 **已创建** | 0% | 文件夹已创建，待开发 |
| Purview数据治理 | 📂 **已创建** | 0% | 文件夹已创建，待开发 |
| 渗透测试与安全评估 | 📂 **已创建** | 0% | 文件夹已创建，待开发 |

## 🤝 贡献与反馈

欢迎提交 Issues 和 Pull Requests 来改进解决方案质量。

### 贡献指南
1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📞 支持与联系

- 📧 **技术支持**: 通过 Issues 提交技术问题
- 📖 **文档反馈**: 欢迎提交文档改进建议
- 🔗 **商业咨询**: 请联系相关Microsoft团队或合作伙伴

---

**最后更新**: 2025年10月 | **维护团队**: Microsoft China Security Solutions

后续将按照能力域（Identity、Network Security、Threat Protection、Governance）持续扩展子目录与样例。

## 快速开始
1. 克隆仓库
   ```bash
   git clone https://github.com/SiverShiSSS/MCChinaSecuritySolutions.git
   cd MCChinaSecuritySolutions
   ```
2. 环境前提
   - 已准备 21V Mooncake 订阅或租户账户（以及必要的全局/中国双环境账户用于对比与联调）
   - PowerShell 7+/Git 已安装，必要时可使用代理或中国区网络以访问中国云端点
3. 阅读对应能力域的目录与文档，按步骤进行配置与验证

### 在 21V Mooncake（中国）使用 Graph 的注意事项
- PowerShell 连接 Graph：
  - 委托模式：`Connect-MgGraph -Environment china -Scopes "<所需Scopes>"`
  - 应用（服务主体）模式：`Connect-MgGraph -Environment china -TenantId <TenantId> -ClientSecretCredential $credential`
- 端点差异：
  - 登录颁发：`https://login.chinacloudapi.cn`
  - Graph API：`https://microsoftgraph.chinacloudapi.cn`
  - `.default` 作用域：`https://microsoftgraph.chinacloudapi.cn/.default`
  - 若文档出现全球端点（如 `graph.microsoft.com`），请替换为上面的中国区端点。

## 贡献方式（Contributing）
- 欢迎通过 Issues 反馈需求/问题，或提交 Pull Request 贡献文档与样例
- 建议遵循：
  - 以中国区（21V Mooncake）可落地为第一优先级
  - 在文档中明确标注与全球环境的差异、限制与替代方案
  - 提交前尽量提供最小可复现步骤与截图/示例

## 路线图（Roadmap）
- 身份领域：更多 SSO/SAML/OIDC 场景、跨租户访问、条件式访问与 PIM 实操
- 安全领域：网络安全基线、WAF/AFW 参考架构、证书与密钥管理样例
- 运营与合规：日志采集与告警、基线策略与合规评估、运行手册与演练剧本
- 基础设施即代码（IaC）：面向中国云端点的 Bicep/Terraform 示例（逐步添加）

## 免责声明（Disclaimer）
本仓库内容旨在技术探索与参考，不构成法律或合规意见。由于平台能力随时间变化，请以官方文档与实际环境验证为准。在实施任何安全与合规变更前，请于测试环境充分验证并评估对业务的影响。

