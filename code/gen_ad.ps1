param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$JSONFile,

    [switch]$Undo
)

Import-Module ActiveDirectory

function Get-GeneratedUsername {
    param(
        [Parameter(Mandatory = $true)]
        $UserObject
    )

    $nameParts = $UserObject.name -split '\s+', 2

    if ($nameParts.Count -lt 2) {
        throw "User name '$($UserObject.name)' must contain a first and last name."
    }

    $firstName = $nameParts[0]
    $lastName = $nameParts[1]

    return (($firstName.Substring(0, 1) + $lastName).ToLower())
}

function New-GeneratedADUser {
    param(
        [Parameter(Mandatory = $true)]
        $UserObject
    )

    $name = $UserObject.name
    $password = $UserObject.password
    $username = Get-GeneratedUsername -UserObject $UserObject

    $nameParts = $name -split '\s+', 2
    $firstName = $nameParts[0]
    $lastName = $nameParts[1]

    Write-Host "Creating user: $username"

    try {
        New-ADUser `
            -Name $name `
            -GivenName $firstName `
            -Surname $lastName `
            -SamAccountName $username `
            -UserPrincipalName "$username@lab.local" `
            -AccountPassword (
                ConvertTo-SecureString $password -AsPlainText -Force
            ) `
            -Enabled $true `
            -ErrorAction Stop

        Write-Host "Successfully created $username" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to create $username"
        Write-Warning $_.Exception.Message
    }
}

function Remove-GeneratedADUser {
    param(
        [Parameter(Mandatory = $true)]
        $UserObject
    )

    $username = Get-GeneratedUsername -UserObject $UserObject

    try {
        $existingUser = Get-ADUser `
            -Identity $username `
            -ErrorAction Stop

        Remove-ADUser `
            -Identity $existingUser `
            -Confirm:$false `
            -ErrorAction Stop

        Write-Host "Removed user: $username" -ForegroundColor Yellow
    }
    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
        Write-Host "User not found, skipping: $username"
    }
    catch {
        Write-Warning "Failed to remove $username"
        Write-Warning $_.Exception.Message
    }
}

$json = Get-Content $JSONFile -Raw | ConvertFrom-Json

if ($Undo) {
    Write-Host "Undo mode selected." -ForegroundColor Yellow

    foreach ($user in $json.users) {
        Remove-GeneratedADUser -UserObject $user
    }

    return
}

foreach ($user in $json.users) {
    New-GeneratedADUser -UserObject $user
}