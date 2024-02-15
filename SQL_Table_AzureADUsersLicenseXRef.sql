/****** Object:  Table [dbo].[AzureADUsersLicenseXRef]    Script Date: 11/10/2022 4:54:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AzureADUsersLicenseXRef](
	[LicenseSkuID] [varchar](64) NULL,
	[LicenseName] [varchar](64) NULL,
	[LicenseType] [varchar](64) NULL,
	[LicenseCost] [numeric](24, 2) NULL
) ON [PRIMARY]
GO

