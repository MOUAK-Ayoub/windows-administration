

$ad_user = @'
[{
    "firstname"  :"imane",
    "lastname"   :"azirar",
    "logon_name":"iazirar",
    "pwd"       :"Test2024!"
    }, {
    "firstname"  :"ayoub",
    "lastname"   :"mouak",
    "logon_name" :"amouak",
    "pwd"        :"Test2024!"

  }]
'@
$data = ConvertFrom-Json $ad_user

foreach ($elem in $data)
{
    $secure_pwd=ConvertTo-SecureString $elem.pwd -AsPlainText -Force
    New-ADUser -Name $( $elem.firstname + " " + $elem.lastname ) -givenName $elem.firstname -Surname $elem.lastname `
    -UserPrincipalName  $elem.logon_name -SamAccountName $elem.logon_name  -AccountPassword $secure_pwd -Enabled $true


}