# Windows Server 2022 Active Directory Homelab

> Enterprise Active Directory lab built using **Windows Server 2022**, **Windows 11**, **Hyper-V**, and **PowerShell automation**.

---

# Project Overview

This project demonstrates the deployment of a complete Windows Server 2022 Active Directory environment running on Hyper-V.

The lab was built to develop practical Windows infrastructure skills including Active Directory Domain Services (AD DS), DNS configuration, PowerShell automation and enterprise Windows administration.

To extend the project beyond a standard tutorial, custom PowerShell scripts were developed to automatically provision Active Directory users from JSON and remove them using an **Undo** function, allowing repeatable testing without rebuilding the environment.

---

# Lab Environment

| Component | Technology |
|-----------|------------|
| Hypervisor | Hyper-V |
| Domain Controller | Windows Server 2022 Server Core |
| Client Machine | Windows 11 |
| Domain | lab.local |
| Active Directory | AD DS |
| DNS | Active Directory Integrated |
| Automation | PowerShell |
| Version Control | Git & GitHub |

---

# Features

| Feature | Status |
|---------|:------:|
| Windows Server 2022 Deployment | ✅ |
| Hyper-V Lab Environment | ✅ |
| Active Directory Domain Services | ✅ |
| DNS Configuration | ✅ |
| Static IP Configuration | ✅ |
| Windows 11 Domain Join | ✅ |
| PowerShell User Provisioning | ✅ |
| JSON User Generation | ✅ |
| Undo Function | ✅ |
| PowerShell Remoting | ✅ |

---

# Project Objectives

- Deploy Windows Server 2022 Server Core
- Configure Active Directory Domain Services
- Configure DNS
- Create a new Active Directory Forest
- Join a Windows 11 workstation to the domain
- Automate Active Directory user provisioning
- Implement repeatable user removal using PowerShell
- Demonstrate PowerShell Remoting between hosts

---

# Active Directory Installation

Install Active Directory Domain Services:

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

---

# Create the Domain

A new Active Directory forest was created.

**Domain**

```
lab.local
```

**NetBIOS**

```
LAB
```

---

# Join Windows 11 to the Domain

```powershell
Add-Computer -DomainName lab.local -Credential LAB\Administrator -Restart
```

---

# PowerShell Automation

The project includes a custom PowerShell automation script capable of:

- Reading users from JSON
- Automatically generating usernames
- Creating Active Directory users
- Assigning passwords
- Creating User Principal Names (UPNs)
- Reporting successful and failed operations
- Removing generated users using an Undo switch

Create users:

```powershell
.\gen_ad.ps1 .\new.json
```

Undo generated users:

```powershell
.\gen_ad.ps1 .\new.json -Undo
```

---

# Screenshots

## Hyper-V Lab

![Hyper-V Lab](screenshots/hyperv-lab.png)

---

## Windows Server 2022 Server Core

![Server Core](screenshots/server-core.png)

---

## Windows 11 Successfully Joined to the Domain

![Domain Join](screenshots/domain-join-success.png)

---

## Windows 11 Domain Joined

![Domain Joined](screenshots/domain-joined.png)

---

## DNS Resolution

![DNS Resolution](screenshots/dns-resolution.png)

---

## Active Directory Users and Computers

![Active Directory Users](screenshots/ad-users-list.png)

---

## PowerShell User Provisioning

![PowerShell User Creation](screenshots/ad-user-created.png)

---

## PowerShell Undo Function

The automation supports complete rollback of all generated Active Directory users, allowing the lab to be reset without restoring a Hyper-V checkpoint.

![Undo Function](screenshots/undo-function.png)

---

## User Verification

![User Verification](screenshots/user-verification.png)

---

# Skills Demonstrated

- Windows Server 2022
- Active Directory Domain Services (AD DS)
- Windows Server Core
- DNS
- Hyper-V
- Windows 11
- PowerShell
- PowerShell Remoting (WinRM)
- JSON
- Active Directory Administration
- Domain Joining
- Infrastructure Automation
- Windows Networking
- Git
- GitHub

---

# What I Learned

During this project I gained practical experience with:

- Deploying Windows Server Core
- Configuring Active Directory Domain Services
- Configuring DNS for domain environments
- Joining Windows clients to a domain
- Automating Active Directory administration with PowerShell
- Using JSON to provision Active Directory users
- Managing remote Windows servers using PowerShell Remoting
- Creating reusable infrastructure automation
- Implementing rollback functionality using an Undo switch
- Documenting enterprise infrastructure projects using GitHub

---

# Repository Structure

```text
active-directory-homelab
│
├── code
│   ├── gen_ad.ps1
│   ├── random_domain.ps1
│   ├── new.json
│
├── screenshots
│   ├── ad-user-created.png
│   ├── ad-users-list.png
│   ├── dns-resolution.png
│   ├── domain-join-success.png
│   ├── domain-joined.png
│   ├── hyperv-lab.png
│   ├── server-core.png
│   ├── undo-function.png
│   └── user-verification.png
│
├── README.md
│
└── LICENSE
```

---

# Generated Files

The following generated files are intentionally excluded from GitHub:

- out.json
- ad_schema.json
- data/passwords.txt

Generate your own dataset using:

```powershell
.\random_domain.ps1 -OutputJSONFile .\out.json
```

---

# Future Improvements

- Group Policy automation
- Organisational Unit (OU) creation
- Security Group automation
- Home folder provisioning
- Logon scripts
- Microsoft Entra ID integration
- Azure AD Connect
- Group Managed Service Accounts (gMSA)

---

# Author

## Reese Ballantine

IT Support Engineer | Windows Server | Active Directory | PowerShell | Hyper-V | Microsoft Intune | Microsoft 365

### LinkedIn

https://www.linkedin.com/in/reese-ballantine-466a88343/

### GitHub

https://github.com/ReeseBallantine1/active-directory-homelab