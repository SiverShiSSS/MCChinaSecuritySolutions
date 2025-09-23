[English](MC-Mooncake-SSO-with-Global-Tenant-SAML.en.md) | [中文](MC-Mooncake-SSO-with-Global-Tenant-SAML.md)

## SAML SSO solution for Mooncake China tenant integrating with Global tenant (Unofficial)

> Applicable scenario: A Microsoft Entra tenant in China cloud (Mooncake/21V, hereafter "MC tenant") needs to implement SAML-based single sign-on (SSO) with a Global Azure tenant (hereafter "Global tenant"). The MC tenant acts as the Service Provider (SP), and the Global tenant acts as the Identity Provider (IdP). User data resides in Mooncake China so that the Global tenant's identity and authentication capabilities can be reused in a compliant manner. Can be used together with CCB2B or selectively replace it as needed.

> Important note: This is a pragmatic, workaround-style solution and NOT an officially supported Microsoft feature. It is provided for reference and pilot use only. Thoroughly validate in non-production before rollout. You are responsible for all risks and impacts.

---

### Demo Video

Prefer the Raw link for online playback. If the browser or GitHub preview is restricted, use the repo file page or download locally.

Inline playback (Raw link):

<video src="https://raw.githubusercontent.com/SiverShiSSS/MCChinaSecuritySolutions/main/EntraID/MCSSOwithGBL/assets/demo.mp4" controls width="720">
  Your browser does not support embedded video. Use the "Raw" link or the repo file page below.
</video>

- Raw: https://raw.githubusercontent.com/SiverShiSSS/MCChinaSecuritySolutions/main/EntraID/MCSSOwithGBL/assets/demo.mp4
- Repo file page: https://github.com/SiverShiSSS/MCChinaSecuritySolutions/blob/main/EntraID/MCSSOwithGBL/assets/demo.mp4

Fallback relative path: [./assets/demo.mp4](./assets/demo.mp4)

---

### Table of Contents
- Background & Goals
- Architecture Overview
- Prerequisites & Boundaries
- Implementation Steps
  - Create a non-gallery SAML2 app in the Global tenant and configure assertions
  - Configure Domain Federation in the MC tenant
  - Expose and map ImmutableID
  - End-to-end validation
- Key Parameters & Attribute Requirements
- Demo Commands (PowerShell)
- FAQ & Troubleshooting
- Security & Compliance Considerations
- Rollback & Exit Strategy
- References

---

## Background & Goals
- Goal: When MC tenant users access MC resources, redirect them to the Global tenant's SAML IdP for authentication, then return the SAML assertion to the MC tenant to complete sign-in.
- Motivation: Reuse existing identity, MFA, and governance capabilities in the Global tenant; reduce the cost of building and operating multiple identity stacks across regions.

## Architecture Overview
- Global tenant: Hosts a non-gallery SAML2 enterprise application (IdP-side configuration), initiates authentication, and issues SAML assertions.
- MC tenant: Enables Domain Federation for its custom domain, redirecting passive/active sign-in requests to the Global tenant's SAML endpoints.
- Assertion key point: The `NameID` in the SAML response MUST equal the `ImmutableID` of the Microsoft Entra user in the MC tenant; optionally include attributes like `IDPEmail`.

High-level flow:
1. User accesses MC resources (e.g., MC portal/app).
2. Based on federation configuration, the MC tenant forwards the authentication flow to the Global tenant's SAML endpoint.
3. The user completes authentication in the Global tenant (including MFA policies).
4. The Global tenant returns a SAML assertion to the MC tenant. The MC tenant validates the signature and attributes and establishes the session.

## Prerequisites & Boundaries
- Global and MC tenants require Global Administrator or equivalent permissions.
- The MC tenant has a verified custom domain (e.g., `contoso.cn`).
- You can obtain and manage the signing certificate of the SAML app in the Global tenant (Base64/PEM).
- Network, DNS, and proxy allow access between Global Azure and 21V Mooncake endpoints.
- Boundaries & limitations:
  - This solution does not change the official support matrix; some control-plane capabilities may differ in Mooncake.
  - `ImmutableID` must be stably computed/flowed on both sides; otherwise sign-in mismatches will occur.

## Implementation Steps

### Step 1: Create a non-gallery SAML2 app in the Global tenant and configure assertions
1. In the Global tenant's Microsoft Entra admin center, create an Enterprise Application → Non-gallery application.
2. Select SAML-based single sign-on.
3. Configure `Identifier (Entity ID)`, `Reply URL (Assertion Consumer Service URL)`, and `Sign-on URL` to match the MC federation endpoints (see passive/active sign-in URIs in the commands below).
4. Upload and enable the signing certificate (enable assertion signing and encryption if possible; at minimum, signing).
5. Claims & mappings:
   - Set SAML `NameID` to the value corresponding to the MC user's `ImmutableID` (see "Expose and map ImmutableID").
   - Add a custom claim `IDPEmail` with the user's UPN (`userPrincipalName`).
   - Configure other claims per business needs.

### Step 2: Configure Domain Federation in the MC tenant
- Use Microsoft Graph PowerShell (Mooncake environment) to set federation for your custom domain:
  - Configure `IssuerUri`, passive/active sign-in URIs, metadata URL, signing certificate, and protocol type (SAML).
  - Point to the Global tenant's corresponding sign-in and metadata endpoints.

### Step 3: Expose and map ImmutableID (critical)
- Requirement: The `NameID` in the SAML response MUST equal the MC user's `ImmutableID`.
- Challenge: Enterprise apps do not directly expose `ImmutableID` by default. Map it stably to a claim source:
  - Option A (recommended): Prepare an attribute in the Global tenant (e.g., `extensionAttributeX` or a custom directory extension) that is synchronized/computable and equal to the MC user's `ImmutableID`; map `NameID` to this attribute in SAML claims.
  - Option B: Use custom sync rules (e.g., Azure AD Connect/Cloud Sync/HR-driven) to align a common identifier between Global and MC, and reference that identifier in the Global tenant's app claims.
- Notes:
  - Length ≤ 64; URL/HTML-safe encoding required (e.g., encode `+` as `.2B`).
  - The value must be stable; any change will break sign-in.

### Step 4: End-to-end validation
1. In the Global tenant, pick a test user and ensure `NameID` resolves to the target value.
2. In the MC tenant, verify the corresponding user's `ImmutableID` matches.
3. Sign in with the MC domain account and confirm redirect to Global and successful return.
4. Use browser/network tools (F12, Fiddler) to inspect the SAML response and assertion.

## Key Parameters & Attribute Requirements
- `NameID`: MUST equal the MC user's `ImmutableID`; up to 64 alphanumeric characters; encode non-HTML-safe characters (e.g., `+` → `.2B`).
- `IDPEmail`: Element in the Global tenant's SAML response; value is the user's `userPrincipalName` (email format).
- `Issuer`: Unique URI for the IdP; MUST match the `IssuerUri` configured in MC federation; do not reuse sample values.

Reference: See Microsoft Learn "Required attributes" section (link in References).

## Demo Commands (PowerShell)
> Execute in the MC environment using Microsoft Graph PowerShell. Replace placeholders with your values.

```powershell
# Example: Update the MC tenant's domain federation configuration (replace domain, tenant/app IDs, and certificate)
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

Notes:
- `<GlobalTenantId>`: The tenant ID (GUID) of the Global tenant.
- `<AppId>`: Application (client) ID of the SAML app in the Global tenant.
- `<Base64-Encoded-Certificate>`: The SAML app's signing certificate (Base64). Rotate regularly.

Example you validated earlier (for reference only; do NOT reuse certificate/IDs as-is):
```powershell
update-MgDomainFederationConfiguration -DomainId sivershisss.biz -IssuerUri https://sts.windows.net/c9fc3f4b-049a-41fe-818e-f9d7d581a069/ -DisplayName "SiverTest3" -FederatedIdpMfaBehavior "rejectMfaByFederatedIdp" -PassiveSignInUri https://login.microsoftonline.com/c9fc3f4b-049a-41fe-818e-f9d7d581a069/saml2 -ActiveSignInUri https://login.microsoftonline.com/c9fc3f4b-049a-41fe-818e-f9d7d581a069/saml2 -SignOutUri https://login.microsoftonline.com/c9fc3f4b-049a-41fe-818e-f9d7d581a069/saml2 -MetadataExchangeUri https://login.microsoftonline.com/c9fc3f4b-049a-41fe-818e-f9d7d581a069/federationmetadata/2007-06/federationmetadata.xml?appid=0eb2f522-5370-41d0-a03d-0b183cc4c9d5  -SigningCertificate "MIIC8DCCAdigAwIBAgIQL4AcUIqXRbVJev0mQv4jjzANBgkqhkiG9w0BAQsFADA0MTIwMAYDVQQDEylNaWNyb3NvZnQgQXp1cmUgRmVkZXJhdGVkIFNTTyBDZXJ0aWZpY2F0ZTAeFw0yNTA5MTIwNjI0MDBaFw0yODA5MTIwNjI0MDBaMDQxMjAwBgNVBAMTKU1pY3Jvc29mdCBBenVyZSBGZWRlcmF0ZWQgU1NPIENlcnRpZmljYXRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnr0012idmhIszn2Bo04xYX8PciXzq3LNaIifrSPjwy3KGmvI4G3b2FRAuQa8YkFkZQxSDGsWaoJ/ezHQec5+xULEZVii/AG6JpRhboWjOjyiYSlOAnjDrihJUvc8ZQa/a3/sr057XPPuLhcbrMGdiVykaNSjt04qVO2Txs+SNa5Haa8WwrqKlcfSFpLn5jawvNQhGb8s9QVkEY/jHjgg9tzpwihT9s9oMhDDZUMLHeZFJwZZQcJPoBY705MZvLQLQi26E2zMWBydwj/L01hu3qtrfMkal0AOwXXom4WXhDNfe5l7tAQ1WOpEGcRMnnAqPDuQXTZ8QALPX+jabn53nQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBjEgEqqIzcwW4dPXFt3AE4Jo8y4XA/MgEmA4cjHasqP7ICtXj4UYjv0hiK2PrVc+rEWQRNZ+Uo9WBl0oivSqfK0I1WOtarzIfwSdyNH8cVfAOVgSqHpoNDYsQqDFFbQ6fCH/4gKF6PhYP84qYCnqVh+zhdvC1/ZwZrR5BfkGfDzwo5roeAhGo1+P7GHvu8BL7y3kb5g1sIa4JdCqcHwnPoHXWF6Z3lGEBAcdy0D7PA9vAXEdDG2rU3w3iuj7//P4pci1JPQW9SmeWNsBDTd5S+5nVvxMmEZdq0fMLont/GBtP/BWNr8Ild29g09lK8EDhWCJ01jHr8qscncDf0FIU3" -preferredAuthenticationProtocol "saml"
```

## FAQ & Troubleshooting
- Sign-in fails with "user not found":
  - Check whether `NameID` exactly matches the MC user's `ImmutableID` (including case and encoding).
  - Ensure the `IssuerUri` in federation configuration equals the `Issuer` in the Global tenant's SAML app.
- MFA behavior differs from expectation:
  - Verify `FederatedIdpMfaBehavior`. If you want MFA at IdP, ensure appropriate policies are enabled and aligned with this parameter.
- Certificate-related errors:
  - Ensure the certificate is current and not expired. After updating, also update MC federation config and app metadata.
- Endpoint 404/redirect errors:
  - Validate passive/active sign-in URIs and metadata URL with real Global `TenantId` and `AppId`.

## Security & Compliance Considerations
- Protect certificates and keys; set up rotation plans and alerts.
- Enable Conditional Access and necessary session protection on both Global and MC sides.
- Strictly control who can modify SAML claim mappings and federation settings; enforce change approval and auditing.
- Be cautious about cross-cloud networking and log retention to avoid data residency/compliance risks.

## Rollback & Exit Strategy
- Export current federation configuration (via Graph) before changes to enable quick rollback.
- Prepare a break-glass local admin account to avoid tenant lockout due to federation issues.
- Rollback steps:
  1) Temporarily disable or remove federation and switch the domain back to Managed (or restore previous config).
  2) Remove/disable token issuance from the Global tenant's SAML app.

## References
- Required attributes (Microsoft Learn): `https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/how-to-connect-fed-saml-idp#required-attributes`
- Microsoft Graph PowerShell (Mooncake vs. Global differences per official docs).

---

## Disclaimer
This document describes a workaround based on practical experience and is not an official Microsoft-supported feature. Evaluate risks and impacts before adopting. The author assumes no responsibility for issues arising from the use of this solution.
