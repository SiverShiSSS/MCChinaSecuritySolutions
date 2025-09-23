[English](README.en.md) | [中文](README.md)

# MC China Security Solutions

面向中国客户的商业与安全合规、运营（Operations）需求，通过对技术与解决方案的系统性探索与沉淀，提供在中国（21V Mooncake）场景下可落地、可复用的最佳实践与参照实现。本仓库会持续覆盖微软的安全与身份相关产品与能力，并结合中国区平台特性与限制进行适配与优化。

## 目标与原则
- 聚焦中国（21V Mooncake）环境：优先验证和输出在中国运营环境下可行的设计与实现。
- 兼顾全球/中国双环境互通：在合规边界内探索与全球租户、全球服务的集成方式与限制点。
- 强调可操作性：提供架构说明、配置步骤、脚本与样例，以便快速落地。
- 安全与合规优先：遵循数据驻留、合规要求与最小权限原则，强调可审计与可运维。

## 覆盖范围（持续扩展）
- 身份与访问（Identity & Access）
  - Microsoft Entra ID（含 21V Mooncake 环境差异与最佳实践）
  - 单点登录（SAML/OIDC）、条件式访问、多重身份验证、特权身份管理（PIM）
  - 跨租户/跨云集成模式（在合规边界内与限制条件下）
- 安全产品与能力
  - 威胁防护（示例：Defender 家族在中国区的可用性与替代方案分析）
  - 基础设施安全（网络隔离、WAF、防火墙、密钥与证书管理、密钥保管）
  - 日志与监控（在中国区可用的日志采集、告警与运营方案）
- 治理与合规（Governance & Compliance）
  - 角色与权限、基线策略、变更与配置合规
  - 数据驻留、跨境传输考量与整改路径

> 注：由于不同阶段中国区与全球的功能/API 可用性存在差异，具体落地建议以 21V Mooncake 实际可用为准，并在文档中标注差异与替代方案。

## 仓库结构
- `EntraID/MCSSOwithGBL/`：与全球租户进行 SSO 的探索与实践（SAML 等）。
  - 参考文档：`EntraID/MCSSOwithGBL/MC-Mooncake-SSO-with-Global-Tenant-SAML.md`

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

