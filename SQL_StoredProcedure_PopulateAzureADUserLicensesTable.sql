/****** Object:  StoredProcedure [dbo].[PopulateAzureADUserLicensesTable]    Script Date: 11/10/2022 4:48:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE    PROCEDURE [dbo].[PopulateAzureADUserLicensesTable]
    -- Add the parameters for the stored procedure here
    @ParamTypeAzureADUserLicense dbo.TypeAzureADUserLicenses READONLY
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	DELETE FROM dbo.AzureADUsersLicenses;
	INSERT INTO dbo.AzureADUsersLicenses
    (
			UserPrincipalName,
			LicenseSkuID
    )
    SELECT UserPrincipalName,
			LicenseSkuID
    FROM @ParamTypeAzureADUserLicense;
END;
GO

