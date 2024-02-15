##########################################
#          Gather Data for SQL           #
##########################################
$arraydata = @()

$arraydata += Get-ADUser -Filter * -Properties * | where-object {`
$_.CanonicalName -notlike "*Email*" -and `  #Shared mailboxes aren't users in the interactive sense
$_.CanonicalName -notlike "*Microsoft Exchange System Objects*" -and `  #Filter out Exchange Health mailboxes objects
$_.CanonicalName -notlike "*/Users/*"  #Filter out Exchange Health mailboxes objects
}

##########################################
#          Create Empty Table            #
##########################################
write-output "Creating empty SQL data table in memory"
#build an empty data table in the expected SQL format
[System.Data.DataTable]$table = New-Object('system.Data.DataTable')

		$table.Columns.Add("SamAccountName","System.String")
		$table.Columns.Add("AccountExpirationDate","System.String")
		$table.Columns.Add("c","System.String")
		$table.Columns.Add("CannotChangePassword","System.String")
		$table.Columns.Add("CanonicalName","System.String")
		$table.Columns.Add("City","System.String")
		$table.Columns.Add("co","System.String")
		$table.Columns.Add("Company","System.String")
		$table.Columns.Add("Department","System.String")
		$table.Columns.Add("Description","System.String")
		$table.Columns.Add("DisplayName","System.String")
		$table.Columns.Add("DistinguishedName","System.String")
		$table.Columns.Add("Division","System.String")
		$table.Columns.Add("EmployeeID","System.String")
		$table.Columns.Add("Enabled","System.String")
		$table.Columns.Add("extensionAttribute11","System.String")
		$table.Columns.Add("extensionAttribute12","System.String")
		$table.Columns.Add("extensionAttribute13","System.String")
		$table.Columns.Add("extensionAttribute14","System.String")
		$table.Columns.Add("GivenName","System.String")
		$table.Columns.Add("HomeDirectory","System.String")
		$table.Columns.Add("HomeDrive","System.String")
		$table.Columns.Add("ipPhone","System.String")
		$table.Columns.Add("Location","System.String")
		$table.Columns.Add("LastLogonDate","System.String")
		$table.Columns.Add("mail","System.String")
		$table.Columns.Add("Manager","System.String")
		$table.Columns.Add("MobilePhone","System.String")
		$table.Columns.Add("Name","System.String")
		$table.Columns.Add("ObjectGUID","System.String")
		$table.Columns.Add("objectSid","System.String")
		$table.Columns.Add("Office","System.String")
		$table.Columns.Add("OfficePhone","System.String")
		$table.Columns.Add("PasswordExpired","System.String")
		$table.Columns.Add("PasswordLastSet","System.String")
		$table.Columns.Add("PasswordNeverExpires","System.String")
		$table.Columns.Add("physicalDeliveryOfficeName","System.String")
		$table.Columns.Add("PostalCode","System.String")
		$table.Columns.Add("State","System.String")
		$table.Columns.Add("StreetAddress","System.String")
		$table.Columns.Add("Surname","System.String")
		$table.Columns.Add("telephoneNumber","System.String")
		$table.Columns.Add("Title","System.String")
		$table.Columns.Add("UserPrincipalName","System.String")
		$table.Columns.Add("whenChanged","System.String")
		$table.Columns.Add("whenCreated","System.String")

##########################################
#           Populate Table               #
##########################################

write-output "Adding report data to PowerShell SQL data table object"
foreach($aRow in $arraydata)
{
    $row = $table.NewRow()
		$row.SamAccountName = $arow.SamAccountName
		$row.AccountExpirationDate = $arow.AccountExpirationDate
		$row.c = $arow.c
		$row.CannotChangePassword  = $arow.CannotChangePassword 
		$row.CanonicalName = $arow.CanonicalName
		$row.City = $arow.City
		$row.co = $arow.co
		$row.Company = $arow.Company
		$row.Department = $arow.Department 
		$row.Description = $arow.Description
		$row.DisplayName = $arow.DisplayName
		$row.DistinguishedName = $arow.DistinguishedName
		$row.Division = $arow.Division
		$row.EmployeeID = $arow.EmployeeID
		$row.Enabled = $arow.Enabled
		$row.extensionAttribute11 = $arow.extensionAttribute11
		$row.extensionAttribute12 = $arow.extensionAttribute12
		$row.extensionAttribute13 = $arow.extensionAttribute13
		$row.extensionAttribute14 = $arow.extensionAttribute14 
		$row.GivenName = $arow.GivenName
		$row.HomeDirectory = $arow.HomeDirectory
		$row.HomeDrive = $arow.HomeDrive
		$row.ipPhone = $arow.ipPhone
		$row.Location = $arow.Location
		$row.LastLogonDate = $arow.LastLogonDate
		$row.mail = $arow.mail
		$row.Manager = $arow.Manager
		$row.MobilePhone = $arow.MobilePhone
		$row.Name = $arow.Name
		$row.ObjectGUID = $arow.ObjectGUID
		$row.objectSid = $arow.objectSid
		$row.Office = $arow.Office
		$row.OfficePhone  = $arow.OfficePhone 
		$row.PasswordExpired = $arow.PasswordExpired
		$row.PasswordLastSet = $arow.PasswordLastSet
		$row.PasswordNeverExpires = $arow.PasswordNeverExpires
		$row.physicalDeliveryOfficeName = $arow.physicalDeliveryOfficeName
		$row.PostalCode = $arow.PostalCode
		$row.State = $arow.State
		$row.StreetAddress = $arow.StreetAddress
		$row.Surname = $arow.Surname
		$row.telephoneNumber = $arow.telephoneNumber
		$row.Title = $arow.Title
		$row.UserPrincipalName = $arow.UserPrincipalName
		$row.whenChanged = $arow.whenChanged
		$row.whenCreated = $arow.whenCreated

    $table.Rows.Add($row)
}

$tablecount = $table.Rows.count
write-output "Discovered $tablecount employee records"

##########################################
# Set SQL Vars / Start SQL Import Runbook#
##########################################
[String]$SQLServer = Get-AutomationVariable -Name 'UserMgmt-SQLServer'
[String]$SQLDatabase = Get-AutomationVariable -Name 'UserMgmt-Database'
[String]$SQLTable = Get-AutomationVariable -Name 'UserMgmt-ADImportTable'
[String]$SQLStoredProc = Get-AutomationVariable -Name 'UserMgmt-ADImportStoredProc'
[String]$SQLStoredProcParam = Get-AutomationVariable -Name 'UserMgmt-ADImportStoredProcParam'

.\UserMgmt-SQLTableImportwithStoredProc.ps1 `
		-SQLServer $SQLServer `
		-SQLDatabase $SQLDatabase `
		-SQLTable $SQLTable `
		-SQLStoredProc $SQLStoredProc `
		-SQLStoredProcParam $SQLStoredProcParam `
		-table $table
