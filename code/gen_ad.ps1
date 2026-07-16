param(
    [Parameter(Mandatory=$true)]
    [string]$JSONFile
)

function CreateADUser {
    param(
        [Parameter(Mandatory=$true)]
        $userObject
    )

    $name = $userObject.name
    $password = $userObject.password

    $firstName = $name.Split(" ")[0]
    $lastName = $name.Split(" ")[1]

    $username = ($firstName[0] + $lastName).ToLower()

    Write-Output "Creating user: $username"

    New-ADUser `
        -Name $name `
        -GivenName $firstName `
        -Surname $lastName `
        -SamAccountName $username `
        -UserPrincipalName "$username@lab.local" `
        -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
        -Enabled $true
}

$json = Get-Content $JSONFile -Raw | ConvertFrom-Json

foreach ($user in $json.users) {
    CreateADUser $user
}