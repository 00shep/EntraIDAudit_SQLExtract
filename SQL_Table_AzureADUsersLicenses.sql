/****** Object:  Table [dbo].[AzureADUsersLicenses]    Script Date: 11/10/2022 4:52:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AzureADUsersLicenses](
	[UserPrincipalName] [varchar](64) NOT NULL,
	[LicenseSkuID] [varchar](64) NOT NULL,
 CONSTRAINT [PK_AzureADUserLicense] PRIMARY KEY CLUSTERED 
(
	[UserPrincipalName] ASC,
	[LicenseSkuID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

