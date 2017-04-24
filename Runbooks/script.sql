CREATE TABLE [dbo].[CMS_Host_BaseTable](
	[IP Address] [nvarchar](max) NOT NULL,
	[Subnet Mask] [nvarchar](max) NOT NULL,
	[Gateway IP] [nvarchar](max) NULL,
	[Environment] [nvarchar](max) NULL,
	[CMS Source] [nvarchar](max) NULL,
	[Hostname] [nvarchar](max) NULL,
	[FQDN] [nvarchar](max) NULL,
	[Endpoint MAC Address] [nvarchar](max) NULL,
	[Status] [nvarchar](max) NULL,
	[Interface] [nvarchar](max) NULL,
	[Type] [nvarchar](max) NULL,
	[CIDR] [nvarchar](max) NULL,
	[Upld_Dttm] [nvarchar](max) NULL
)

CREATE TABLE [dbo].[CMS_Network_BaseTable](
	[Network Address] [nvarchar](max) NOT NULL,
	[Environment] [nvarchar](max) NOT NULL,
	[CMS Source] [nvarchar](max) NULL,
	[Hostname] [nvarchar](max) NULL,
	[Network Device Gateway Location] [nvarchar](max) NULL,
	[IP Status] [nvarchar](max) NULL,
	[Interface] [nvarchar](max) NULL,
	[Type] [nvarchar](max) NULL,
	[Network IP Address] [nvarchar](max) NOT NULL,
	[DateTime] [nvarchar](max) NULL
)

