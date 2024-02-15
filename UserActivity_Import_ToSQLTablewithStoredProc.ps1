param($SQLServer,$SQLDatabase,$SQLTable,$SQLStoredProc,$SQLStoredProcParam,$table)

#Retrieve managed identity context token
$queryParameter = "?resource=https://database.windows.net/" 
$url = $env:IDENTITY_ENDPOINT + $queryParameter
$Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]" 
$Headers.Add("X-IDENTITY-HEADER", $env:IDENTITY_HEADER) 
$Headers.Add("Metadata", "True") 
$content =[System.Text.Encoding]::Default.GetString((Invoke-WebRequest -UseBasicParsing -Uri $url -Method 'GET' -Headers $Headers).RawContentStream.ToArray()) | ConvertFrom-Json 
$Token = $content.access_token 
echo "The managed identities for Azure resources access token is $Token"

#Specify SQL Server and DB Name
$SQLServerName = $SQLServer    # Azure SQL logical server name  
$DatabaseName = $SQLDatabase     # Azure SQL database name
$tableName = $SQLTable #Azure SQL database table name
$table = $table #temp table containing data collected for import job
$SQLStoredProc = $SQLStoredProc #stored proc to execute
$SQLStoredProcParam = $SQLStoredProcParam #stored proc parameter for type lookup

write-output "SQL Server" $SQLServerName
write-output "Database" $DatabaseName
write-output "SQL Table" $SQLTable
write-output "Stored Proc" $SQLStoredProc
write-output "Stored Proc Param" $SQLStoredProcParam

###########################################################
#Open Connection
Write-Output "Create SQL connection string" 
$conn = New-Object System.Data.SqlClient.SQLConnection  
$conn.ConnectionString = "Data Source=$SQLServerName;Initial Catalog=$DatabaseName;Connect Timeout=30" 
$conn.AccessToken = $Token
Write-Output "Connect to database and execute SQL script" 
$conn.Open() 
$Command = New-Object System.Data.SQLClient.SQLCommand
$Command.Connection = $conn

###########################################################
write-output "Executing SQL stored procedure"
#configure command type as stored procedure
$Command.CommandType = [System.Data.CommandType]::StoredProcedure
$Command.commandText = $SQLStoredProc

#sql table type param
$perfResultsParam = New-Object('system.data.sqlclient.sqlparameter')
$perfResultsParam.ParameterName = $SQLStoredProcParam
$perfResultsParam.SqlDBtype = [System.Data.SqlDbType]::Structured
$perfResultsParam.Direction = [System.Data.ParameterDirection]::Input
$perfResultsParam.value = $table

#execute SQL Command and output results
Write-Output "results"
$Command.parameters.add($perfResultsParam); 
$Command.ExecuteNonQuery()

###########################################################

#Close Connection
$conn.Close()
