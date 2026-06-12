# 01 - Installing the Domain Controller

## Overview

This section documents the deployment of a Windows Server 2022 Domain Controller and the creation of an Active Directory environment.

## Server Configuration

Using `sconfig`:

* Changed the server hostname
* Configured a static IP address
* Configured DNS to point to the Domain Controller

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

## Outcome

* Active Directory Domain Services installed
* Domain Controller deployed
* DNS configured
* Domain `lab.local` created
* Windows 11 workstation joined to the domain
