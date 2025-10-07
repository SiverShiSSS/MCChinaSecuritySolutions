[English](README.en.md) | [中文](README.md)

# MC China Security Solutions

🚧 **Project Status: Under Active Development** | **项目状态：持续开发中** 🚧

For customers in China, this project explores and consolidates technical solutions to meet business, security compliance, and operations needs. It focuses on practical, reusable best practices in the 21V Mooncake environment, covering Microsoft security and identity products, adapted to China-specific platform characteristics and constraints.

## 🎯 Goals & Principles
- **Focus on 21V Mooncake**: Prioritize designs and implementations validated in the China environment
- **Bridge Global/China** (within compliance): Explore integration patterns with global tenants/services and document constraints
- **Operability first**: Provide architecture notes, configuration steps, scripts, and samples for quick adoption
- **Security & compliance by design**: Data residency, least privilege, auditability, and operability come first

## 📋 Scope (Continuously Expanding)

### 🔐 Identity & Access
- **Microsoft Entra ID** (differences and best practices in 21V Mooncake)
- **Single Sign-On** (SAML/OIDC), Conditional Access, MFA, Privileged Identity Management (PIM)
- **Cross-tenant/cloud patterns** (within compliance boundaries)

### 🛡️ Security Capabilities
- **Threat protection** (Defender family availability and alternatives in China)
- **Infrastructure security** (network isolation, WAF/Firewall, key and certificate management)
- **Logging & monitoring** (China-available options for collection, alerting, and operations)

### 📊 Governance & Compliance
- **Roles and permissions**, baseline policies, change/config compliance
- **Data residency**, cross-border transfer considerations and remediation paths

> ⚠️ **Important Note**: Capabilities and APIs differ between China and global clouds over time. Always validate with 21V Mooncake and document gaps and workarounds.

## 📁 Repository Structure

### 🌟 Featured Solutions
- **`EntraID/MCSSOwithGBL/`** - 🔥 **Cross-Cloud SSO Solution**
  - SAML Single Sign-On integration between Mooncake and Global tenants
  - 📖 [Solution Overview](EntraID/MCSSOwithGBL/Solution-Overview.en.md) | [中文](EntraID/MCSSOwithGBL/Solution-Overview.md)
  - 📋 [Technical Implementation Guide](EntraID/MCSSOwithGBL/MC-Mooncake-SSO-with-Global-Tenant-SAML.en.md)
  - 🏛️ [Architecture Diagram](EntraID/MCSSOwithGBL/assets/upstream-view.png)

### 🔧 Automation Scripts & Tools
- **`EntraID/AutomationScripts/`** - PowerShell automation script collection
  - Automation tools for identity management, synchronization, security configuration

### 🚀 Other Security Solutions (Structure Created)
- **`DefenderForCloud&Sentinel/`** - Cloud security and SIEM solutions 📂 *Awaiting development*
- **`EOP(DefenderForOffice)/`** - Office 365 security protection 📂 *Awaiting development*
- **`Intune/`** - Mobile device management and security (includes some automation scripts)
- **`M365/`** - Microsoft 365 comprehensive security solutions 📂 *Awaiting development*
- **`Purview/`** - Data governance and compliance 📂 *Awaiting development*
- **`PenetrationTest/`** - Penetration testing and security assessment 📂 *Awaiting development*

## 🚧 Development Status

| Solution Module | Status | Completion | Notes |
|----------------|--------|------------|-------|
| **EntraID Cross-Cloud SSO** | ✅ **Completed** | 90% | Core architecture and implementation guide complete |
| EntraID Automation Scripts | 🔄 **In Progress** | 60% | Some scripts available, continuously adding more |
| Intune Mobile Device Management | 📂 **Created** | 15% | Basic scripts available, architecture planning |
| Defender for Cloud & Sentinel | � **Created** | 0% | Folder created, awaiting development |
| EOP (Defender for Office) | 📂 **Created** | 0% | Folder created, awaiting development |
| M365 Comprehensive Security | 📂 **Created** | 0% | Folder created, awaiting development |
| Purview Data Governance | � **Created** | 0% | Folder created, awaiting development |
| Penetration Test & Security Assessment | 📂 **Created** | 0% | Folder created, awaiting development |

## 🤝 Contributing & Feedback

We welcome Issues and Pull Requests to improve solution quality.

### Contribution Guidelines
1. Fork this repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Create a Pull Request

## 📞 Support & Contact

- 📧 **Technical Support**: Submit technical questions via Issues
- 📖 **Documentation Feedback**: Welcome documentation improvement suggestions
- 🔗 **Business Consultation**: Contact relevant Microsoft teams or partners

---

**Last Updated**: October 2025 | **Maintenance Team**: Microsoft China Security Solutions

Additional folders and samples will be added by capability area (Identity, Network Security, Threat Protection, Governance).

## Getting Started
1. Clone
   ```bash
   git clone https://github.com/SiverShiSSS/MCChinaSecuritySolutions.git
   cd MCChinaSecuritySolutions
   ```
2. Prerequisites
   - 21V Mooncake subscription/tenant (plus optional global tenant for comparison/integration)
   - PowerShell 7+/Git installed; use proxy or China endpoints if required
3. Read the relevant area docs and follow the steps to validate

## Contributing
- Use Issues for requests/bugs; PRs are welcome for docs and samples
- Guidelines:
  - Prioritize 21V Mooncake feasibility
  - Clearly mark differences/constraints vs. global, and provide alternatives
  - Provide minimal repro steps and examples/screenshots when possible

## Roadmap
- Identity: more SSO/SAML/OIDC scenarios, cross-tenant access, Conditional Access, PIM hands-on
- Security: network security baseline, WAF/AFW reference designs, cert/key management samples
- Operations & Compliance: logging/alerting, baseline & compliance assessment, runbooks and drills
- IaC: Bicep/Terraform samples targeting China endpoints (incremental)

## Disclaimer
This repository is for technical exploration and reference and is not legal/compliance advice. Capabilities change over time; validate against official docs and your environment. Test thoroughly in non-production and assess business impact before changes.

