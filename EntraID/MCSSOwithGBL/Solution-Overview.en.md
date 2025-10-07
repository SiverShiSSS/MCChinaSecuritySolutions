[English](Solution-Overview.en.md) | [中文](Solution-Overview.md)

# Cross-Cloud SSO Solution: Mooncake ⇆ Global

## Executive Summary

This solution provides China-based customers with a comprehensive cross-cloud Single Sign-On (SSO) architecture, enabling secure identity federation between Microsoft Entra ID Mooncake and Global tenants. Leveraging SAML 2.0 protocol, it supports bidirectional authentication flows to meet identity management requirements across diverse business scenarios.

### Core Value Propositions
- **🔒 Enhanced Security**: Leverage world-class identity security technology for unified cross-cloud authentication
- **🌐 Compliance Assurance**: Meet China's data sovereignty requirements with localized identity data management
- **⚡ User Experience**: Single sign-on eliminates password fatigue and improves productivity
- **🔧 Flexible Architecture**: Support both upstream and downstream scenarios for various business models

---

## Solution Architecture

### Unified Identity Management: Mooncake as Identity Provider (IdP)

**Best Practice Scenario: China-headquartered enterprises with primary business systems on Mooncake, requiring Global resource access**

![Architecture: Cross-Cloud SSO with Mooncake as IdP](EntraID/MCSSOwithGBL/assets/upstream-view.png)

#### Architecture Advantages
- **🏢 China-First Approach**: Identity management center in China, aligning with local governance requirements
- **🔐 Unified Security Control**: Mooncake Entra ID centrally manages authentication and authorization policies
- **🌍 Global Resource Access**: Seamless access to Global M365 services and Azure resources
- **📋 Compliance Assurance**: Core identity data stored within China borders, meeting data sovereignty requirements

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
- Enterprise applications and SaaS services
- Azure global region resources
- Third-party integrated applications

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
