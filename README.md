\# Active Directory Homelab



\## Overview



This project demonstrates the deployment of a Windows Server 2022 Active Directory environment using Hyper-V.



\### Technologies Used



\* Windows Server 2022

\* Windows 11

\* Active Directory Domain Services (AD DS)

\* DNS

\* Hyper-V

\* PowerShell

\* PowerShell Remoting

\* JSON-based User Provisioning



\## Project Structure



```text

01\_install\_dc/

code/

screenshots/

```



\## Lab Screenshots



\### Hyper-V Environment



!\[Hyper-V Lab](screenshots/hyperv-lab.png)



\### Windows 11 Joined to Domain



!\[Domain Joined](screenshots/domain-joined.png)



\### DNS Resolution



!\[DNS Resolution](screenshots/dns-resolution.png)



\### Active Directory User Creation



!\[AD User Created](screenshots/ad-user-created.png)



\### Active Directory Users



!\[AD Users](screenshots/ad-users-list.png)



\## PowerShell Automation



The lab includes a PowerShell script (`gen\_ad.ps1`) which reads user information from `ad\_schema.json` and automatically creates Active Directory users.



\### Example



```powershell

.\\gen\_ad.ps1 .\\ad\_schema.json

```



\## Skills Demonstrated



\* Active Directory Administration

\* DNS Configuration

\* Domain Joining

\* PowerShell Scripting

\* PowerShell Remoting

\* User Provisioning Automation

\* Hyper-V Administration

\* Troubleshooting



