/****** Object:  UserDefinedTableType [dbo].[TypeAzureADUser]    Script Date: 11/10/2022 4:50:23 PM ******/
CREATE TYPE [dbo].[TypeAzureADUser] AS TABLE(
	[UserPrincipalName] [varchar](256) NOT NULL,
	[OnPremSyncEnabled] [varchar](8) NULL,
	[UserType] [varchar](64) NULL,
	[UsageLocation] [varchar](8) NULL,
	PRIMARY KEY CLUSTERED 
(
	[UserPrincipalName] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO

