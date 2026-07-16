# 01 – Installing the Domain Controller

## Overview

This section documents the deployment of a Windows Server 2022 Domain Controller within a Hyper-V environment and the creation of a new Active Directory forest.

## Objectives

- Configure the Windows Server 2022 network settings.
- Install Active Directory Domain Services (AD DS).
- Promote the server to a Domain Controller.
- Create a new Active Directory forest.
- Join a Windows 11 workstation to the domain.

## Server Configuration

Using `sconfig` I:

- Changed the server hostname.
- Configured a static IPv4 address.
- Configured DNS to point to the Domain Controller.

## Install Active Directory Domain Services

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

## Verify Network Configuration

```powershell
Get-NetIPAddress
```

## Create the Domain

The server was promoted to a Domain Controller and a new Active Directory forest was created.

**Domain Name:** `lab.local`

**NetBIOS Name:** `LAB`

## Join the Windows 11 Workstation

```powershell
Add-Computer -DomainName lab.local -Credential LAB\Administrator -Force -Restart
```

## Skills Demonstrated

- Windows Server 2022
- Active Directory Domain Services
- DNS Configuration
- Static IP Configuration
- Domain Administration
- Windows 11 Domain Joining
- PowerShell

## Outcome

✅ Active Directory Domain Services installed

✅ Domain Controller deployed

✅ DNS configured

✅ New Active Directory forest created

✅ Windows 11 workstation successfully joined to the domain

## Repository Notes

The repository includes example files for demonstration purposes.

The generated files below are intentionally excluded from GitHub:

- `out.json`
- `ad_schema.json`
- `data/passwords.txt`

To generate your own data, run:

```powershell
.\random_domain.ps1 -OutputJSONFile .\out.json
```
