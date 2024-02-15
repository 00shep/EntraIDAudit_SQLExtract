##########################################
#             Initialize Vars            #
##########################################
$arraydata = @()

[String]$SQLServer = Get-AutomationVariable -Name 'UserMgmt-SQLServer'
[String]$SQLDatabase = Get-AutomationVariable -Name 'UserMgmt-Database'
[String]$SQLTable = Get-AutomationVariable -Name 'UserMgmt-AzureADImportTable'
[String]$SQLStoredProc = Get-AutomationVariable -Name 'UserMgmt-AzureADImportStoredProc'
[String]$SQLStoredProcParam = Get-AutomationVariable -Name 'UserMgmt-AzureADImportStoredProcParam'

##########################################
#Get Automation Account Managed Identity #
##########################################

Connect-azaccount -identity
$context = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile.DefaultContext
$graphToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, "https://graph.microsoft.com").AccessToken
$aadToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, "https://graph.windows.net").AccessToken

Write-Output "Hi I'm $($context.Account.Id)"

##########################################
#          Connect to Azure AD           #
##########################################

Connect-AzureAD -AadAccessToken $aadToken -AccountId $context.Account.Id -TenantId $context.tenant.id

##########################################
#          Gather Data for SQL           #
##########################################

$arraydata = get-azureaduser -All $True | select-object userprincipalname,DirSyncEnabled,UserType,UsageLocation | sort UserPrincipalName

##########################################
#          Create Empty Table            #
##########################################
write-output "Creating empty SQL data table in memory"
#build an empty data table in the expected SQL format
[System.Data.DataTable]$table = New-Object('system.Data.DataTable')

		$table.Columns.Add("UserPrincipalName","System.String")
		$table.Columns.Add("OnPremSyncEnabled","System.String")
		$table.Columns.Add("UserType","System.String")
		$table.Columns.Add("UsageLocation","System.String")

##########################################
#           Populate Table               #
##########################################

write-output "Adding report data to PowerShell SQL data table object"
foreach($aRow in $arraydata)
{
    $row = $table.NewRow()
		$row.UserPrincipalName = $arow.UserPrincipalName
		$row.OnPremSyncEnabled = $arow.DirSyncEnabled
		$row.UserType  = $arow.UserType 
		$row.UsageLocation = $arow.UsageLocation

	$table.Rows.Add($row)
}

$tablecount = $table.Rows.count
write-output "Discovered $tablecount employee records"


##########################################
# Set SQL Vars / Start SQL Import Runbook#
##########################################

.\UserMgmt-SQLTableImportwithStoredProc.ps1 `
		-SQLServer $SQLServer `
		-SQLDatabase $SQLDatabase `
		-SQLTable $SQLTable `
		-SQLStoredProc $SQLStoredProc `
		-SQLStoredProcParam $SQLStoredProcParam `
		-table $table
