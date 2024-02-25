<powershell>
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment
$secpass=ConvertTo-SecureString "Test2024!" -AsPlainText -Force
$dmnname = "rtsnetworking.com"
Install-ADDSForest  -DomainName $dmnname   -InstallDns:$true  -NoRebootOnCompletion:$false  -SafeModeAdministratorPassword $secpass -Force:$true 
</powershell>
