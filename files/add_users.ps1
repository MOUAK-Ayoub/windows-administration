# Create users
# Create Oraganizational unit

$Parent = "developers"
$OUs = @(
"developers-client1",
"developers-client2"
)
New-ADOrganizationalUnit -Name $Parent  –Description “A container for all developers in the company”
# returns DC=mathai,DC=local if domain_name=mathai.local
$DomainDN = (Get-ADDomain).DistinguishedName
$ParentOU = "OU=" + $Parent + "," + $DomainDN
ForEach ($OU In $OUs)
{
    New-ADOrganizationalUnit -Name $OU -Path $ParentOU –Description “A container for  developers for this specific client”
}


$AdUser = @'
[
  {
    "firstname": "imane",
    "lastname": "imane",
    "logon_name": "iimane",
    "pwd": "Test2024!",
    "rdp_allowed": true
  },
  {
    "firstname": "ayoub",
    "lastname": "ayoub",
    "logon_name": "aayoub",
    "pwd": "Test2024!",
    "rdp_allowed": false
  }
]
'@

$AdUsersList = ConvertFrom-Json $AdUser

foreach ($elem in $AdUsersList)
{
    $secure_pwd = ConvertTo-SecureString $elem.pwd -AsPlainText -Force
    New-ADUser -Name $( $elem.firstname + " " + $elem.lastname ) -givenName $elem.firstname -Surname $elem.lastname `
    -UserPrincipalName  $elem.logon_name -SamAccountName $elem.logon_name  -AccountPassword $secure_pwd -Enabled $true


}


# Move computers to ous
$ComputersOu = @'
[
  {
    "computer": "COMPUTER-1",
    "ou": "developers-client1"
  }
]
'@
$ComputersOuList = ConvertFrom-Json $ComputersOu

ForEach ($computer_ou In $ComputersOuList)
{
    $identity = $( "CN=" + $computer_ou.computer + ",CN=Computers," + $DomainDN )
    $tagret = $( "OU=" + $computer_ou.ou + ",OU=" + $Parent + "," + $DomainDN )

    Move-ADObject -Identity $identity -TargetPath  $tagret
}

# Create group for users allowed to RDP
$GroupName = "Users allowed to RDP"
New-ADGroup -Name  $GroupName -GroupScope Global

$AdUsersListRdpAllowed = $AdUsersList | ?{ $_.rdp_allowed -eq $true }

foreach ($user in $AdUsersListRdpAllowed)
{
    $identity = $( "CN=" + $user.firstname + " " + $user.lastname + ",CN=Users," + $DomainDN )
    $AdUser = Get-ADUser -Identity $identity
    Add-ADGroupMember -Identity $GroupName -Members $AdUser

}

# Create GPO for allowing RDP