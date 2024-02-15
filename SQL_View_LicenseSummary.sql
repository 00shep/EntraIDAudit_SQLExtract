/****** Object:  View [dbo].[LicenseSummary]    Script Date: 11/10/2022 5:13:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[LicenseSummary]
AS
SELECT
    --ADUsers
    [UserPrincipalName] = COALESCE(ADU.[UserPrincipalName], AZU.[UserPrincipalName], UKG.[givenName]+' '+UKG.[LastName])
  , [EmployeeID]        = COALESCE(ADU.[EmployeeID], UKG.[employeeID]) --<<< could different from AD / null in UKG (employees vs. contractors)
  , [ManagerName]		= Manager.givenName+' '+Manager.lastName
  , ADU.[AccountExpirationDate]
  , ADU.[CanonicalName]
  , ADU.[City]
  , ADU.[Company]
  , ADU.[Department]
  , ADU.[Description]
  , ADU.[DisplayName]
  , ADU.[DistinguishedName]
  , ADU.[Enabled]
  , ADU.[ipPhone]
  , ADU.[LastLogonDate]
  , ADU.[mail]
  , ADU.[Manager]
  , ADU.[Office]
  , ADU.[OfficePhone]
  , ADU.[PasswordExpired]
  , ADU.[PasswordLastSet]
  , ADU.[PasswordNeverExpires]
  , ADU.[physicalDeliveryOfficeName]
  , ADU.[State]
  , ADU.[StreetAddress]
  , ADU.[telephoneNumber]
  , ADU.[Title]
  , ADU.[whenCreated]
                                                                       --AzureADUsers
  , AZU.[OnPremSyncEnabled]
  , AZU.[UserType]
  , AZU.[UsageLocation]


                                                                       --UKGActiveComputerUsers
  , UKG.[ManagerEmpoyeeID]
  , UKG.[HireDate]
  , LL.TotalCount
  , LL.TotalCost
FROM dbo.ADUsers                     AS ADU
FULL OUTER JOIN dbo.AzureADUsers     AS AZU ON AZU.UserPrincipalName = ADU.UserPrincipalName
FULL OUTER JOIN dbo.UKGActiveComputerUsers AS UKG ON UKG.employeeID = ADU.EmployeeID
LEFT JOIN (
              SELECT LD.UserPrincipalName, TotalCount = COUNT(LD.UserPrincipalName), TotalCost = SUM(LD.LicenseCost)
              FROM dbo.LicenseDetail AS LD
              GROUP BY LD.UserPrincipalName
          )                          AS LL ON LL.UserPrincipalName = COALESCE(ADU.UserPrincipalName, AZU.UserPrincipalName)
LEFT JOIN dbo.UKGActiveComputerUsers as Manager on Manager.EmployeeID = UKG.ManagerEmpoyeeID;
GO

