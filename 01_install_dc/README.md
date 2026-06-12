# 01 Installing the Domain Controller

1. Use 'sconfig' to:
    - Change the hostname
    - Change the IP address to static
    - Change the DNS Sever to our own IP address



''''shell
Installed-WindowsFeature - AD-Domain-Services -IncludeManagementTools
'''


'''
Get-NetIPAddress
'''

# Joining the workstation to the domain



'''
Add-Computer -Domainname lab.local -Credential LAB\Administrator -Force -Restart