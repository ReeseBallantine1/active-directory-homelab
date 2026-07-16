param([Parameter(Mandatory=$true)] $OutputJSONFile)


$group_names = [System.Collections.ArrayList](Get-Content "data/group_names.txt")
$first_names = [System.Collections.ArrayList](Get-Content "data/first_names.txt")
$last_names = [System.Collections.ArrayList](Get-Content "data/last_names.txt")

$groups = @()
$users = @()

# Generate 10 random groups
$num_groups = 10

for ($i = 0; $i -lt $num_groups; $i++) {
    $new_group = (Get-Random -InputObject $group_names).ToString()
    $groups += $new_group
    $group_names.Remove($new_group)
}

# Generate 100 random users
$users = @()
$num_users = 100

for ($i = 0; $i -lt $num_users; $i++) {

    $first_name = Get-Random -InputObject $first_names
    $last_name = Get-Random -InputObject $last_names
    $number = Get-Random -Minimum 100 -Maximum 999
    $password = "$first_name@$number!"

    $new_user = @{
        "name"     = "$first_name $last_name"
        "password" = $password
        "groups"   = @((Get-Random -InputObject $groups).ToString())
    }

    
    $users += $new_user 
    $first_names.Remove($first_name)
    $last_names.Remove($last_name)
    
}

$domain =@{
    "domain" = "xyz.com"
    "groups" = $groups
    "users" = $users

}

$domain | ConvertTo-Json -Depth 5 | Out-File $OutputJSONFile

Write-Output $domain