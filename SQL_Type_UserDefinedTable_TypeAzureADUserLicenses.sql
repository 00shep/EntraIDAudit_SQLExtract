/****** Object:  UserDefinedTableType [dbo].[TypeAzureADUserLicenses]    Script Date: 11/10/2022 4:50:39 PM ******/
CREATE TYPE [dbo].[TypeAzureADUserLicenses] AS TABLE(
	[UserPrincipalName] [varchar](256) NOT NULL,
	[LicenseSkuID] [varchar](64) NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[UserPrincipalName] ASC,
	[LicenseSkuID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO

