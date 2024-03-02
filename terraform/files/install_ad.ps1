<powershell>
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
$secpass=ConvertTo-SecureString "${pwd}" -AsPlainText -Force
$domain_name = "${domain_name}"
Install-ADDSForest   -DomainName $domain_name   -InstallDns:$true   -SafeModeAdministratorPassword $secpass -Force:$true



</powershell>
