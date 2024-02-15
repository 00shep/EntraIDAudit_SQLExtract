/****** Object:  Table [dbo].[ADUsers]    Script Date: 11/10/2022 4:51:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ADUsers](
	[SamAccountName] [varchar](32) NOT NULL,
	[AccountExpirationDate] [datetime] NULL,
	[c] [varchar](8) NULL,
	[CannotChangePassword] [varchar](8) NULL,
	[CanonicalName] [varchar](256) NULL,
	[City] [varchar](32) NULL,
	[co] [varchar](64) NULL,
	[Company] [varchar](64) NULL,
	[Department] [varchar](64) NULL,
	[Description] [varchar](2048) NULL,
	[DisplayName] [varchar](64) NULL,
	[DistinguishedName] [varchar](256) NULL,
	[Division] [varchar](64) NULL,
	[EmployeeID] [varchar](6) NULL,
	[Enabled] [varchar](8) NULL,
	[extensionAttribute11] [varchar](8) NULL,
	[extensionAttribute12] [varchar](32) NULL,
	[extensionAttribute13] [varchar](8) NULL,
	[extensionAttribute14] [varchar](32) NULL,
	[GivenName] [varchar](64) NULL,
	[HomeDirectory] [varchar](256) NULL,
	[HomeDrive] [varchar](8) NULL,
	[ipPhone] [varchar](32) NULL,
	[Location] [varchar](64) NULL,
	[LastLogonDate] [datetime] NULL,
	[mail] [varchar](256) NULL,
	[Manager] [varchar](256) NULL,
	[MobilePhone] [varchar](32) NULL,
	[Name] [varchar](64) NULL,
	[ObjectGUID] [varchar](64) NULL,
	[objectSid] [varchar](64) NULL,
	[Office] [varchar](256) NULL,
	[OfficePhone] [varchar](32) NULL,
	[PasswordExpired] [varchar](8) NULL,
	[PasswordLastSet] [datetime] NULL,
	[PasswordNeverExpires] [varchar](8) NULL,
	[physicalDeliveryOfficeName] [varchar](256) NULL,
	[PostalCode] [varchar](16) NULL,
	[State] [varchar](32) NULL,
	[StreetAddress] [varchar](64) NULL,
	[Surname] [varchar](64) NULL,
	[telephoneNumber] [varchar](32) NULL,
	[Title] [varchar](256) NULL,
	[UserPrincipalName] [varchar](256) NULL,
	[whenChanged] [datetime] NULL,
	[whenCreated] [datetime] NULL,
 CONSTRAINT [PK_ADUsers] PRIMARY KEY CLUSTERED 
(
	[SamAccountName] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

