param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$OutputJSONFile,

    [ValidateRange(1, 10000)]
    [int]$UserCount = 100,

    [ValidateRange(1, 1000)]
    [int]$GroupCount = 10,

    [ValidateRange(0, 10000)]
    [int]$LocalAdminCount = 0
)

$group_names = [System.Collections.ArrayList](
    Get-Content (Join-Path $PSScriptRoot "data\group_names.txt")
)

$first_names = [System.Collections.ArrayList](
    Get-Content (Join-Path $PSScriptRoot "data\first_names.txt")
)

$last_names = [System.Collections.ArrayList](
    Get-Content (Join-Path $PSScriptRoot "data\last_names.txt")
)

$groups = @()
$users = @()

# Prevent impossible values
if ($LocalAdminCount -gt $UserCount) {
    throw "LocalAdminCount cannot be greater than UserCount."
}

if ($GroupCount -gt $group_names.Count) {
    throw "GroupCount cannot be greater than the number of available group names."
}

if (
    $UserCount -gt $first_names.Count -or
    $UserCount -gt $last_names.Count
) {
    throw "UserCount is greater than the number of available names."
}

# Generate random groups
for ($i = 0; $i -lt $GroupCount; $i++) {

    $new_group = (
        Get-Random -InputObject $group_names
    ).ToString()

    $groups += $new_group

    [void]$group_names.Remove($new_group)
}

# Select unique user indexes that will become local administrators
$local_admin_indexes = @()

if ($LocalAdminCount -gt 0) {

    while ($local_admin_indexes.Count -lt $LocalAdminCount) {

        $random_index = Get-Random `
            -InputObject (0..($UserCount - 1))

        if ($local_admin_indexes -notcontains $random_index) {
            $local_admin_indexes += $random_index
        }
    }
}

Write-Host "Local admin indexes:"

if ($local_admin_indexes.Count -gt 0) {
    $local_admin_indexes
}
else {
    Write-Host "None"
}

# Generate random users
for ($i = 0; $i -lt $UserCount; $i++) {

    $first_name = Get-Random -InputObject $first_names
    $last_name = Get-Random -InputObject $last_names
    $number = Get-Random -Minimum 100 -Maximum 999
    $password = "$first_name@$number!"

    # Returns True if the current user index is in the local-admin list
    $is_local_admin = $local_admin_indexes -contains $i

    $new_user = @{
        "name"        = "$first_name $last_name"
        "password"    = $password
        "groups"      = @(
            (Get-Random -InputObject $groups).ToString()
        )
        "local_admin" = $is_local_admin
    }

    if ($is_local_admin) {
        Write-Host "User $i ($first_name $last_name) is a local admin."
    }

    $users += $new_user

    [void]$first_names.Remove($first_name)
    [void]$last_names.Remove($last_name)
}

$domain = @{
    "domain" = "xyz.com"
    "groups" = $groups
    "users"  = $users
}

$domain |
    ConvertTo-Json -Depth 5 |
    Set-Content -Path $OutputJSONFile -Encoding UTF8

Write-Host "Generated $UserCount users and $GroupCount groups."
Write-Host "Selected $LocalAdminCount local administrators."
Write-Host "Output written to $OutputJSONFile."