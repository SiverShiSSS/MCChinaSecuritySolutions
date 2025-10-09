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

## Role-Based Solution Perspectives

| Role                | English Overview Link                                   | 中文概述链接                                   |
|---------------------|--------------------------------------------------------|------------------------------------------------|
| CIO (Chief Information Officer)      | [CIO Overview (EN)](Solution-Overview-CIO.en.md)      | [CIO 概述 (中文)](Solution-Overview-CIO.md)      |
| CISO (Chief Information Security Officer) | [CISO Overview (EN)](Solution-Overview-CISO.en.md)    | [CISO 概述 (中文)](Solution-Overview-CISO.md)    |
| Security Manager    | [Security Manager Overview (EN)](Solution-Overview-SecurityManager.en.md) | [安全经理概述 (中文)](Solution-Overview-SecurityManager.md) |
| CFO (Chief Financial Officer) | [CFO Overview (EN)](Solution-Overview-CFO.en.md) | [CFO 概述 (中文)](Solution-Overview-CFO.md) |

---

### CIO Perspective

**Digital Transformation & Business Value**
- Accelerate enterprise digital transformation with cross-cloud SSO architecture, supporting global business expansion and local compliance.
- Seamless access to China and Global resources, improving employee productivity and collaboration.
- Compliant integration with Microsoft AI products (Copilot, OpenAI), driving innovation and intelligent operations.
- Flexible architecture supports diverse business models, reducing IT operational complexity and cost.
- Secure, stable cross-cloud connectivity via ExpressRoute/VPN ensures business continuity for mission-critical workloads.

**Key Objectives & Interests (KOI):**
- ROI, business agility, compliance, innovation enablement, digital leadership
**Motivation:**
- Drive transformation, enable global growth, reduce operational risk, empower teams

---

### CISO Perspective

**Security & Compliance Assurance**
- End-to-end identity security architecture with MFA, Conditional Access, and Zero Trust.
- Core identity data localization meets China data sovereignty and compliance requirements.
- Integrated Microsoft Defenders, Sentinel, Purview for threat detection, response, and data governance.
- Network security: ExpressRoute/VPN ensures encrypted and isolated cross-cloud data transmission.
- Comprehensive audit, monitoring, and compliance reporting for incident response and regulatory review.

**Key Objectives & Interests (KOI):**
- Data sovereignty, threat protection, compliance, auditability, risk management
**Motivation:**
- Minimize risk, ensure regulatory alignment, protect enterprise assets, enable secure innovation

---

### Security Manager Perspective

**Daily Security Operations & Management**
- Simplified identity management with unified cross-cloud authentication and access control.
- Automated security policies and compliance checks for operational efficiency.
- Centralized monitoring and alerting via SIEM/SOAR (Sentinel) for rapid incident response.
- Flexible network connectivity (ExpressRoute/VPN) adapts to existing enterprise network architecture.
- Detailed operational guides and automation scripts reduce human error risk.

**Key Objectives & Interests (KOI):**
- Operational efficiency, automation, monitoring & alerting, operational control, incident response
**Motivation:**
- Streamline daily operations, reduce manual workload, improve response speed, maintain compliance

---

### CFO Perspective

**Financial Optimization & Risk Control**
- Optimize IT and security spend with unified cross-cloud architecture, reducing duplication and overhead.
- Enable cost transparency and predictability for cloud resources and security investments.
- Support compliance-driven cost avoidance (fines, audit failures) and business continuity.
- Leverage Microsoft’s global scale for better pricing, licensing, and support.
- Facilitate financial planning for digital transformation and AI adoption.

**Key Objectives & Interests (KOI):**
- Cost control, financial transparency, risk mitigation, compliance cost avoidance, value realization
**Motivation:**
- Maximize ROI, minimize financial risk, support strategic growth, ensure budget alignment

---

## Solution Architecture

### Unified Identity Management: Mooncake as Identity Provider (IdP)

**Best Practice Scenario: China-headquartered enterprises with primary business systems on Mooncake, requiring Global resource access**

![Architecture: Cross-Cloud SSO with Mooncake as IdP](./assets/upstream-view.png)

#### Architecture Advantages
- **🏢 China-First Approach**: Identity management center in China, aligning with local governance requirements
- **🔐 Unified Security Control**: Mooncake Entra ID centrally manages authentication and authorization policies
- **🌍 Global Resource Access**: Seamless access to Global M365 services and Azure resources
- **� Flexible Connectivity**: Multiple network options including VPN Gateway and ExpressRoute for secure cross-cloud connections
- **�📋 Compliance Assurance**: Core identity data stored within China borders, meeting data sovereignty requirements
- **🤖 AI Capability Unlock**: Compliant access to Azure OpenAI, Copilot Studio, and other cutting-edge AI services
- **🛡️ Enterprise-Grade Security**: Integration with Microsoft Defenders family and Azure Sentinel SIEM capabilities
- **📊 Intelligent Governance**: Cross-cloud data governance and compliance monitoring through Microsoft Purview
- **🔒 End-to-End Encryption**: Full encryption for data transmission and storage, ensuring security compliance
- **⚡ Optimized Performance**: Dedicated network paths via ExpressRoute for enhanced performance and reliability

#### Core Authentication Flow
1. **Identity Authentication**: User completes authentication in Mooncake Entra ID (including MFA/Conditional Access)
2. **Network Connectivity**: Secure communication via VPN Gateway or ExpressRoute connections
3. **SAML Federation**: Mooncake as IdP sends SAML assertion to Global tenant through secure network channels
4. **Permission Assignment**: User gains access to Global Azure resources and enterprise applications
5. **Unified Experience**: Single sign-on enables seamless cross-cloud work experience with optimized network performance

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

## � Network Connectivity Options

### Secure Cross-Cloud Connectivity
The architecture supports multiple network connectivity options to ensure secure, reliable, and high-performance communication between Mooncake and Global clouds:

#### 🌐 VPN Gateway Connections
- **Site-to-Site VPN**: Secure IPsec tunnels for standard connectivity needs
- **Point-to-Site VPN**: Individual client connections for remote access scenarios
- **Cost-Effective**: Suitable for moderate bandwidth requirements and testing environments
- **Easy Setup**: Quick deployment with standard internet connectivity

#### ⚡ ExpressRoute Connections
- **Dedicated Private Circuits**: Direct connections to Microsoft cloud services
- **High Performance**: Guaranteed bandwidth and lower latency
- **Enhanced Security**: Private connectivity bypassing the public internet
- **SLA Guarantees**: 99.95% availability with Microsoft SLA coverage
- **Regulatory Compliance**: Meets strict data sovereignty and security requirements

#### 🛡️ Hybrid Security Benefits
- **Traffic Isolation**: Dedicated network paths separate from public internet
- **Enhanced Monitoring**: Complete visibility into cross-cloud traffic flows
- **Conditional Access Integration**: Network-aware access policies
- **Zero Trust Architecture**: Network security as part of comprehensive identity protection

---

## �🚀 Digital Transformation & AI Acceleration

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
