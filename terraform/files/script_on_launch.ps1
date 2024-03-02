<powershell>
<#
$slave_num = "${slave_number}"
$master_private_ip = "${master_private_ip}"
$domain_name = "${domain_name}"
$logon_name = "${logon_name}"
$pwd = "${pwd}"
#>
$slave_num = "${slave_number}"
$master_private_ip = "${master_private_ip}"
$domain_name = "${domain_name}"
$logon_name = "${logon_name}"
$pwd = "${pwd}"
Set-DnsClientServerAddress -InterfaceAlias 'Ethernet*' -ServerAddresses $master_private_ip
$joinCred = New-Object pscredential -ArgumentList ([pscustomobject]@{
    UserName = "$domain_name\$logon_name"
    Password = (ConvertTo-SecureString -String $pwd -AsPlainText -Force)[0]
})
Add-Computer   -DomainName $domain_name  -NewName "computer-$slave_num" -Credential $joinCred

</powershell>
