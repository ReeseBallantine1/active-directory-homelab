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

    try {
        New-ADUser `
            -Name $name `
            -GivenName $firstName `
            -Surname $lastName `
            -SamAccountName $username `
            -UserPrincipalName "$username@lab.local" `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
            -Enabled $true `
            -ErrorAction Stop

        Write-Host "Successfully created $username" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to create $username"
        Write-Warning $_.Exception.Message
    }

}   # <-- This closes the function

$json = Get-Content $JSONFile -Raw | ConvertFrom-Json

foreach ($user in $json.users) {
    CreateADUser $user
}