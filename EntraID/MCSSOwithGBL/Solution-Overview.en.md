[English](Solution-Overview.en.md) | [中文](Solution-Overview.md)

# Cross-Cloud SSO Solution: Mooncake ⇆ Global

## Executive Summary

This solution provides China-based customers with a comprehensive cross-cloud Single Sign-On (SSO) architecture, enabling secure identity federation between Microsoft Entra ID Mooncake and Global tenants. Leveraging SAML 2.0 protocol, it supports bidirectional authentication flows to meet identity management requirements across diverse business scenarios.

### Core Value Propositions
- **🔒 Enhanced Security**: Leverage world-class identity security technology for unified cross-cloud authentication
- **🌐 Compliance Assurance**: Meet China's data sovereignty requirements with localized identity data management
- **⚡ User Experience**: Single sign-on eliminates password fatigue and improves productivity
- **🤖 AI-Powered Transformation**: Compliant access to Microsoft AI portfolio including Azure OpenAI, Copilot Studio, and Security Copilot
- **🛡️ Comprehensive Security Protection**: Seamless integration with Defenders family and Azure Sentinel for end-to-end security
- **📊 Intelligent Data Governance**: Achieve data classification, compliance monitoring, and privacy protection through Microsoft Purview
- **🔧 Flexible Architecture**: Support hybrid cloud scenarios and adapt to various business models and compliance requirements

---

## Solution Architecture

### Unified Identity Management: Mooncake as Identity Provider (IdP)

**Best Practice Scenario: China-headquartered enterprises with primary business systems on Mooncake, requiring Global resource access**

![Architecture: Cross-Cloud SSO with Mooncake as IdP](./assets/upstream-view.png)

#### Architecture Advantages
- **🏢 China-First Approach**: Identity management center in China, aligning with local governance requirements
- **🔐 Unified Security Control**: Mooncake Entra ID centrally manages authentication and authorization policies
- **🌍 Global Resource Access**: Seamless access to Global M365 services and Azure resources
- **📋 Compliance Assurance**: Core identity data stored within China borders, meeting data sovereignty requirements
- **🤖 AI Capability Unlock**: Compliant access to Azure OpenAI, Copilot Studio, and other cutting-edge AI services
- **🛡️ Enterprise-Grade Security**: Integration with Microsoft Defenders family and Azure Sentinel SIEM capabilities
- **📊 Intelligent Governance**: Cross-cloud data governance and compliance monitoring through Microsoft Purview
- **🔒 End-to-End Encryption**: Full encryption for data transmission and storage, ensuring security compliance

#### Core Authentication Flow
1. **Identity Authentication**: User completes authentication in Mooncake Entra ID (including MFA/Conditional Access)
2. **SAML Federation**: Mooncake as IdP sends SAML assertion to Global tenant
3. **Permission Assignment**: User gains access to Global Azure resources and enterprise applications
4. **Unified Experience**: Single sign-on enables seamless cross-cloud work experience

#### Supported Service Scope

**Mooncake Core Services (Identity Source):**
- Microsoft Entra ID (Unified Identity Management Center)
- Teams, Outlook, SharePoint, OneDrive (M365 Collaboration Platform)
- Virtual Machine, Application Gateway, SQL Database (Azure Infrastructure)
- Storage Account, Key Vault (Data and Security Services)

**Global Extended Services (Federation Target):**
- **Microsoft 365 Complete Suite** (Teams, Outlook, SharePoint, OneDrive)
- **Azure AI Platform** (Azure OpenAI, AI Foundry, Machine Learning)
- **Copilot Product Family** (Microsoft 365 Copilot, Security Copilot, Copilot Studio)
- **Security Operations Center** (Azure Sentinel, Microsoft Defenders full series)
- **Data Governance Platform** (Microsoft Purview, Power BI)
- **Enterprise Applications and SaaS Services**
- **Azure Global Region Resources** (Compute, Storage, Network, Database)

---

## 🚀 Digital Transformation & AI Acceleration

### Comprehensive AI Capability Unlock
Through this cross-cloud SSO architecture, Chinese enterprises can fully utilize Microsoft's global AI product portfolio while maintaining complete compliance:

#### 🤖 Generative AI Platform
- **Azure OpenAI Service**: Access to cutting-edge large language models like GPT-4, DALL-E, and Codex
- **AI Foundry**: Build, deploy, and manage enterprise-grade AI applications
- **Copilot Studio**: Create customized AI assistants and intelligent workflows

#### 🧠 Microsoft Copilot Ecosystem
- **Microsoft 365 Copilot**: AI-powered office collaboration experience
- **Security Copilot**: AI-driven security operations and threat analysis
- **GitHub Copilot**: AI-assisted programming and development productivity enhancement

### 🛡️ Zero Trust Security Architecture
Identity federation-based security protection system for comprehensive enterprise security assurance:

#### Microsoft Defenders Full Family
- **Defender for Cloud**: Cloud-native security posture management
- **Defender for Endpoint**: Endpoint detection and response (EDR)
- **Defender for Office 365**: Email and collaboration security
- **Defender for Identity**: Identity threat detection and protection

#### Security Operations Center (SOC)
- **Azure Sentinel**: Cloud-native SIEM/SOAR platform
- **Threat Intelligence Integration**: Global threat data with localized analysis
- **Automated Response**: AI-driven security incident handling

### 📊 Intelligent Data Governance
- **Microsoft Purview**: Cross-cloud data discovery, classification, and protection
- **Compliance Automation**: Data sovereignty and privacy regulation adherence
- **Sensitive Data Protection**: End-to-end data lifecycle management

> 💡 **Key Advantage**: User identity data always remains within China's borders while enabling secure, compliant access to Microsoft's most advanced global AI and security products, achieving the perfect balance between digital transformation and compliance requirements.

---

## China Compliance Recommendations

### Data Sovereignty Compliance Checklist

#### ✅ Identity Data Localization
- [ ] Ensure user master identity objects are stored within China (Mooncake)
- [ ] Verify identity authentication logs are stored in compliant data centers
- [ ] Establish data classification and labeling mechanisms for sensitive identity information

#### ✅ Cybersecurity Law Compliance
- [ ] Implement data export security assessment processes
- [ ] Establish cross-border data transfer audit mechanisms
- [ ] Configure appropriate data encryption and transmission security measures

#### ✅ Personal Information Protection Law (PIPL) Compliance
- [ ] Obtain explicit user consent for cross-border identity authentication
- [ ] Establish user identity data access and deletion mechanisms
- [ ] Implement data minimization principles, transmitting only necessary identity claims

#### ✅ Critical Information Infrastructure Protection
- [ ] Assess whether the identity system falls under critical information infrastructure
- [ ] Implement corresponding level security protection measures
- [ ] Establish security incident emergency response mechanisms

### Technical Compliance Framework

This solution addresses key China regulatory requirements while enabling global Microsoft services access:

#### Data Sovereignty Protection
- **🏢 Identity Data Localization**: User master identity objects remain within China borders (Mooncake)
- **🔐 Controlled Data Flow**: Only necessary authentication tokens cross borders, not user data
- **📊 Audit Trail**: Complete visibility into cross-border authentication activities

#### Regulatory Alignment
- **🛡️ Cybersecurity Law**: Compliant data handling and security assessment processes
- **🔒 PIPL Compliance**: User consent mechanisms and data minimization principles
- **⚖️ Critical Infrastructure**: Appropriate security protection levels for enterprise systems

#### Security Controls
- **🔑 Strong Authentication**: Multi-factor authentication and conditional access policies
- **📈 Continuous Monitoring**: Real-time security analysis and incident response
- **🛡️ Zero Trust Architecture**: Identity-centric security model with least privilege access

---

## Next Steps

For detailed technical implementation guidance, please refer to our comprehensive documentation:

- **[Technical Implementation Guide](MC-Mooncake-SSO-with-Global-Tenant-SAML.en.md)** - Complete SAML federation setup instructions
- **[China Compliance Checklist](China-Compliance-Checklist.md)** - Regulatory compliance framework
- **[PowerShell Automation Scripts](../AutomationScripts/)** - Ready-to-use deployment automation
- **[Architecture Diagrams](./assets/)** - Detailed technical architecture resources

### Solution Comparison

| Aspect | Cross-Cloud SSO | Cross-Cloud B2B (CCB2B) |
|--------|-----------------|-------------------------|
| **Identity Model** | Federated identity management | Guest user collaboration |
| **User Experience** | Seamless single sign-on | Invitation-based access |
| **Management** | Centralized identity control | Distributed guest management |
| **Compliance** | Source tenant data residency | Data replication across tenants |
| **Primary Use Case** | Enterprise internal access | Cross-organizational sharing |

### Implementation Approach

This solution follows a phased deployment methodology:

1. **Planning & Assessment** - Business requirements and compliance analysis
2. **Pilot Environment** - Test environment setup and validation
3. **Application Integration** - Priority services federation
4. **Production Deployment** - Full-scale rollout with monitoring
5. **Optimization** - Continuous improvement and expansion

---

## Support Resources

### Technical Documentation
- [Detailed Implementation Guide](MC-Mooncake-SSO-with-Global-Tenant-SAML.en.md)
- [PowerShell Automation Scripts](../AutomationScripts/)
- [Architecture Diagram Source Files](./assets/)

### Support Contacts
- **Microsoft China Technical Support**: Submit support tickets through Azure portal
- **Partner Support**: Contact your Microsoft partner
- **Community Support**: Microsoft Tech Community

---

*Last Updated: October 2025*
