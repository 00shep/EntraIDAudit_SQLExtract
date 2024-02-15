/****** Object:  View [dbo].[LicenseDetail]    Script Date: 11/10/2022 5:12:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[LicenseDetail]
AS
SELECT ADL.UserPrincipalName, DisplayName = COALESCE(ADU.DisplayName, ''), ADL.LicenseSkuID, LicenseName = COALESCE(XR.LicenseName, 'Unknown'), LicenseType = COALESCE(XR.LicenseType, 'Unknown'), LicenseCost = COALESCE(XR.LicenseCost, 0)
FROM dbo.AzureADUsersLicenses         AS ADL
LEFT JOIN dbo.AzureADUsersLicenseXRef AS XR ON ADL.LicenseSkuID = LEFT(XR.LicenseSkuID, 36)
LEFT JOIN dbo.ADUsers                 AS ADU ON ADU.UserPrincipalName = ADL.UserPrincipalName;
GO

