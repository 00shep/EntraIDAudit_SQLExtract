/****** Object:  StoredProcedure [dbo].[PopulateADUserTable]    Script Date: 11/10/2022 4:47:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[PopulateADUserTable]
    -- Add the parameters for the stored procedure here
    @ParamTypeADUser dbo.TypeADUsers READONLY
AS

BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DELETE FROM dbo.ADUsers;

    INSERT INTO dbo.ADUsers
    (
			SamAccountName,
			AccountExpirationDate,
			c,
			CannotChangePassword,
			CanonicalName,
			City,
			co,
			Company,
			Department,
			Description,
			DisplayName,
			DistinguishedName,
			Division,
			EmployeeID,
			Enabled,
			extensionAttribute11,
			extensionAttribute12,
			extensionAttribute13,
			extensionAttribute14,
			GivenName,
			HomeDirectory,
			HomeDrive,
			ipPhone,
			Location,
			LastLogonDate,
			mail,
			Manager,
			MobilePhone,
			Name,
			ObjectGUID,
			objectSid,
			Office,
			OfficePhone,
			PasswordExpired,
			PasswordLastSet,
			PasswordNeverExpires,
			physicalDeliveryOfficeName,
			PostalCode,
			State,
			StreetAddress,
			Surname,
			telephoneNumber,
			Title,
			UserPrincipalName,
			whenChanged,
			whenCreated
    )
    SELECT SamAccountName,
			AccountExpirationDate,
			c,
			CannotChangePassword,
			CanonicalName,
			City,
			co,
			Company,
			Department,
			Description,
			DisplayName,
			DistinguishedName,
			Division,
			EmployeeID,
			Enabled,
			extensionAttribute11,
			extensionAttribute12,
			extensionAttribute13,
			extensionAttribute14,
			GivenName,
			HomeDirectory,
			HomeDrive,
			ipPhone,
			Location,
			LastLogonDate,
			mail,
			Manager,
			MobilePhone,
			Name,
			ObjectGUID,
			objectSid,
			Office,
			OfficePhone,
			PasswordExpired,
			PasswordLastSet,
			PasswordNeverExpires,
			physicalDeliveryOfficeName,
			PostalCode,
			State,
			StreetAddress,
			Surname,
			telephoneNumber,
			Title,
			UserPrincipalName,
			whenChanged,
			whenCreated
    FROM @ParamTypeADUser;

END;
GO

