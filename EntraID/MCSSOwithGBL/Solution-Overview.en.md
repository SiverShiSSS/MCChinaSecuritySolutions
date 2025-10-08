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

### Technical Compliance Recommendations

#### 🔐 Data Encryption Requirements
```powershell
# Ensure SAML assertions use strong encryption algorithms
$SamlConfig = @{
    SigningAlgorithm = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"
    DigestAlgorithm = "http://www.w3.org/2001/04/xmlenc#sha256"
    EncryptionMethod = "http://www.w3.org/2001/04/xmlenc#aes256-cbc"
}
```

#### 🏢 Organizational Boundary Controls
- Configure Conditional Access policies to restrict specific geographic locations
- Implement device compliance requirements
- Enable session controls and monitoring

#### 📊 Audit and Monitoring
- Enable comprehensive Azure AD audit logging
- Configure Security Information and Event Management (SIEM) integration
- Establish anomalous login detection and response mechanisms

---

## Technical Implementation Guide

### Prerequisites Checklist

#### Environment Preparation
- [ ] Mooncake and Global tenant administrator permissions
- [ ] Valid domain names and SSL certificates
- [ ] Network connectivity testing completed
- [ ] DNS resolution properly configured

#### License Requirements
- [ ] Azure AD Premium P1/P2 licenses (supporting enterprise applications)
- [ ] Corresponding M365 or Azure service licenses
- [ ] Third-party application SAML integration licenses (if required)

### POC Validation Steps

#### Phase 1: Basic Connectivity Validation
```powershell
# Test endpoint connectivity
Test-NetConnection login.chinacloudapi.cn -Port 443
Test-NetConnection graph.chinacloudapi.cn -Port 443
Test-NetConnection login.microsoftonline.com -Port 443
```

#### Phase 2: SAML Federation Configuration Validation
- [ ] IdP metadata correctly exported and imported
- [ ] SP configuration parameters accurately set
- [ ] Certificate validity and trust chain verification
- [ ] NameID mapping and attribute claims testing

#### Phase 3: End-to-End User Experience Validation
- [ ] Browser SSO flow testing
- [ ] Mobile device access verification
- [ ] Access testing under different network environments
- [ ] Error scenarios and fallback mechanism verification

#### Phase 4: Security and Compliance Validation
- [ ] Conditional Access policy effectiveness confirmation
- [ ] MFA integration functionality verification
- [ ] Audit log recording integrity check
- [ ] Data transmission encryption verification

---

## Comparison with CCB2B Solution

| Comparison Dimension | Cross-Cloud SSO (This Solution) | Cross-Cloud B2B (CCB2B) |
|---------------------|--------------------------------|-------------------------|
| **Identity Model** | Federated identity, user master objects in source tenant | Guest users, creating B2B objects in target tenant |
| **Technical Protocol** | SAML 2.0 / OpenID Connect | Microsoft Graph B2B invitation API |
| **User Experience** | Transparent single sign-on | Requires accepting B2B invitations |
| **Management Complexity** | Centralized identity management | Distributed guest user management |
| **Compliance Considerations** | Identity data retained in source tenant | User data replicated to target tenant |
| **Use Cases** | Internal enterprise cross-cloud access | Cross-organizational collaboration and resource sharing |


## Implementation Roadmap

### Phase 1: Planning & Preparation (2-3 weeks)
- [ ] Business requirements analysis and scenario confirmation
- [ ] Technical architecture design and review
- [ ] Compliance requirements assessment and gap analysis
- [ ] Project team formation and training

### Phase 2: Environment Setup (2-4 weeks)
- [ ] Test environment configuration
- [ ] Basic connectivity establishment
- [ ] Certificate and security configuration
- [ ] Initial functionality verification

### Phase 3: Application Integration (3-6 weeks)
- [ ] Priority application SAML integration
- [ ] User attribute mapping configuration
- [ ] Access policies and permission settings
- [ ] User acceptance testing

### Phase 4: Production Deployment (2-3 weeks)
- [ ] Production environment configuration
- [ ] User migration and training
- [ ] Monitoring and alerting setup
- [ ] Go-live support and optimization

### Phase 5: Operational Optimization (Ongoing)
- [ ] Performance monitoring and tuning
- [ ] Continuous security policy improvement
- [ ] User feedback collection and enhancement
- [ ] New application and scenario expansion

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
