[English](README.en.md) | [中文](README.md)

# MC China Security Solutions

For customers in China, this project explores and consolidates technical solutions to meet business, security compliance, and operations needs. It focuses on practical, reusable best practices in the 21V Mooncake environment, covering Microsoft security and identity products, adapted to China-specific platform characteristics and constraints.

## Goals & Principles
- Focus on 21V Mooncake: Prioritize designs and implementations validated in the China environment.
- Bridge Global/China (within compliance): Explore integration patterns with global tenants/services and document constraints.
- Operability first: Provide architecture notes, configuration steps, scripts, and samples for quick adoption.
- Security & compliance by design: Data residency, least privilege, auditability, and operability come first.

## Scope (growing)
- Identity & Access
  - Microsoft Entra ID (differences and best practices in 21V Mooncake)
  - SSO (SAML/OIDC), Conditional Access, MFA, Privileged Identity Management (PIM)
  - Cross-tenant/cloud patterns (within compliance boundaries)
- Security capabilities
  - Threat protection (e.g., Defender family availability and alternatives in China)
  - Infrastructure security (network isolation, WAF/Firewall, key and certificate management)
  - Logging & monitoring (China-available options for collection, alerting, and operations)
- Governance & Compliance
  - Roles and permissions, baseline policies, change/config compliance
  - Data residency, cross-border transfer considerations and remediation paths

> Note: Capabilities and APIs differ between China and global clouds over time. Always validate with 21V Mooncake and document gaps and workarounds.

## Repository Structure
- `EntraID/MCSSOwithGBL/`: Exploration and practices for SSO with global tenant (e.g., SAML)
  - Reference: `EntraID/MCSSOwithGBL/MC-Mooncake-SSO-with-Global-Tenant-SAML.md`

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

