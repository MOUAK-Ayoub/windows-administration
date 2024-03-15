<powershell>
$master_private_ip = "${master_private_ip}"

<#

$slave_num = "${slave_number}"
$domain_name = "${domain_name}"
$logon_name = "${logon_name}"
$pwd = "${pwd}"
#>

Set-DnsClientServerAddress -InterfaceAlias 'Ethernet*' -ServerAddresses $master_private_ip

$slave_num = "1"
$domain_name = "mathai.local"
$logon_name = "iimane"
$pwd = "Test2024!"
$joinCred = New-Object pscredential -ArgumentList ([pscustomobject]@{
    UserName = "$domain_name\$logon_name"
    Password = (ConvertTo-SecureString -String $pwd -AsPlainText -Force)[0]
})
Add-Computer   -DomainName $domain_name  -NewName "computer-$slave_num" -Credential $joinCred -Restart

</powershell>
