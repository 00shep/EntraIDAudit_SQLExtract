/****** Object:  StoredProcedure [dbo].[PopulateAzureADUserTable]    Script Date: 11/10/2022 4:48:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE    PROCEDURE [dbo].[PopulateAzureADUserTable]
    -- Add the parameters for the stored procedure here
    @ParamTypeAzureADUser dbo.TypeAzureADUser READONLY
AS

BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DELETE FROM dbo.AzureADUsers;

    INSERT INTO dbo.AzureADUsers
    (
			UserPrincipalName,
			OnPremSyncEnabled,
			UserType,
			UsageLocation
    )
    SELECT UserPrincipalName,
			OnPremSyncEnabled,
			UserType,
			UsageLocation

    FROM @ParamTypeAzureADUser;

END;
GO

