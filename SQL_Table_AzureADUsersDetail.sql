/****** Object:  Table [dbo].[AzureADUsers]    Script Date: 11/10/2022 4:51:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AzureADUsers](
	[UserPrincipalName] [varchar](256) NOT NULL,
	[OnPremSyncEnabled] [varchar](8) NULL,
	[UserType] [varchar](64) NULL,
	[UsageLocation] [varchar](8) NULL,
 CONSTRAINT [PK_AzureADUsers] PRIMARY KEY CLUSTERED 
(
	[UserPrincipalName] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

