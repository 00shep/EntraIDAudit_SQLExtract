# EntraIDAudit_SQLExtract
Pull data from AD, Entra, etc. to create SQL tables and views. Execute from Azure Automation and eventually report with PowerBI.

The original purpose of this content was to create a means to audit stale users, unused licenses, etc. for enterprise cost savings.

**High Level Steps**
1. Create Azure Automation account
2. Create Azure SQL database
3. Create Azure SQL tables (sql scripts)
4. Create Azure SQL types (sql scripts)
5. Create Azure SQL views (sql scripts)
6. Create Azure SQL stored procs (sql scripts)
7. Create variables in Azure Automation to be referenced by runbook
        SQL Server name
        Databse names
        Table names
        Stored Procedure names
        Stored Procedure parameter names
8. Create Managed Identity for Azure Automation account
9. Grant Azure Automation Managed Identity access to related resources: Azure SQL, Entra, Log Analytics as necessary
10. Create Azure Automation PowerShell Runbooks based on ps1 files from repo
11. Ensure that your Azure Automation variable names match your runbooks
12. Populate License Summary table (this allows matching names and prices which will vary based on your MS agreements)



**Sign-In Log Activity**
If you plan to use sign-in logs from Entra via Log Analytics - I've included some useful KQL queries. That said, no idea what I did with the associated ps1 files. You can use PowerShell to execute KQL queries against LA with relative ease.
* You may need to make some additional scripts for the Log Analytics
* You'll need to make sure Entra is configured to send ALL sign-in logs to Log Analytics; interactive, non-interactive, service principal, etc.

--------------
This originally started as a way to sync HR data from UltiPro/UKG into Active Directory -- keeping employee attributes up to date. 
Getting better reporting on licensing based on user activity was an iteration that came later.

* v1.0 -- https://00shep.blogspot.com/2021/03/ultipro-sync-user-attributes-to-active.html
* v0.1 -- https://00shep.blogspot.com/search/label/UltiPro
--------------

The goal is to achieve a PowerBI report that looks something like this. You'll have to make your own .pbix


![image](https://github.com/00shep/EntraIDAudit_SQLExtract/assets/67474975/c980e76d-f85b-4d8a-8d60-366a381740cd)
