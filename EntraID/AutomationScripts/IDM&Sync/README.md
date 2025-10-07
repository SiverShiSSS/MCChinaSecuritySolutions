# Overview
This collection contains a variety of scripts for `Identity Mangement and Synchronization` vertical. Each script is designed to address unique needs and provide valuable functionality. 

To help you quickly find the script you need, we've organized them into a table with descriptions, required modules, and additional information. Whether you're looking for a script to automate a task, process data, or perform specific operations, you'll find it here.

Feel free to explore the table below to find the script that best suits your requirements. If you have any questions or need further assistance, don't hesitate to reach out.

# Scripts
| Script Name | Description |
|-------------|-------------|
| **External Identity** | ---------------- |
| [Export Inactive Guest Users](<./External Identity/ExportInactionGuestUsers.ps1>)| -- |
| **Object Management** | ---------------- |
| [Export RBAC assignment from MG/Sub/RG](<./Object Management/all-rbac-role-assginment.ps1>) | Export all the RBAC role assignments from MG/Sub/RG |
| [Bulk Update User Attribute](<./Object Management/BulkUpdateUserAttribute.ps1>) | -- |
| [Export ALL Users' Last Signin Datetime](<./Object Management/last-signin-all-users.ps1>)| Export CSV for all tenant users' last signin datetime - Delegated Permission |
| [Tag Device Ext.Attribute Using Intune Attribute](<./Object Management/TagingAADDeviceExtensionAttributeUsingIntuneAttribute_DelegatedUserAuth.ps1>) | Automatically tagging AAD Device 
| [Group Member Exporter](<./Object Management/group-member-exporter.ps1>) | Export all users and nested groups to CSV files |
Extension attribute 1-15 from corresponding Intune attribute using delegated permission. |
| [Tag Device Ext.Attribute Using Intune Attribute](<./Object Management/TagingAADDeviceExtensionAttributeUsingIntuneAttribute_SPAuth.ps1>) | Automatically tagging AAD Device Extension attribute 1-15 from corresponding Intune attribute using app permission. |
| [Create Cloud Group Based on Sync Group](<./Object Management/create-cloud-group-based-on-sync-group-app-permission.ps1>) | **App** permission - create cloud groups based on synced groups |
| [Create Cloud Group Based on Sync Group](<./Object Management/create-cloud-group-based-on-sync-group-user-permission.ps1>) | **User** permission - create cloud groups based on synced groups |
| [Evaluate Users Without Profile Picture](<./Object Management/evaluate-user-who-has-no-prof-pic.ps1>) | Evaluates all users who do NOT have profile picture |
| [Retrieve License Assignment for Single License](<./Object Management/license-assignment-for-single-license.ps1>) | Retrieve license assignment for SINGLE license |
| **Organization Management** | ---------------- |
| **Security and Access Management** | ---------------- |
| [Export Inactive Users](<./Security and Access Management/ExportInactiveUsers.ps1>) | -- |
| [Find PIM Group by UPN](<./Security and Access Management/FindPIMGroupByUPN.ps1>) | -- |
| [List AAD Role Assignment With Object Type](<./Security and Access Management/ListAADRoleAssignmentwithObjectType.ps1>) | This script retrieves a specific role assignment and distinguishes the object type (user, group, or application) associated with it | 
| [Bulk Disable SMS Signins](<./Security and Access Management/bulk-disable-sms-signin.ps1>) | bulk disable SMS sign-in for multiple users in Entra ID. |
| [Pre-populate MFA Methods](<./Security and Access Management/pre-populate-MFA-methods.ps1>) | Pre-populating MFA methods for users based on CSV |
| [SSPR + MFA Methods Usage Report](<./Security and Access Management/sspr_mfa_usage_report.ps1>) | Getting SSPR and other MFA methods usage report |
| [Get All Role Assignments](<./Security and Access Management/all-role-assignments.ps1>) | Getting All role assignments in tenant |
| [Get SINGLE Role's Assignments](<./Security and Access Management/single-role-assginments.ps1>) | Getting SINGLE role's assignments in tenant |
| **Sync and Provisioning** | ---------------- |
| [Restart Provisioning Job](<./Sync and Provisioning/restart-provisioning.ps1>) | Restart provisioning job. Can be put into scheduled job. Mitigate known issue. |
| [Bulk Hard Match](<./Sync and Provisioning/bulk-hard-match.ps1>) | Bulk hardmatch using ObjectGUID | 
| Sync and Provisioning/AD Management | ---------------- |
| [AD thumbnailPhoto Writer](<./Sync and Provisioning/AD Management/ad-thumbnailPhoto-writer.ps1>) | Set or update Active Directory user's thumbnailPhoto. | 
| [Bulk Create AD Users](<./Sync and Provisioning/AD Management/bulk-create-ADUsers.ps1>) | Create multiple Active Directory users in bulk. | 
| [Bulk Enable Inheritance and Clear adminCount](<./Sync and Provisioning/AD Management/bulk-enable-inheritance-and-clear-adminCount.ps1>) | Clear adminCount and enable inheritance for Active Directory users. | 

# Contributing
1. Please refer to [Wiki Page](https://dev.azure.com/CodeCommons/Identity%20Code%20Commons/_wiki/wikis/Identity-Code-Commons.wiki/1/PowerShell-Script-Upload-Standards) for contributing guide.
2. Create folder to include sample input/output as needed. Otherwise having single script under this folder is fine.

# License
```
MIT License

Copyright (c) Microsoft Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
