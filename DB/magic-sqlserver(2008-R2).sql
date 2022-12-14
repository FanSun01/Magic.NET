USE [master]
GO
/****** Object:  Database [Magic]    Script Date: 2022/4/27 18:03:51 ******/
CREATE DATABASE [Magic] ON  PRIMARY 
( NAME = N'Magic', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Magic.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Magic_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Magic_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Magic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Magic] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Magic] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Magic] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Magic] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Magic] SET ARITHABORT OFF 
GO
ALTER DATABASE [Magic] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Magic] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Magic] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Magic] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Magic] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Magic] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Magic] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Magic] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Magic] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Magic] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Magic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Magic] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Magic] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Magic] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Magic] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Magic] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Magic] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Magic] SET RECOVERY FULL 
GO
ALTER DATABASE [Magic] SET  MULTI_USER 
GO
ALTER DATABASE [Magic] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Magic] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Magic', N'ON'
GO
USE [Magic]
GO
/****** Object:  Table [dbo].[documentation]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[documentation](
	[Id] [bigint] NOT NULL,
	[PId] [bigint] NOT NULL,
	[PIds] [nvarchar](max) NULL,
	[Name] [varchar](100) NOT NULL,
	[DocumentType] [int] NOT NULL,
	[FileSuffix] [nvarchar](50) NULL,
	[FileSizeKb] [int] NULL,
	[FileObjectName] [nvarchar](100) NULL,
	[FilePath] [nvarchar](200) NULL,
	[Label] [int] NULL,
	[Remark] [nvarchar](200) NULL,
	[Visible] [bit] NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [varchar](36) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [varchar](100) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Document_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[flc_customform]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[flc_customform](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Sort] [bigint] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[Remark] [text] NULL,
	[FlowInstanceId] [bigint] NOT NULL,
 CONSTRAINT [PK_flc_customform] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[flc_flowinstance]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[flc_flowinstance](
	[Id] [bigint] NOT NULL,
	[InstanceSchemeId] [bigint] NULL,
	[Code] [nvarchar](50) NULL,
	[CustomName] [nvarchar](100) NULL,
	[ActivityId] [nvarchar](50) NULL,
	[ActivityType] [bigint] NULL,
	[ActivityName] [nvarchar](50) NULL,
	[PreviousId] [nvarchar](50) NULL,
	[SchemeContent] [text] NULL,
	[SchemeId] [bigint] NULL,
	[DbName] [nvarchar](50) NULL,
	[FrmData] [text] NULL,
	[FrmType] [bigint] NOT NULL,
	[FrmContentData] [text] NULL,
	[FrmContentParse] [text] NULL,
	[FrmId] [bigint] NULL,
	[SchemeType] [text] NULL,
	[FlowLevel] [bigint] NOT NULL,
	[IsFinish] [bigint] NOT NULL,
	[FrmContent] [text] NULL,
	[MakerList] [text] NULL,
	[OrgId] [bigint] NULL,
	[Active] [text] NULL,
	[Remark] [text] NULL,
	[CreatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[Status] [bigint] NOT NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedTime] [datetime] NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_flc_flowinstance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[flc_flowinstancehis]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[flc_flowinstancehis](
	[Id] [bigint] NOT NULL,
	[InstanceId] [bigint] NOT NULL,
	[FromNodeId] [nvarchar](50) NULL,
	[FromNodeType] [bigint] NULL,
	[FromNodeName] [nvarchar](50) NULL,
	[ToNodeId] [nvarchar](50) NULL,
	[ToNodeType] [bigint] NULL,
	[ToNodeName] [nvarchar](50) NULL,
	[TransitionSate] [bigint] NOT NULL,
	[IsFinish] [bigint] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
 CONSTRAINT [PK_flc_flowinstancehis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[flc_flowinstanceinfo]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[flc_flowinstanceinfo](
	[Id] [bigint] NOT NULL,
	[InstanceId] [nvarchar](50) NOT NULL,
	[Content] [nvarchar](250) NULL,
	[CreatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](50) NULL,
 CONSTRAINT [PK_flc_flowinstanceinfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[flc_flowscheme]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[flc_flowscheme](
	[Id] [bigint] NOT NULL,
	[SchemeCode] [varchar](64) NULL,
	[SchemeName] [varchar](64) NULL,
	[SchemeType] [varchar](64) NULL,
	[SchemeVersion] [varchar](64) NULL,
	[SchemeCanUser] [varchar](64) NULL,
	[SchemeContent] [text] NULL,
	[FrmId] [bigint] NULL,
	[FrmType] [int] NOT NULL,
	[AuthorizeType] [int] NULL,
	[OrgId] [bigint] NULL,
	[Active] [varchar](64) NULL,
	[Status] [int] NOT NULL,
	[Sort] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[Remark] [varchar](128) NULL,
	[IsDeleted] [int] NOT NULL,
 CONSTRAINT [PK_flc_flowscheme] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[flc_form]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[flc_form](
	[Id] [bigint] NOT NULL,
	[Name] [varchar](64) NULL,
	[FrmType] [int] NULL,
	[WebId] [varchar](64) NULL,
	[Fields] [int] NULL,
	[ContentData] [varchar](1024) NULL,
	[ContentParse] [text] NULL,
	[Content] [text] NULL,
	[DbName] [varchar](64) NULL,
	[OrgId] [bigint] NULL,
	[Active] [varchar](64) NULL,
	[Status] [int] NOT NULL,
	[Sort] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](50) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](50) NULL,
	[Remark] [varchar](128) NULL,
	[IsDeleted] [int] NOT NULL,
 CONSTRAINT [PK_flc_form] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_app]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_app](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Active] [nvarchar](5) NULL,
	[Status] [int] NOT NULL,
	[Sort] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_app] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_code_gen]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_code_gen](
	[Id] [bigint] NOT NULL,
	[AuthorName] [nvarchar](20) NULL,
	[TablePrefix] [nvarchar](5) NULL,
	[GenerateType] [nvarchar](20) NULL,
	[TableName] [nvarchar](100) NULL,
	[NameSpace] [nvarchar](100) NULL,
	[BusName] [nvarchar](100) NULL,
	[MenuApplication] [nvarchar](50) NULL,
	[MenuPid] [bigint] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_code_gen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_code_gen_config]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_code_gen_config](
	[Id] [bigint] NOT NULL,
	[CodeGenId] [bigint] NOT NULL,
	[ColumnName] [nvarchar](100) NOT NULL,
	[ColumnComment] [nvarchar](100) NULL,
	[NetType] [nvarchar](50) NULL,
	[EffectType] [nvarchar](50) NULL,
	[FkEntityName] [nvarchar](50) NULL,
	[FkColumnName] [nvarchar](50) NULL,
	[FkColumnNetType] [nvarchar](50) NULL,
	[DictTypeCode] [nvarchar](50) NULL,
	[WhetherRetract] [nvarchar](5) NULL,
	[WhetherRequired] [nvarchar](5) NULL,
	[QueryWhether] [nvarchar](5) NULL,
	[QueryType] [nvarchar](10) NULL,
	[WhetherTable] [nvarchar](5) NULL,
	[WhetherAddUpdate] [nvarchar](5) NULL,
	[ColumnKey] [nvarchar](5) NULL,
	[DataType] [nvarchar](50) NULL,
	[WhetherCommon] [nvarchar](5) NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_code_gen_config] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_config]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_config](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](50) NULL,
	[SysFlag] [nvarchar](5) NULL,
	[Remark] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[GroupCode] [nvarchar](50) NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_config] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_dict_data]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_dict_data](
	[Id] [bigint] NOT NULL,
	[TypeId] [bigint] NOT NULL,
	[Value] [nvarchar](100) NULL,
	[Code] [nvarchar](100) NULL,
	[Sort] [int] NOT NULL,
	[Remark] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_dict_data] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_dict_type]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_dict_type](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Sort] [int] NOT NULL,
	[Remark] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_dict_type] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_emp]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_emp](
	[Id] [bigint] NOT NULL,
	[JobNum] [nvarchar](30) NULL,
	[OrgId] [bigint] NOT NULL,
	[OrgName] [nvarchar](50) NULL,
 CONSTRAINT [PK_sys_emp] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_emp_ext_org_pos]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_emp_ext_org_pos](
	[SysEmpId] [bigint] NOT NULL,
	[SysOrgId] [bigint] NOT NULL,
	[SysPosId] [bigint] NOT NULL,
 CONSTRAINT [PK_sys_emp_ext_org_pos] PRIMARY KEY CLUSTERED 
(
	[SysEmpId] ASC,
	[SysOrgId] ASC,
	[SysPosId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_emp_pos]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_emp_pos](
	[SysEmpId] [bigint] NOT NULL,
	[SysPosId] [bigint] NOT NULL,
 CONSTRAINT [PK_sys_emp_pos] PRIMARY KEY CLUSTERED 
(
	[SysEmpId] ASC,
	[SysPosId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_file]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_file](
	[Id] [bigint] NOT NULL,
	[FileLocation] [int] NOT NULL,
	[FileBucket] [nvarchar](100) NULL,
	[FileOriginName] [nvarchar](100) NULL,
	[FileSuffix] [nvarchar](50) NULL,
	[FileSizeKb] [nvarchar](10) NULL,
	[FileSizeInfo] [nvarchar](50) NULL,
	[FileObjectName] [nvarchar](100) NULL,
	[FilePath] [nvarchar](100) NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_file] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_log_audit]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_log_audit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](50) NULL,
	[ColumnName] [nvarchar](50) NULL,
	[NewValue] [nvarchar](max) NULL,
	[OldValue] [nvarchar](max) NULL,
	[CreatedTime] [datetime] NULL,
	[UserId] [bigint] NOT NULL,
	[UserName] [nvarchar](20) NULL,
	[Operate] [int] NOT NULL,
	[TenantId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_sys_log_audit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_log_ex]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_log_ex](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Account] [nvarchar](20) NULL,
	[Name] [nvarchar](100) NULL,
	[ClassName] [nvarchar](100) NULL,
	[MethodName] [nvarchar](100) NULL,
	[ExceptionName] [nvarchar](max) NULL,
	[ExceptionMsg] [nvarchar](max) NULL,
	[ExceptionSource] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[ParamsObj] [nvarchar](max) NULL,
	[ExceptionTime] [datetime] NULL,
	[TenantId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_sys_log_ex] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_log_op]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_log_op](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Success] [int] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[Ip] [nvarchar](20) NULL,
	[Location] [nvarchar](500) NULL,
	[Browser] [nvarchar](100) NULL,
	[Os] [nvarchar](100) NULL,
	[Url] [nvarchar](100) NULL,
	[ClassName] [nvarchar](100) NULL,
	[MethodName] [nvarchar](100) NULL,
	[ReqMethod] [nvarchar](10) NULL,
	[Param] [nvarchar](max) NULL,
	[Result] [nvarchar](max) NULL,
	[ElapsedTime] [bigint] NOT NULL,
	[OpTime] [datetime] NULL,
	[Account] [nvarchar](20) NULL,
	[TenantId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_sys_log_op] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_log_vis]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_log_vis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Success] [int] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[Ip] [nvarchar](20) NULL,
	[Location] [nvarchar](100) NULL,
	[Browser] [nvarchar](100) NULL,
	[Os] [nvarchar](100) NULL,
	[VisType] [int] NOT NULL,
	[VisTime] [datetime] NULL,
	[Account] [nvarchar](20) NULL,
	[TenantId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_sys_log_vis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_menu]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_menu](
	[Id] [bigint] NOT NULL,
	[Pid] [bigint] NOT NULL,
	[Pids] [nvarchar](max) NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Type] [int] NOT NULL,
	[Icon] [nvarchar](20) NULL,
	[Router] [nvarchar](100) NULL,
	[Component] [nvarchar](100) NULL,
	[Permission] [nvarchar](100) NULL,
	[Application] [nvarchar](50) NULL,
	[OpenType] [int] NOT NULL,
	[Visible] [nvarchar](5) NULL,
	[Link] [nvarchar](100) NULL,
	[Redirect] [nvarchar](100) NULL,
	[Weight] [int] NOT NULL,
	[Sort] [int] NOT NULL,
	[Remark] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_notice]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_notice](
	[Id] [bigint] NOT NULL,
	[Title] [nvarchar](20) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Type] [int] NOT NULL,
	[PublicUserId] [bigint] NOT NULL,
	[PublicUserName] [nvarchar](20) NULL,
	[PublicOrgId] [bigint] NOT NULL,
	[PublicOrgName] [nvarchar](50) NULL,
	[PublicTime] [datetime] NOT NULL,
	[CancelTime] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_notice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_notice_user]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_notice_user](
	[NoticeId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[ReadTime] [datetime] NOT NULL,
	[ReadStatus] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_oauth_user]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_oauth_user](
	[Id] [bigint] NOT NULL,
	[Uuid] [nvarchar](50) NULL,
	[AccessToken] [nvarchar](max) NULL,
	[NickName] [nvarchar](20) NULL,
	[Avatar] [nvarchar](max) NULL,
	[Gender] [nvarchar](5) NULL,
	[Phone] [nvarchar](20) NULL,
	[Email] [nvarchar](20) NULL,
	[Location] [nvarchar](50) NULL,
	[Blog] [nvarchar](max) NULL,
	[Company] [nvarchar](50) NULL,
	[Source] [nvarchar](20) NULL,
	[Remark] [nvarchar](100) NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_oauth_user] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_online_user]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_online_user](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConnectionId] [varchar](64) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[LastTime] [datetime] NULL,
	[LastLoginIp] [varchar](32) NULL,
	[Account] [varchar](32) NULL,
	[Name] [varchar](32) NULL,
	[TenantId] [bigint] NULL,
 CONSTRAINT [PK_sys_online_user] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_org]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_org](
	[Id] [bigint] NOT NULL,
	[Pid] [bigint] NOT NULL,
	[Pids] [nvarchar](max) NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Contacts] [nvarchar](20) NULL,
	[Tel] [nvarchar](20) NULL,
	[Sort] [int] NOT NULL,
	[Remark] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantId] [bigint] NULL,
 CONSTRAINT [PK_sys_org] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_pos]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_pos](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Sort] [int] NOT NULL,
	[Remark] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantId] [bigint] NULL,
 CONSTRAINT [PK_sys_pos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_role]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_role](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Sort] [int] NOT NULL,
	[DataScopeType] [int] NOT NULL,
	[Remark] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantId] [bigint] NULL,
	[RoleType] [int] NULL,
 CONSTRAINT [PK_sys_role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_role_data_scope]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_role_data_scope](
	[SysRoleId] [bigint] NOT NULL,
	[SysOrgId] [bigint] NOT NULL,
 CONSTRAINT [PK_sys_role_data_scope] PRIMARY KEY CLUSTERED 
(
	[SysRoleId] ASC,
	[SysOrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_role_menu]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_role_menu](
	[SysRoleId] [bigint] NOT NULL,
	[SysMenuId] [bigint] NOT NULL,
 CONSTRAINT [PK_sys_role_menu] PRIMARY KEY CLUSTERED 
(
	[SysRoleId] ASC,
	[SysMenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_tenant]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_tenant](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[AdminName] [nvarchar](20) NOT NULL,
	[Host] [nvarchar](100) NULL,
	[Email] [nvarchar](20) NULL,
	[Phone] [nvarchar](20) NULL,
	[Connection] [nvarchar](200) NULL,
	[Schema] [nvarchar](50) NULL,
	[Remark] [nvarchar](100) NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantType] [int] NULL,
 CONSTRAINT [PK_sys_tenant] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_timer]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_timer](
	[Id] [bigint] NOT NULL,
	[JobName] [nvarchar](20) NOT NULL,
	[DoOnce] [bit] NOT NULL,
	[StartNow] [bit] NOT NULL,
	[ExecuteType] [int] NOT NULL,
	[Interval] [int] NULL,
	[Cron] [nvarchar](20) NULL,
	[TimerType] [int] NOT NULL,
	[RequestUrl] [nvarchar](200) NULL,
	[RequestParameters] [nvarchar](max) NULL,
	[Headers] [nvarchar](max) NULL,
	[RequestType] [int] NOT NULL,
	[Remark] [nvarchar](100) NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_sys_timer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_user]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_user](
	[Id] [bigint] NOT NULL,
	[Account] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[NickName] [nvarchar](20) NULL,
	[Name] [nvarchar](20) NULL,
	[Avatar] [nvarchar](max) NULL,
	[Birthday] [datetime] NULL,
	[Sex] [int] NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](20) NULL,
	[Tel] [nvarchar](20) NULL,
	[LastLoginIp] [nvarchar](20) NULL,
	[LastLoginTime] [datetime] NULL,
	[AdminType] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[CreatedUserId] [bigint] NULL,
	[CreatedUserName] [nvarchar](20) NULL,
	[UpdatedUserId] [bigint] NULL,
	[UpdatedUserName] [nvarchar](20) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantId] [bigint] NULL,
 CONSTRAINT [PK_sys_user] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_user_data_scope]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_user_data_scope](
	[SysUserId] [bigint] NOT NULL,
	[SysOrgId] [bigint] NOT NULL,
 CONSTRAINT [PK_sys_user_data_scope] PRIMARY KEY CLUSTERED 
(
	[SysUserId] ASC,
	[SysOrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_user_role]    Script Date: 2022/4/27 18:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_user_role](
	[SysUserId] [bigint] NOT NULL,
	[SysRoleId] [bigint] NOT NULL,
 CONSTRAINT [PK_sys_user_role] PRIMARY KEY CLUSTERED 
(
	[SysUserId] ASC,
	[SysRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[documentation] ([Id], [PId], [PIds], [Name], [DocumentType], [FileSuffix], [FileSizeKb], [FileObjectName], [FilePath], [Label], [Remark], [Visible], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (282067396128837, 0, NULL, N'新建文件夹', 1, NULL, NULL, NULL, NULL, 3, NULL, 1, CAST(N'2022-04-27T11:15:12.403' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[documentation] ([Id], [PId], [PIds], [Name], [DocumentType], [FileSuffix], [FileSizeKb], [FileObjectName], [FilePath], [Label], [Remark], [Visible], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (282067842687046, 282067396128837, NULL, N'logo.png', 2, N'.png', 25, N'282067842687045.png', N'Upload/Document/2022/4/27', NULL, NULL, 1, CAST(N'2022-04-27T11:17:01.427' AS DateTime), CAST(N'2022-04-27T11:20:46.450' AS DateTime), 142307070910551, N'superAdmin', 142307070910551, N'superAdmin', 0)
INSERT [dbo].[documentation] ([Id], [PId], [PIds], [Name], [DocumentType], [FileSuffix], [FileSizeKb], [FileObjectName], [FilePath], [Label], [Remark], [Visible], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (282068878082117, 282067396128837, NULL, N'呃呃呃', 1, NULL, NULL, NULL, NULL, 3, NULL, 1, CAST(N'2022-04-27T11:21:14.207' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_app] ([Id], [Name], [Code], [Active], [Status], [Sort], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070898245, N'平台管理', N'system', N'Y', 0, 100, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_app] ([Id], [Name], [Code], [Active], [Status], [Sort], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902341, N'系统管理', N'manage', N'N', 0, 300, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_app] ([Id], [Name], [Code], [Active], [Status], [Sort], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922826, N'运营管理', N'platform', N'N', 0, 200, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_app] ([Id], [Name], [Code], [Active], [Status], [Sort], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922869, N'业务应用', N'busiapp', N'N', 0, 400, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_app] ([Id], [Name], [Code], [Active], [Status], [Sort], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (246681684324421, N'流程中心', N'flowcenter', N'N', 0, 500, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_code_gen] ([Id], [AuthorName], [TablePrefix], [GenerateType], [TableName], [NameSpace], [BusName], [MenuApplication], [MenuPid], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306017861, N'Magic', NULL, N'2', N'Test', N'Magic.Application', N'测试', N'busiapp', 0, CAST(N'2021-08-31T23:22:13.373' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755141, 197665306017861, N'Id', N'主键Id', N'long', N'input', NULL, NULL, NULL, NULL, N'N', N'N', N'N', N'==', N'N', N'N', N'True', N'bigint', N'N', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755142, 197665306017861, N'TenantId', N'租户Id', N'long', N'input', NULL, NULL, NULL, NULL, N'N', N'N', N'Y', N'==', N'Y', N'Y', N'False', N'bigint', N'N', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755143, 197665306017861, N'CreatedTime', N'创建时间', N'DateTime', N'datepicker', NULL, NULL, NULL, NULL, N'N', N'N', N'N', N'==', N'N', N'N', N'False', N'datetime', N'Y', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755144, 197665306017861, N'UpdatedTime', N'更新时间', N'DateTime', N'datepicker', NULL, NULL, NULL, NULL, N'N', N'N', N'N', N'==', N'N', N'N', N'False', N'datetime', N'Y', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755145, 197665306017861, N'CreatedUserId', N'创建者Id', N'long', N'input', NULL, NULL, NULL, NULL, N'N', N'N', N'N', N'==', N'N', N'N', N'False', N'bigint', N'Y', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755146, 197665306017861, N'CreatedUserName', N'创建者名称', N'string', N'input', NULL, NULL, NULL, NULL, N'N', N'N', N'N', N'==', N'N', N'N', N'False', N'nvarchar', N'Y', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755147, 197665306017861, N'UpdatedUserId', N'修改者Id', N'long', N'input', NULL, NULL, NULL, NULL, N'N', N'N', N'N', N'==', N'N', N'N', N'False', N'bigint', N'Y', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755148, 197665306017861, N'UpdatedUserName', N'修改者名称', N'string', N'input', NULL, NULL, NULL, NULL, N'N', N'N', N'N', N'==', N'N', N'N', N'False', N'nvarchar', N'Y', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_code_gen_config] ([Id], [CodeGenId], [ColumnName], [ColumnComment], [NetType], [EffectType], [FkEntityName], [FkColumnName], [FkColumnNetType], [DictTypeCode], [WhetherRetract], [WhetherRequired], [QueryWhether], [QueryType], [WhetherTable], [WhetherAddUpdate], [ColumnKey], [DataType], [WhetherCommon], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (197665306755149, 197665306017861, N'IsDeleted', N'软删除', N'bool', N'switch', NULL, NULL, NULL, NULL, N'N', N'N', N'N', N'==', N'N', N'N', N'False', N'bit', N'Y', CAST(N'2021-08-31T23:22:13.553' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902342, N'jwt密钥', N'JWT_SECRET', N'xiaonuo', N'Y', N'（重要）jwt密钥，默认为空，自行设置', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902343, N'默认密码', N'DEFAULT_PASSWORD', N'123456', N'Y', N'默认密码', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902344, N'token过期时间', N'TOKEN_EXPIRE', N'86400', N'Y', N'token过期时间（单位：秒）', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902345, N'session会话过期时间', N'SESSION_EXPIRE', N'7200', N'Y', N'session会话过期时间（单位：秒）', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902346, N'阿里云短信keyId', N'ALIYUN_SMS_ACCESSKEY_ID', N'你的keyId', N'Y', N'阿里云短信keyId', 0, N'ALIYUN_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902347, N'阿里云短信secret', N'ALIYUN_SMS_ACCESSKEY_SECRET', N'你的secret', N'Y', N'阿里云短信secret', 0, N'ALIYUN_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902348, N'阿里云短信签名', N'ALIYUN_SMS_SIGN_NAME', N'你的签名', N'Y', N'阿里云短信签名', 0, N'ALIYUN_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902349, N'阿里云短信-登录模板号', N'ALIYUN_SMS_LOGIN_TEMPLATE_CODE', N'SMS_1877123456', N'Y', N'阿里云短信-登录模板号', 0, N'ALIYUN_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902350, N'阿里云短信默认失效时间', N'ALIYUN_SMS_INVALIDATE_MINUTES', N'5', N'Y', N'阿里云短信默认失效时间（单位：分钟）', 0, N'ALIYUN_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902351, N'腾讯云短信secretId', N'TENCENT_SMS_SECRET_ID', N'你的secretId', N'Y', N'腾讯云短信secretId', 0, N'TENCENT_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902352, N'腾讯云短信secretKey', N'TENCENT_SMS_SECRET_KEY', N'你的secretkey', N'Y', N'腾讯云短信secretKey', 0, N'TENCENT_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902353, N'腾讯云短信sdkAppId', N'TENCENT_SMS_SDK_APP_ID', N'1400375123', N'Y', N'腾讯云短信sdkAppId', 0, N'TENCENT_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902354, N'腾讯云短信签名', N'TENCENT_SMS_SIGN', N'你的签名', N'Y', N'腾讯云短信签名', 0, N'TENCENT_SMS', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902355, N'邮箱host', N'EMAIL_HOST', N'smtp.126.com', N'Y', N'邮箱host', 0, N'EMAIL', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902356, N'邮箱用户名', N'EMAIL_USERNAME', N'test@126.com', N'Y', N'邮箱用户名', 0, N'EMAIL', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902357, N'邮箱密码', N'EMAIL_PASSWORD', N'你的邮箱密码', N'Y', N'邮箱密码', 0, N'EMAIL', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902358, N'邮箱端口', N'EMAIL_PORT', N'465', N'Y', N'邮箱端口', 0, N'EMAIL', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902359, N'邮箱是否开启ssl', N'EMAIL_SSL', N'true', N'Y', N'邮箱是否开启ssl', 0, N'EMAIL', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902360, N'邮箱发件人', N'EMAIL_FROM', N'test@126.com', N'Y', N'邮箱发件人', 0, N'EMAIL', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902361, N'Win本地上传文件路径', N'FILE_UPLOAD_PATH_FOR_WINDOWS', N'D:/tmp', N'Y', N'Win本地上传文件路径', 0, N'FILE_PATH', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902362, N'Linux/Mac本地上传文件路径', N'FILE_UPLOAD_PATH_FOR_LINUX', N'/tmp', N'Y', N'Linux/Mac本地上传文件路径', 0, N'FILE_PATH', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902363, N'放开XSS过滤的接口', N'UN_XSS_FILTER_URL', N'/demo/xssfilter,/demo/unxss', N'Y', N'多个url可以用英文逗号隔开', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902364, N'单用户登陆的开关', N'ENABLE_SINGLE_LOGIN', N'false', N'Y', N'true-打开，false-关闭，如果一个人登录两次，就会将上一次登陆挤下去', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902365, N'登录验证码的开关', N'CAPTCHA_OPEN', N'false', N'Y', N'true-打开，false-关闭', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902366, N'Druid监控登录账号', N'DRUID_USERNAME', N'superAdmin', N'Y', N'Druid监控登录账号', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902367, N'Druid监控界面登录密码', N'DRUID_PASSWORD', N'123456', N'Y', N'Druid监控界面登录密码', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902368, N'阿里云定位api接口地址', N'IP_GEO_API', N'http://api01.aliyun.venuscn.com/ip?ip=%s', N'Y', N'阿里云定位api接口地址', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902369, N'阿里云定位appCode', N'IP_GEO_APP_CODE', N'461535aabeae4f34861884d392f5d452', N'Y', N'阿里云定位appCode', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902370, N'Oauth用户登录的开关', N'ENABLE_OAUTH_LOGIN', N'true', N'Y', N'Oauth用户登录的开关', 0, N'OAUTH', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902371, N'Oauth码云登录ClientId', N'OAUTH_GITEE_CLIENT_ID', N'你的clientId', N'Y', N'Oauth码云登录ClientId', 0, N'OAUTH', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902372, N'Oauth码云登录ClientSecret', N'OAUTH_GITEE_CLIENT_SECRET', N'你的clientSecret', N'Y', N'Oauth码云登录ClientSecret', 0, N'OAUTH', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902373, N'Oauth码云登录回调地址', N'OAUTH_GITEE_REDIRECT_URI', N'http://127.0.0.1:5566/oauth/callback/gitee', N'Y', N'Oauth码云登录回调地址', 0, N'OAUTH', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_config] ([Id], [Name], [Code], [Value], [SysFlag], [Remark], [Status], [GroupCode], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902374, N'演示环境', N'DEMO_ENV_FLAG', N'false', N'Y', N'演示环境的开关,true-打开，false-关闭，如果演示环境开启，则只能读数据不能写数据', 0, N'DEFAULT', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902375, 142307070906484, N'男', N'1', 100, N'男性', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902376, 142307070906484, N'女', N'2', 100, N'女性', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902377, 142307070906484, N'未知', N'3', 100, N'未知性别', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902378, 142307070906485, N'默认常量', N'DEFAULT', 100, N'默认常量，都以XIAONUO_开头的', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902379, 142307070906485, N'阿里云短信', N'ALIYUN_SMS', 100, N'阿里云短信配置', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902380, 142307070906485, N'腾讯云短信', N'TENCENT_SMS', 100, N'腾讯云短信', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902381, 142307070906485, N'邮件配置', N'EMAIL', 100, N'邮件配置', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902382, 142307070906485, N'文件上传路径', N'FILE_PATH', 100, N'文件上传路径', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902383, 142307070906485, N'Oauth配置', N'OAUTH', 100, N'Oauth配置', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902384, 142307070906483, N'正常', N'0', 100, N'正常', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902385, 142307070906483, N'停用', N'1', 100, N'停用', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902386, 142307070906483, N'删除', N'2', 100, N'删除', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902387, 142307070906486, N'否', N'N', 100, N'否', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902388, 142307070906486, N'是', N'Y', 100, N'是', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902389, 142307070906487, N'登录', N'1', 100, N'登录', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902390, 142307070906487, N'登出', N'2', 100, N'登出', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902391, 142307070906488, N'目录', N'0', 100, N'目录', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902392, 142307070906488, N'菜单', N'1', 100, N'菜单', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902393, 142307070906488, N'按钮', N'2', 100, N'按钮', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902394, 142307070906489, N'未发送', N'0', 100, N'未发送', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902395, 142307070906489, N'发送成功', N'1', 100, N'发送成功', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902396, 142307070906489, N'发送失败', N'2', 100, N'发送失败', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902397, 142307070906489, N'失效', N'3', 100, N'失效', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902398, 142307070906490, N'无', N'0', 100, N'无', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070902399, 142307070906490, N'组件', N'1', 100, N'组件', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906437, 142307070906490, N'内链', N'2', 100, N'内链', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906438, 142307070906490, N'外链', N'3', 100, N'外链', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906439, 142307070906491, N'系统权重', N'1', 100, N'系统权重', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906440, 142307070906491, N'业务权重', N'2', 100, N'业务权重', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906441, 142307070906492, N'全部数据', N'1', 100, N'全部数据', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906442, 142307070906492, N'本部门及以下数据', N'2', 100, N'本部门及以下数据', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906443, 142307070906492, N'本部门数据', N'3', 100, N'本部门数据', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906444, 142307070906492, N'仅本人数据', N'4', 100, N'仅本人数据', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906445, 142307070906492, N'自定义数据', N'5', 100, N'自定义数据', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906446, 142307070906493, N'app', N'1', 100, N'app', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906447, 142307070906493, N'pc', N'2', 100, N'pc', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906448, 142307070906493, N'其他', N'3', 100, N'其他', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906449, 142307070906494, N'其它', N'0', 100, N'其它', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906450, 142307070906494, N'增加', N'1', 100, N'增加', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906451, 142307070906494, N'删除', N'2', 100, N'删除', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906452, 142307070906494, N'编辑', N'3', 100, N'编辑', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906453, 142307070906494, N'更新', N'4', 100, N'更新', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906454, 142307070906494, N'查询', N'5', 100, N'查询', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906455, 142307070906494, N'详情', N'6', 100, N'详情', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906456, 142307070906494, N'树', N'7', 100, N'树', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906457, 142307070906494, N'导入', N'8', 100, N'导入', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906458, 142307070906494, N'导出', N'9', 100, N'导出', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906459, 142307070906494, N'授权', N'10', 100, N'授权', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906460, 142307070906494, N'强退', N'11', 100, N'强退', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906461, 142307070906494, N'清空', N'12', 100, N'清空', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906462, 142307070906494, N'修改状态', N'13', 100, N'修改状态', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906463, 142307070906495, N'阿里云', N'1', 100, N'阿里云', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906464, 142307070906495, N'腾讯云', N'2', 100, N'腾讯云', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906465, 142307070906495, N'minio', N'3', 100, N'minio', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906466, 142307070906495, N'本地', N'4', 100, N'本地', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906467, 142307070910533, N'运行', N'1', 100, N'运行', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906468, 142307070910533, N'停止', N'2', 100, N'停止', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906469, 142307070910534, N'通知', N'1', 100, N'通知', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906470, 142307070910534, N'公告', N'2', 100, N'公告', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906471, 142307070910535, N'草稿', N'0', 100, N'草稿', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906472, 142307070910535, N'发布', N'1', 100, N'发布', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906473, 142307070910535, N'撤回', N'2', 100, N'撤回', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906474, 142307070910535, N'删除', N'3', 100, N'删除', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906475, 142307070910536, N'是', N'true', 100, N'是', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906476, 142307070910536, N'否', N'false', 100, N'否', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906477, 142307070910537, N'下载压缩包', N'1', 100, N'下载压缩包', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906478, 142307070910537, N'生成到本项目', N'2', 100, N'生成到本项目', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906479, 142307070910538, N'GET', N'1', 100, N'GET', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906480, 142307070910538, N'POST', N'2', 100, N'POST', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906481, 142307070910538, N'PUT', N'3', 100, N'PUT', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906482, 142307070910538, N'DELETE', N'4', 100, N'DELETE', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922829, 142307070922827, N'外键', N'fk', 100, N'外键', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922830, 142307070922827, N'输入框', N'input', 100, N'输入框', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922831, 142307070922827, N'时间选择', N'datepicker', 100, N'时间选择', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922832, 142307070922827, N'下拉框', N'select', 100, N'下拉框', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922833, 142307070922827, N'单选框', N'radio', 100, N'单选框', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922834, 142307070922827, N'开关', N'switch', 100, N'开关', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922835, 142307070922827, N'多选框', N'checkbox', 100, N'多选框', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922836, 142307070922827, N'数字输入框', N'inputnumber', 100, N'数字输入框', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922837, 142307070922827, N'文本域', N'textarea', 100, N'文本域', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922838, 142307070922828, N'等于', N'==', 1, N'等于', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922839, 142307070922828, N'模糊', N'like', 2, N'模糊', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922840, 142307070922828, N'大于', N'>', 3, N'大于', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922841, 142307070922828, N'小于', N'<', 4, N'小于', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922842, 142307070922828, N'不等于', N'!=', 5, N'不等于', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922843, 142307070922828, N'大于等于', N'>=', 6, N'大于等于', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922844, 142307070922828, N'小于等于', N'<=', 7, N'小于等于', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922845, 142307070922828, N'不为空', N'isNotNull', 8, N'不为空', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922846, 142307070922829, N'long', N'long', 100, N'long', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922847, 142307070922829, N'string', N'string', 100, N'string', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922848, 142307070922829, N'DateTime', N'DateTime', 100, N'DateTime', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922850, 142307070922829, N'bool', N'bool', 100, N'bool', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922851, 142307070922829, N'int', N'int', 100, N'int', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922852, 142307070922829, N'double', N'double', 100, N'double', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922861, 142307070922829, N'float', N'float', 100, N'float', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922862, 142307070922829, N'decimal', N'decimal', 100, N'decimal', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922863, 142307070922829, N'Guid', N'Guid', 100, N'Guid', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922864, 142307070922829, N'DateTimeOffset', N'DateTimeOffset', 100, N'DateTimeOffset', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250932094988357, 250931744608325, N'正在运行', N'0', 100, NULL, 0, CAST(N'2022-01-29T11:45:20.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250932172402757, 250931744608325, N'审批通过', N'1', 100, NULL, 0, CAST(N'2022-01-29T11:45:39.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
GO
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250932217757765, 250931744608325, N'被撤回', N'2', 100, NULL, 0, CAST(N'2022-01-29T11:45:50.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250932249595973, 250931744608325, N'不同意', N'3', 100, NULL, 0, CAST(N'2022-01-29T11:45:58.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250932291698757, 250931744608325, N'被驳回', N'4', 100, NULL, 0, CAST(N'2022-01-29T11:46:08.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277112709247045, 277112635904069, N'文件夹', N'1', 100, NULL, 0, CAST(N'2022-04-13T11:14:32.053' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277112731418693, 277112635904069, N'文件', N'2', 100, NULL, 0, CAST(N'2022-04-13T11:14:37.463' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277535182864453, 277534340079685, N'文档', N'doc,docx,txt,xls,ppt,xlsx,pptx,tmd,tmdx,prd,prdx,pmd,pmdx,pdf', 100, NULL, 0, CAST(N'2022-04-14T15:53:35.023' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277536743669829, 277534340079685, N'图片', N'png,jpg,jpeg,gif,tiff,swf', 100, NULL, 0, CAST(N'2022-04-14T15:59:56.080' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277538435686469, 277534340079685, N'文件夹', N'文件夹', 98, NULL, 0, CAST(N'2022-04-14T16:06:49.170' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277782089695301, 277109712883781, N'流程图', N'3', 100, NULL, 0, CAST(N'2022-04-15T08:38:15.013' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277782202732613, 277109712883781, N'月小结', N'4', 100, NULL, 0, CAST(N'2022-04-15T08:38:42.610' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277790520414277, 277534340079685, N'应用程序', N'exe,msi', 100, NULL, 0, CAST(N'2022-04-15T09:12:33.293' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_data] ([Id], [TypeId], [Value], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277801672163397, 277534340079685, N'压缩包', N'zip,rar,7z,tar,tar.gz,ace,zipx,iso,rz', 100, NULL, 0, CAST(N'2022-04-15T09:57:55.887' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906483, N'通用状态', N'common_status', 100, N'通用状态', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906484, N'性别', N'sex', 100, N'性别字典', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906485, N'常量的分类', N'consts_type', 100, N'常量的分类，用于区别一组配置', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906486, N'是否', N'yes_or_no', 100, N'是否', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906487, N'访问类型', N'vis_type', 100, N'访问类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906488, N'菜单类型', N'menu_type', 100, N'菜单类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906489, N'发送类型', N'send_type', 100, N'发送类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906490, N'打开方式', N'open_type', 100, N'打开方式', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906491, N'菜单权重', N'menu_weight', 100, N'菜单权重', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906492, N'数据范围类型', N'data_scope_type', 100, N'数据范围类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906493, N'短信发送来源', N'sms_send_source', 100, N'短信发送来源', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906494, N'操作类型', N'op_type', 100, N'操作类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070906495, N'文件存储位置', N'file_storage_location', 100, N'文件存储位置', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910533, N'运行状态', N'run_status', 100, N'定时任务运行状态', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910534, N'通知公告类型', N'notice_type', 100, N'通知公告类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910535, N'通知公告状态', N'notice_status', 100, N'通知公告状态', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910536, N'是否boolean', N'yes_true_false', 100, N'是否boolean', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910537, N'代码生成方式', N'code_gen_create_type', 100, N'代码生成方式', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910538, N'请求方式', N'request_type', 100, N'请求方式', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922827, N'代码生成作用类型', N'code_gen_effect_type', 100, N'代码生成作用类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922828, N'代码生成查询类型', N'code_gen_query_type', 100, N'代码生成查询类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922829, N'代码生成.NET类型', N'code_gen_net_type', 100, N'代码生成.NET类型', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250931744608325, N'流程状态', N'flow_status', 100, N'流程申请状态显示', 0, CAST(N'2022-01-29T11:43:54.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277109712883781, N'文档标签', N'doc_label', 99, NULL, 0, CAST(N'2022-04-13T11:02:20.517' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277112635904069, N'文档类型', N'doc_type', 99, NULL, 0, CAST(N'2022-04-13T11:14:14.147' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_dict_type] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277534340079685, N'文件类型', N'file_type', 99, NULL, 0, CAST(N'2022-04-14T15:50:09.267' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_emp] ([Id], [JobNum], [OrgId], [OrgName]) VALUES (142307070910551, NULL, 177325089079365, N'系统机构')
INSERT [dbo].[sys_emp] ([Id], [JobNum], [OrgId], [OrgName]) VALUES (175624015269957, N'1', 175624015089733, N'土豆新车')
INSERT [dbo].[sys_emp] ([Id], [JobNum], [OrgId], [OrgName]) VALUES (177325484421189, NULL, 177325089079365, N'系统机构')
INSERT [dbo].[sys_emp] ([Id], [JobNum], [OrgId], [OrgName]) VALUES (182314279026757, NULL, 182313953165381, N'机构1')
INSERT [dbo].[sys_emp] ([Id], [JobNum], [OrgId], [OrgName]) VALUES (278024843153477, N'1', 278024843092037, N'租户1')
INSERT [dbo].[sys_emp_pos] ([SysEmpId], [SysPosId]) VALUES (177325484421189, 177325394366533)
INSERT [dbo].[sys_emp_pos] ([SysEmpId], [SysPosId]) VALUES (182314279026757, 177325394366533)
INSERT [dbo].[sys_file] ([Id], [FileLocation], [FileBucket], [FileOriginName], [FileSuffix], [FileSizeKb], [FileSizeInfo], [FileObjectName], [FilePath], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (178111296725061, 4, N'LOCAL', N'icon_avatar.png', N'png', N'4', NULL, N'178111296725062.png', N'Upload/Default', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_file] ([Id], [FileLocation], [FileBucket], [FileOriginName], [FileSuffix], [FileSizeKb], [FileSizeInfo], [FileObjectName], [FilePath], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (188632919339077, 4, N'LOCAL', N'icon_alipay.png', N'png', N'22', NULL, N'188632919339077.png', N'Upload/Avatar', NULL, NULL, NULL, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[sys_log_ex] ON 

INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (1, N'superAdmin', N'超级管理员', N'Magic.Core.Service.SysFileService+<GetFileInfo>d__6', N'MoveNext', N'[D8000] 文件不存在', N'[D8000] 文件不存在', N'Magic.Core', N'   at Magic.Core.Service.SysFileService.GetFileInfo(QueryFileInoInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\File\SysFileService.cs:line 100
   at Magic.Core.Service.SysFileService.DownloadFileInfo(QueryFileInoInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\File\SysFileService.cs:line 135
   at Magic.Core.Service.SysFileService.PreviewFileInfo(QueryFileInoInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\File\SysFileService.cs:line 112
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-06T00:18:44.927' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (2, N'superAdmin', N'超级管理员', N'Magic.Core.Service.SysFileService+<GetFileInfo>d__6', N'MoveNext', N'[D8000] 文件不存在', N'[D8000] 文件不存在', N'Magic.Core', N'   at Magic.Core.Service.SysFileService.GetFileInfo(QueryFileInoInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\File\SysFileService.cs:line 100
   at Magic.Core.Service.SysFileService.DownloadFileInfo(QueryFileInoInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\File\SysFileService.cs:line 135
   at Magic.Core.Service.SysFileService.PreviewFileInfo(QueryFileInoInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\File\SysFileService.cs:line 112
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-06T10:48:50.270' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (3, N'superAdmin', N'超级管理员', N'Magic.Core.UserManager+<GetUserEmpInfo>d__15', N'MoveNext', N'[D1002] 记录不存在', N'[D1002] 记录不存在', N'Magic.Core', N'   at Magic.Core.UserManager.GetUserEmpInfo(Int64 userId) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Manager\UserManager.cs:line 74
   at Magic.Core.Service.Notice.SysNoticeService.UpdatePublicInfo(SysNotice notice) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 262
   at Magic.Core.Service.Notice.SysNoticeService.AddNotice(AddNoticeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 70
   at lambda_method443(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-19T23:07:31.313' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (4, N'superAdmin', N'超级管理员', N'Magic.Core.UserManager+<GetUserEmpInfo>d__15', N'MoveNext', N'[D1002] 记录不存在', N'[D1002] 记录不存在', N'Magic.Core', N'   at Magic.Core.UserManager.GetUserEmpInfo(Int64 userId) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Manager\UserManager.cs:line 74
   at Magic.Core.Service.Notice.SysNoticeService.UpdatePublicInfo(SysNotice notice) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 262
   at Magic.Core.Service.Notice.SysNoticeService.AddNotice(AddNoticeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 70
   at lambda_method443(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-19T23:07:39.633' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (5, N'superAdmin', N'超级管理员', N'Magic.Core.UserManager+<GetUserEmpInfo>d__15', N'MoveNext', N'[D1002] 记录不存在', N'[D1002] 记录不存在', N'Magic.Core', N'   at Magic.Core.UserManager.GetUserEmpInfo(Int64 userId) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Manager\UserManager.cs:line 74
   at Magic.Core.Service.Notice.SysNoticeService.UpdatePublicInfo(SysNotice notice) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 262
   at Magic.Core.Service.Notice.SysNoticeService.AddNotice(AddNoticeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 70
   at lambda_method443(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-19T23:07:43.953' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (6, N'superAdmin', N'超级管理员', N'Magic.Core.UserManager+<GetUserEmpInfo>d__15', N'MoveNext', N'[D1002] 记录不存在', N'[D1002] 记录不存在', N'Magic.Core', N'   at Magic.Core.UserManager.GetUserEmpInfo(Int64 userId) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Manager\UserManager.cs:line 74
   at Magic.Core.Service.Notice.SysNoticeService.UpdatePublicInfo(SysNotice notice) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 262
   at Magic.Core.Service.Notice.SysNoticeService.AddNotice(AddNoticeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 70
   at lambda_method443(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-19T23:08:40.257' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (7, N'superAdmin', N'超级管理员', N'Magic.Core.UserManager+<GetUserEmpInfo>d__15', N'MoveNext', N'[D1002] 记录不存在', N'[D1002] 记录不存在', N'Magic.Core', N'   at Magic.Core.UserManager.GetUserEmpInfo(Int64 userId) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Manager\UserManager.cs:line 74
   at Magic.Core.Service.Notice.SysNoticeService.UpdatePublicInfo(SysNotice notice) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 262
   at Magic.Core.Service.Notice.SysNoticeService.AddNotice(AddNoticeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 70
   at lambda_method443(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-19T23:09:10.463' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (8, N'superAdmin', N'超级管理员', N'Magic.Core.UserManager+<GetUserEmpInfo>d__15', N'MoveNext', N'[D1002] 记录不存在', N'[D1002] 记录不存在', N'Magic.Core', N'   at Magic.Core.UserManager.GetUserEmpInfo(Int64 userId) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Manager\UserManager.cs:line 74
   at Magic.Core.Service.Notice.SysNoticeService.UpdatePublicInfo(SysNotice notice) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 262
   at Magic.Core.Service.Notice.SysNoticeService.AddNotice(AddNoticeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 70
   at lambda_method443(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-19T23:09:44.273' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (9, N'superAdmin', N'超级管理员', N'Magic.Core.UserManager+<GetUserEmpInfo>d__15', N'MoveNext', N'[D1002] 记录不存在', N'[D1002] 记录不存在', N'Magic.Core', N'   at Magic.Core.UserManager.GetUserEmpInfo(Int64 userId) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Manager\UserManager.cs:line 74
   at Magic.Core.Service.Notice.SysNoticeService.UpdatePublicInfo(SysNotice notice) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 262
   at Magic.Core.Service.Notice.SysNoticeService.AddNotice(AddNoticeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Notice\SysNoticeService.cs:line 70
   at lambda_method443(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-19T23:10:30.503' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (10, NULL, NULL, N'Magic.Core.Service.AuthService', N'LoginAsync', N'[D1000] 用户名或密码不正确', N'[D1000] 用户名或密码不正确', N'Magic.Core', N'   at Magic.Core.Service.AuthService.LoginAsync(LoginInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Auth\AuthService.cs:line 87
   at lambda_method63(Closure , Object , Object[] )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.SyncObjectResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync()
--- End of stack trace from previous location ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-19T23:22:39.903' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (11, N'superAdmin', N'超级管理员', N'System.IO.FileStream', N'ValidateFileHandle', N'Could not find a part of the path ''D:\Workspace\admin-net-sqlsugar\backend\Magic.Application\Entity\Test.cs''.', N'Could not find a part of the path ''D:\Workspace\admin-net-sqlsugar\backend\Magic.Application\Entity\Test.cs''.', N'System.Private.CoreLib', N'   at System.IO.FileStream.ValidateFileHandle(SafeFileHandle fileHandle)
   at System.IO.FileStream.CreateFileOpenHandle(FileMode mode, FileShare share, FileOptions options)
   at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share, Int32 bufferSize, FileOptions options)
   at System.IO.StreamWriter.ValidateArgsAndOpenPath(String path, Boolean append, Encoding encoding, Int32 bufferSize)
   at System.IO.StreamWriter..ctor(String path, Boolean append, Encoding encoding)
   at System.IO.File.WriteAllText(String path, String contents, Encoding encoding)
   at Magic.Core.Service.DataBaseManager.CreateEntity(CreateEntityInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\DataBase\DataBaseManager.cs:line 187
   at Microsoft.Extensions.Internal.ObjectMethodExecutor.<>c__DisplayClass33_0.<WrapVoidMethod>b__0(Object target, Object[] parameters)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.VoidResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync()
--- End of stack trace from previous location ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-31T23:20:08.033' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (12, N'superAdmin', N'超级管理员', N'SqlSugar.AdoProvider+<GetScalarAsync>d__110', N'MoveNext', N'多次为 ''CountTable'' 指定了列 ''TenantId''。', N'多次为 ''CountTable'' 指定了列 ''TenantId''。', N'Core Microsoft SqlClient Data Provider', N'   at SqlSugar.AdoProvider.GetScalarAsync(String sql, SugarParameter[] parameters)
   at SqlSugar.QueryableProvider`1.GetCountAsync()
   at SqlSugar.QueryableProvider`1.CountAsync()
   at SqlSugar.QueryableProvider`1.ToPageListAsync(Int32 pageIndex, Int32 pageSize, RefAsync`1 totalNumber)
   at SqlSugar.PagedQueryableExtensions.ToPagedListAsync[TEntity](ISugarQueryable`1 entity, Int32 pageIndex, Int32 pageSize) in D:\Workspace\admin-net-sqlsugar\backend\Furion.Extras.DatabaseAccessor.SqlSugar\Extensions\PagedQueryableExtensions.cs:line 47
   at Magic.Application.TestService.Page(TestInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Application\Service\Test\TestService.cs:line 33
   at lambda_method146(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableObjectResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2021-08-31T23:26:10.763' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (13, N'superAdmin', N'超级管理员', N'System.DBNull', N'System.IConvertible.ToInt64', N'Object cannot be cast from DBNull to other types.', N'Object cannot be cast from DBNull to other types.', N'System.Private.CoreLib', N'   at System.DBNull.System.IConvertible.ToInt64(IFormatProvider provider)
   at System.Convert.ToInt64(Object value)
   at SqlSugar.InsertableProvider`1.ExecuteReturnBigIdentityAsync()
   at Magic.Core.Service.SysDictTypeService.AddDictType(AddDictTypeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Dict\SysDictTypeService.cs:line 86
   at lambda_method180(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-16T00:43:42.577' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (14, N'superAdmin', N'超级管理员', N'Magic.Core.Service.SysDictTypeService+<AddDictType>d__6', N'MoveNext', N'[D3001] 字典类型已存在,名称或编码重复', N'[D3001] 字典类型已存在,名称或编码重复', N'Magic.Core', N'   at Magic.Core.Service.SysDictTypeService.AddDictType(AddDictTypeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Dict\SysDictTypeService.cs:line 83
   at lambda_method180(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync()
--- End of stack trace from previous location ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-16T00:45:06.140' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (15, N'superAdmin', N'超级管理员', N'System.DBNull', N'System.IConvertible.ToInt64', N'Object cannot be cast from DBNull to other types.', N'Object cannot be cast from DBNull to other types.', N'System.Private.CoreLib', N'   at System.DBNull.System.IConvertible.ToInt64(IFormatProvider provider)
   at SqlSugar.InsertableProvider`1.ExecuteReturnBigIdentityAsync()
   at Magic.Core.Service.SysDictTypeService.AddDictType(AddDictTypeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Dict\SysDictTypeService.cs:line 86
   at lambda_method180(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-16T00:45:49.943' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (16, N'superAdmin', N'超级管理员', N'System.DBNull', N'System.IConvertible.ToInt64', N'Object cannot be cast from DBNull to other types.', N'Object cannot be cast from DBNull to other types.', N'System.Private.CoreLib', N'   at System.DBNull.System.IConvertible.ToInt64(IFormatProvider provider)
   at SqlSugar.InsertableProvider`1.ExecuteReturnBigIdentityAsync()
   at Magic.Core.Service.SysDictTypeService.AddDictType(AddDictTypeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Dict\SysDictTypeService.cs:line 86
   at lambda_method180(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-16T00:48:07.650' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (17, N'superAdmin', N'超级管理员', N'Magic.Core.Service.SysDictTypeService+<DeleteDictType>d__7', N'MoveNext', N'[D3002] 字典类型下面有字典值禁止删除', N'[D3002] 字典类型下面有字典值禁止删除', N'Magic.Core', N'   at Magic.Core.Service.SysDictTypeService.DeleteDictType(DeleteDictTypeInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Dict\SysDictTypeService.cs:line 108
   at lambda_method107(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-16T00:58:51.470' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (18, NULL, NULL, N'System.ThrowHelper', N'ThrowArgumentNullException', N'Value cannot be null. (Parameter ''s'')', N'Value cannot be null. (Parameter ''s'')', N'System.Private.CoreLib', N'   at System.Int64.Parse(String s)
   at Magic.Core.UserManager.get_UserId() in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Manager\UserManager.cs:line 20
   at Magic.Core.Service.AuthService.LogoutAsync() in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Auth\AuthService.cs:line 241
   at lambda_method43(Closure , Object )
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync()
--- End of stack trace from previous location ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-27T10:54:58.043' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (19, N'superAdmin', N'超级管理员', N'System.IO.Path', N'Combine', N'Value cannot be null. (Parameter ''path2'')', N'Value cannot be null. (Parameter ''path2'')', N'System.Private.CoreLib', N'   at System.IO.Path.Combine(String path1, String path2, String path3)
   at Magic.Core.Service.DocumentService.Download(QueryeDocumentInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Document\DocumentService.cs:line 399
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-27T11:16:23.670' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (20, N'superAdmin', N'超级管理员', N'System.IO.Path', N'Combine', N'Value cannot be null. (Parameter ''path2'')', N'Value cannot be null. (Parameter ''path2'')', N'System.Private.CoreLib', N'   at System.IO.Path.Combine(String path1, String path2, String path3)
   at Magic.Core.Service.DocumentService.Download(QueryeDocumentInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Document\DocumentService.cs:line 399
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-27T11:16:32.143' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (21, N'superAdmin', N'超级管理员', N'System.IO.Path', N'Combine', N'Value cannot be null. (Parameter ''path2'')', N'Value cannot be null. (Parameter ''path2'')', N'System.Private.CoreLib', N'   at System.IO.Path.Combine(String path1, String path2, String path3)
   at Magic.Core.Service.DocumentService.Download(QueryeDocumentInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Document\DocumentService.cs:line 399
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-27T11:17:45.070' AS DateTime), NULL)
INSERT [dbo].[sys_log_ex] ([Id], [Account], [Name], [ClassName], [MethodName], [ExceptionName], [ExceptionMsg], [ExceptionSource], [StackTrace], [ParamsObj], [ExceptionTime], [TenantId]) VALUES (22, N'superAdmin', N'超级管理员', N'System.IO.Path', N'Combine', N'Value cannot be null. (Parameter ''path2'')', N'Value cannot be null. (Parameter ''path2'')', N'System.Private.CoreLib', N'   at System.IO.Path.Combine(String path1, String path2, String path3)
   at Magic.Core.Service.DocumentService.Download(QueryeDocumentInput input) in D:\Workspace\admin-net-sqlsugar\backend\Magic.Core\Service\Document\DocumentService.cs:line 399
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Logged|12_1(ControllerActionInvoker invoker)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextExceptionFilterAsync>g__Awaited|26_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)', N'System.Reflection.ParameterInfo[]', CAST(N'2022-04-27T11:18:49.117' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[sys_log_ex] OFF
SET IDENTITY_INSERT [dbo].[sys_log_op] ON 

INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (1, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/sysDictType/add', N'Chrome100', N'Windows10', N'/sysDictType/add', N'Magic.Core.Service.SysDictTypeService', N'dict-type', N'POST', N'{"input":{"name":"账号类型","code":"AdminType","dictDataList":[{"typeId":"0","value":"超级管理员","code":"1","sort":0,"remark":"超级管理员","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"},{"typeId":"0","value":"管理员","code":"2","sort":1,"remark":"管理员","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"},{"typeId":"0","value":"普通账号","code":"3","sort":2,"remark":"普通账号","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"}],"sort":100,"remark":"账号类型","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"}}', N'', 94, CAST(N'2022-04-16T00:43:42.477' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (2, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/sysDictType/add', N'Chrome100', N'Windows10', N'/sysDictType/add', N'Magic.Core.Service.SysDictTypeService', N'dict-type', N'POST', N'{"input":{"name":"账号类型","code":"AdminType","dictDataList":[{"typeId":"0","value":"超级管理员","code":"1","sort":0,"remark":"超级管理员","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"},{"typeId":"0","value":"管理员","code":"2","sort":1,"remark":"管理员","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"},{"typeId":"0","value":"普通账号","code":"3","sort":2,"remark":"普通账号","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"}],"sort":100,"remark":"账号类型","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"}}', N'', 14588, CAST(N'2022-04-16T00:45:06.140' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (3, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/sysDictType/add', N'Chrome100', N'Windows10', N'/sysDictType/add', N'Magic.Core.Service.SysDictTypeService', N'dict-type', N'POST', N'{"input":{"name":"账号类型","code":"AdminType","dictDataList":[{"typeId":"0","value":"超级管理员","code":"1","sort":0,"remark":"超级管理员","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"},{"typeId":"0","value":"管理员","code":"2","sort":1,"remark":"管理员","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"},{"typeId":"0","value":"普通账号","code":"3","sort":2,"remark":"普通账号","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"}],"sort":100,"remark":"账号类型","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"}}', N'', 11343, CAST(N'2022-04-16T00:45:49.940' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (4, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/sysDictType/add', N'Chrome100', N'Windows10', N'/sysDictType/add', N'Magic.Core.Service.SysDictTypeService', N'dict-type', N'POST', N'{"input":{"name":"账号类型","code":"AdminType","dictDataList":[{"typeId":"0","value":"超级管理员","code":"1","sort":0,"remark":"超级管理员","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"},{"typeId":"0","value":"管理员","code":"2","sort":1,"remark":"管理员","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"},{"typeId":"0","value":"普通账号","code":"3","sort":2,"remark":"普通账号","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"}],"sort":100,"remark":"账号类型","status":0,"searchValue":null,"pageNo":1,"pageSize":20,"searchBeginTime":null,"searchEndTime":null,"sortField":null,"sortOrder":null,"descStr":"descend"}}', N'', 70020, CAST(N'2022-04-16T00:48:03.530' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (5, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/sysDictType/delete', N'Chrome100', N'Windows10', N'/sysDictType/delete', N'Magic.Core.Service.SysDictTypeService', N'dict-type', N'POST', N'{"input":{"id":"1515011090621272064"}}', N'', 209, CAST(N'2022-04-16T00:58:51.463' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (6, NULL, 1, NULL, N'127.0.0.1', N'http://localhost:5566/logout?0=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOjE0MjMwNzA3MDkxMDU1MSwiVGVuYW50SWQiOjE0MjMwNzA3MDkxODc4MCwiQWNjb3VudCI6InN1cGVyQWRtaW4iLCJOYW1lIjoi6LaF57qn566h55CG5ZGYIiwiU3VwZXJBZG1pbiI6MSwiVGVuYW50VHlwZSI6MSwiVGVuYW50TmFtZSI6Iuezu-e7n-enn-aItyIsImlhdCI6MTY1MDQzODY3MSwibmJmIjoxNjUwNDM4NjcxLCJleHAiOjE2NTA1MjUwNzEsImlzcyI6Im1hZ2ljIiwiYXVkIjoibWFnaWMifQ.dcEIPs5MDD8KDxi2M0SADDshCpJSb_t3LvFpr3pmrlA', N'Chrome100', N'Windows10', N'/logout', N'Magic.Core.Service.AuthService', N'logout', N'GET', N'""', N'', 113, CAST(N'2022-04-27T10:54:57.870' AS DateTime), NULL, NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (7, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/Document/download?id=282067396128837', N'Chrome100', N'Windows10', N'/Document/download', N'Magic.Core.Service.DocumentService', N'download', N'GET', N'{"input":{"id":"282067396128837"}}', N'', 81, CAST(N'2022-04-27T11:16:23.610' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (8, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/Document/download?id=282067396128837', N'Chrome100', N'Windows10', N'/Document/download', N'Magic.Core.Service.DocumentService', N'download', N'GET', N'{"input":{"id":"282067396128837"}}', N'', 33, CAST(N'2022-04-27T11:16:32.140' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (9, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/Document/download?id=282067396128837', N'Chrome100', N'Windows10', N'/Document/download', N'Magic.Core.Service.DocumentService', N'download', N'GET', N'{"input":{"id":"282067396128837"}}', N'', 36, CAST(N'2022-04-27T11:17:45.070' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_op] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [Url], [ClassName], [MethodName], [ReqMethod], [Param], [Result], [ElapsedTime], [OpTime], [Account], [TenantId]) VALUES (10, N'超级管理员', 1, NULL, N'127.0.0.1', N'http://localhost:5566/Document/download?id=282067396128837', N'Chrome100', N'Windows10', N'/Document/download', N'Magic.Core.Service.DocumentService', N'download', N'GET', N'{"input":{"id":"282067396128837"}}', N'', 35066, CAST(N'2022-04-27T11:18:49.117' AS DateTime), N'superAdmin', NULL)
SET IDENTITY_INSERT [dbo].[sys_log_op] OFF
SET IDENTITY_INSERT [dbo].[sys_log_vis] ON 

INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (1, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-07-31T00:00:09.123' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (2, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-05T17:27:07.213' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (3, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:16:09.853' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (4, N'超级管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-06T00:16:14.460' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (5, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:16:29.927' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (6, N'超级管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-06T00:17:03.253' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (7, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'iOS10', 0, CAST(N'2021-08-06T00:17:26.210' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (8, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:22:34.160' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (9, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:22:51.777' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (10, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:26:26.730' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (11, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:29:16.657' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (12, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:29:58.917' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (13, N'超级管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-06T00:31:01.887' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (14, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:31:05.197' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (15, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Chrome Mobile92', N'Android8', 0, CAST(N'2021-08-06T00:33:14.870' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (16, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:33:25.357' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (17, N'超级管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-06T00:33:34.980' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (18, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Chrome Mobile92', N'Android8', 0, CAST(N'2021-08-06T00:33:40.037' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (19, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:34:20.107' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (20, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:45:27.780' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (21, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:56:05.667' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (22, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:56:52.557' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (23, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:58:28.660' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (24, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T00:59:05.073' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (25, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:00:41.167' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (26, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:01:24.210' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (27, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:02:52.287' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (28, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:04:16.970' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (29, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:04:27.167' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (30, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:04:35.210' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (31, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:04:42.397' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (32, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:05:38.873' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (33, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:05:48.140' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (34, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:05:56.467' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (35, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:11:17.957' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (36, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:13:36.777' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (37, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:13:56.970' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (38, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:14:06.043' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (39, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:15:53.073' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (40, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:16:00.423' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (41, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:16:23.233' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (42, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:18:21.893' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (43, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:18:48.327' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (44, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:18:55.703' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (45, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:19:03.723' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (46, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:19:15.490' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (47, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:19:34.317' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (48, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:22:10.817' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (49, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:25:05.167' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (50, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:26:29.257' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (51, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:29:42.000' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (52, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:32:10.867' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (53, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:33:47.237' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (54, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:33:52.110' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (55, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:34:05.527' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (56, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T01:36:55.833' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (57, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:27:15.563' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (58, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:27:27.053' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (59, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:33:29.290' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (60, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:33:49.627' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (61, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:35:03.007' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (62, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:36:38.140' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (63, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:36:51.000' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (64, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:37:07.763' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (65, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:38:02.090' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (66, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:38:40.647' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (67, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:39:35.580' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (68, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:40:55.477' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (69, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:46:24.737' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (70, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:48:36.487' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (71, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:49:20.993' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (72, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:49:28.383' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (73, N'超级管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-06T10:49:36.303' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (74, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:49:37.997' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (75, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:51:41.733' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (76, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:52:20.690' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (77, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:53:49.563' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (78, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:56:56.283' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (79, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:57:20.993' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (80, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:58:33.100' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (81, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:59:38.393' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (82, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T10:59:47.260' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (83, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:00:43.347' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (84, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:02:51.973' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (85, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:06:04.790' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (86, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:08:41.363' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (87, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:13:11.450' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (88, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:13:55.640' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (89, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:17:32.203' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (90, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:24:11.787' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (91, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:25:40.707' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (92, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:29:30.600' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (93, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:30:44.210' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (94, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-06T11:36:27.263' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (95, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:06:54.850' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (96, N'超级管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:09:16.150' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (97, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:09:19.073' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (98, N'超级管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:14:33.893' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (99, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:14:39.400' AS DateTime), N'管理员', NULL)
GO
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (100, N'管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:14:47.273' AS DateTime), N'admin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (101, N'超级管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:14:50.010' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (102, N'超级管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:17:48.317' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (103, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:17:54.927' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (104, N'管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:22:32.407' AS DateTime), N'admin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (105, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:22:44.313' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (106, N'管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:23:37.550' AS DateTime), N'admin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (107, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:23:44.323' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (108, N'管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:42:07.573' AS DateTime), N'admin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (109, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:42:23.513' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (110, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:45:42.860' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (111, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:47:15.007' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (112, N'管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:47:19.223' AS DateTime), N'admin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (113, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:47:25.337' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (114, N'管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:49:16.707' AS DateTime), N'admin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (115, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:49:24.027' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (116, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:54:35.497' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (117, N'管理员', 0, N'退出成功', NULL, NULL, NULL, NULL, 1, CAST(N'2021-08-19T23:54:57.877' AS DateTime), N'admin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (118, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:55:06.257' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (119, N'管理员', 0, N'登录成功', NULL, NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-19T23:55:37.350' AS DateTime), N'管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (120, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-31T23:18:33.447' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (121, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-31T23:22:26.687' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (122, N'超级管理员', 0, N'登录成功', N'192.168.1.6', NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-31T23:25:15.563' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (123, N'超级管理员', 0, N'登录成功', N'192.168.1.6', NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-31T23:26:09.457' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (124, N'超级管理员', 0, N'登录成功', N'192.168.1.6', NULL, N'Edge92', N'Windows10', 0, CAST(N'2021-08-31T23:26:53.333' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (125, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome92', N'Windows10', 0, CAST(N'2021-09-03T23:53:11.453' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (126, N'超级管理员', 0, N'退出成功', N'127.0.0.1', NULL, NULL, NULL, 1, CAST(N'2022-04-16T00:42:22.380' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (127, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-16T00:42:26.497' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (128, N'tdadmin', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-16T00:42:44.850' AS DateTime), N'tdadmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (129, N'tdadmin', 0, N'退出成功', N'127.0.0.1', NULL, NULL, NULL, 1, CAST(N'2022-04-16T00:42:49.160' AS DateTime), N'toudou@qq.com', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (130, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-16T00:43:20.180' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (131, N'超级管理员', 0, N'退出成功', N'127.0.0.1', NULL, NULL, NULL, 1, CAST(N'2022-04-16T01:05:25.960' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (132, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-16T01:05:29.427' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (133, N'租户1管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-16T01:06:33.080' AS DateTime), N'租户1管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (134, N'租户1管理员', 0, N'退出成功', N'127.0.0.1', NULL, NULL, NULL, 1, CAST(N'2022-04-16T01:07:10.990' AS DateTime), N'zuhutest', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (135, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-16T01:07:13.553' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (136, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T10:58:16.157' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (137, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T11:04:23.150' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (138, N'超级管理员', 0, N'退出成功', N'127.0.0.1', NULL, NULL, NULL, 1, CAST(N'2022-04-27T11:04:29.143' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (139, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T11:04:34.350' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (140, N'超级管理员', 0, N'退出成功', N'127.0.0.1', NULL, NULL, NULL, 1, CAST(N'2022-04-27T11:05:08.940' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (141, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T11:06:24.713' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (142, N'超级管理员', 0, N'退出成功', N'127.0.0.1', NULL, NULL, NULL, 1, CAST(N'2022-04-27T11:09:02.913' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (143, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T11:09:06.220' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (144, N'超级管理员', 0, N'退出成功', N'127.0.0.1', NULL, NULL, NULL, 1, CAST(N'2022-04-27T11:13:46.727' AS DateTime), N'superAdmin', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (145, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T11:13:50.993' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (146, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T11:16:04.613' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (147, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T13:47:30.543' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (148, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T13:48:32.517' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (149, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T13:52:35.127' AS DateTime), N'超级管理员', NULL)
INSERT [dbo].[sys_log_vis] ([Id], [Name], [Success], [Message], [Ip], [Location], [Browser], [Os], [VisType], [VisTime], [Account], [TenantId]) VALUES (150, N'超级管理员', 0, N'登录成功', N'127.0.0.1', NULL, N'Chrome100', N'Windows10', 0, CAST(N'2022-04-27T13:53:33.930' AS DateTime), N'超级管理员', NULL)
SET IDENTITY_INSERT [dbo].[sys_log_vis] OFF
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307000914633, 0, N'[0],', N'组织架构', N'sys_mgr', 0, N'team', N'/sys', N'PageView', NULL, N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910560, 0, N'[0],', N'主控面板', N'system_index', 0, N'home', N'/', N'RouteView', NULL, N'busiapp', 0, N'Y', NULL, N'/analysis', 1, 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910561, 142307070910560, N'[0],[142307070910560],', N'分析页', N'system_index_dashboard', 1, NULL, N'analysis', N'system/dashboard/Analysis', NULL, N'busiapp', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910562, 142307070910560, N'[0],[142307070910560],', N'工作台', N'system_index_workplace', 1, NULL, N'workplace', N'system/dashboard/Workplace', NULL, N'busiapp', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910563, 0, N'[0],', N'权限管理', N'auth_manager', 0, N'safety-certificate', N'/auth', N'PageView', NULL, N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910564, 142307070910563, N'[0],[142307070910563],', N'用户管理', N'sys_user_mgr', 1, NULL, N'/mgr_user', N'system/user/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910565, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户查询', N'sys_user_mgr_page', 2, NULL, NULL, NULL, N'sysUser:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910566, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户编辑', N'sys_user_mgr_edit', 2, NULL, NULL, NULL, N'sysUser:edit', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910567, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户增加', N'sys_user_mgr_add', 2, NULL, NULL, NULL, N'sysUser:add', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910568, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户删除', N'sys_user_mgr_delete', 2, NULL, NULL, NULL, N'sysUser:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910569, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户详情', N'sys_user_mgr_detail', 2, NULL, NULL, NULL, N'sysUser:detail', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910570, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户导出', N'sys_user_mgr_export', 2, NULL, NULL, NULL, N'sysUser:export', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910571, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户选择器', N'sys_user_mgr_selector', 2, NULL, NULL, NULL, N'sysUser:selector', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910572, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户授权角色', N'sys_user_mgr_grant_role', 2, NULL, NULL, NULL, N'sysUser:grantRole', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910573, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户拥有角色', N'sys_user_mgr_own_role', 2, NULL, NULL, NULL, N'sysUser:ownRole', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910574, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户授权数据', N'sys_user_mgr_grant_data', 2, NULL, NULL, NULL, N'sysUser:grantData', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910575, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户拥有数据', N'sys_user_mgr_own_data', 2, NULL, NULL, NULL, N'sysUser:ownData', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910576, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户更新信息', N'sys_user_mgr_update_info', 2, NULL, NULL, NULL, N'sysUser:updateInfo', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910577, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户修改密码', N'sys_user_mgr_update_pwd', 2, NULL, NULL, NULL, N'sysUser:updatePwd', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910578, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户修改状态', N'sys_user_mgr_change_status', 2, NULL, NULL, NULL, N'sysUser:changeStatus', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910579, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户修改头像', N'sys_user_mgr_update_avatar', 2, NULL, NULL, NULL, N'sysUser:updateAvatar', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910580, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户重置密码', N'sys_user_mgr_reset_pwd', 2, NULL, NULL, NULL, N'sysUser:resetPwd', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910581, 142307000914633, N'[0],[142307000914633],', N'机构管理', N'sys_org_mgr', 1, NULL, N'/org', N'system/org/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910582, 142307070910581, N'[0],[142307000914633],[142307070910581],', N'机构查询', N'sys_org_mgr_page', 2, NULL, NULL, NULL, N'sysOrg:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910583, 142307070910581, N'[0],[142307000914633],[142307070910581],', N'机构列表', N'sys_org_mgr_list', 2, NULL, NULL, NULL, N'sysOrg:list', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910584, 142307070910581, N'[0],[142307000914633],[142307070910581],', N'机构增加', N'sys_org_mgr_add', 2, NULL, NULL, NULL, N'sysOrg:add', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910585, 142307070910581, N'[0],[142307000914633],[142307070910581],', N'机构编辑', N'sys_org_mgr_edit', 2, NULL, NULL, NULL, N'sysOrg:edit', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910586, 142307070910581, N'[0],[142307000914633],[142307070910581],', N'机构删除', N'sys_org_mgr_delete', 2, NULL, NULL, NULL, N'sysOrg:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910587, 142307070910581, N'[0],[142307000914633],[142307070910581],', N'机构详情', N'sys_org_mgr_detail', 2, NULL, NULL, NULL, N'sysOrg:detail', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910588, 142307070910581, N'[0],[142307000914633],[142307070910581],', N'机构树', N'sys_org_mgr_tree', 2, NULL, NULL, NULL, N'sysOrg:tree', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910589, 142307000914633, N'[0],[142307000914633],', N'职位管理', N'sys_pos_mgr', 1, NULL, N'/pos', N'system/pos/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, CAST(N'2021-04-26T17:01:18.123' AS DateTime), 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910590, 142307070910589, N'[0],[142307000914633],[142307070910589],', N'职位查询', N'sys_pos_mgr_page', 2, NULL, NULL, NULL, N'sysPos:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910591, 142307070910589, N'[0],[142307000914633],[142307070910589],', N'职位列表', N'sys_pos_mgr_list', 2, NULL, NULL, NULL, N'sysPos:list', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070911739, 142307070918732, N'[0],[142307070918732],', N'异常日志', N'sys_log_mgr_ex_log', 1, NULL, N'/exlog', N'system/log/exlog/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070911740, 142307070911739, N'[0],[142307070918732],[142307070911739],', N'异常日志查询', N'sys_log_mgr_ex_log_page', 2, NULL, NULL, NULL, N'sysExLog:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070911741, 142307070911739, N'[0],[142307070918732],[142307070911739],', N'异常日志清空', N'sys_log_mgr_ex_log_delete', 2, NULL, NULL, NULL, N'sysExLog:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914629, 142307070910589, N'[0],[142307000914633],[142307070910589],', N'职位增加', N'sys_pos_mgr_add', 2, NULL, NULL, NULL, N'sysPos:add', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914630, 142307070910589, N'[0],[142307000914633],[142307070910589],', N'职位编辑', N'sys_pos_mgr_edit', 2, NULL, NULL, NULL, N'sysPos:edit', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914631, 142307070910589, N'[0],[142307000914633],[142307070910589],', N'职位删除', N'sys_pos_mgr_delete', 2, NULL, NULL, NULL, N'sysPos:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914632, 142307070910589, N'[0],[142307000914633],[142307070910589],', N'职位详情', N'sys_pos_mgr_detail', 2, NULL, NULL, NULL, N'sysPos:detail', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914633, 0, N'[0],', N'平台管理', N'auth_manager', 0, N'safety-certificate', N'/auth', N'PageView', NULL, N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914634, 142307070914633, N'[0],[142307070914633],', N'应用管理', N'sys_app_mgr', 1, NULL, N'/app', N'system/app/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914635, 142307070914634, N'[0],[142307070914633],[142307070914634],', N'应用查询', N'sys_app_mgr_page', 2, NULL, NULL, NULL, N'sysApp:page', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914636, 142307070914634, N'[0],[142307070914633],[142307070914634],', N'应用列表', N'sys_app_mgr_list', 2, NULL, NULL, NULL, N'sysApp:list', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914637, 142307070914634, N'[0],[142307070914633],[142307070914634],', N'应用增加', N'sys_app_mgr_add', 2, NULL, NULL, NULL, N'sysApp:add', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914638, 142307070914634, N'[0],[142307070914633],[142307070914634],', N'应用编辑', N'sys_app_mgr_edit', 2, NULL, NULL, NULL, N'sysApp:edit', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914639, 142307070914634, N'[0],[142307070914633],[142307070914634],', N'应用删除', N'sys_app_mgr_delete', 2, NULL, NULL, NULL, N'sysApp:delete', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914640, 142307070914634, N'[0],[142307070914633],[142307070914634],', N'应用详情', N'sys_app_mgr_detail', 2, NULL, NULL, NULL, N'sysApp:detail', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914641, 142307070914634, N'[0],[142307070914633],[142307070914634],', N'设为默认应用', N'sys_app_mgr_set_as_default', 2, NULL, NULL, NULL, N'sysApp:setAsDefault', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914642, 142307070914633, N'[0],[142307070914633],', N'菜单管理', N'sys_menu_mgr', 1, NULL, N'/menu', N'system/menu/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914643, 142307070914642, N'[0],[142307070914633],[142307070914642],', N'菜单列表', N'sys_menu_mgr_list', 2, NULL, NULL, NULL, N'sysMenu:list', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914644, 142307070914642, N'[0],[142307070914633],[142307070914642],', N'菜单增加', N'sys_menu_mgr_add', 2, NULL, NULL, NULL, N'sysMenu:add', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914645, 142307070914642, N'[0],[142307070914633],[142307070914642],', N'菜单编辑', N'sys_menu_mgr_edit', 2, NULL, NULL, NULL, N'sysMenu:edit', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914646, 142307070914642, N'[0],[142307070914633],[142307070914642],', N'菜单删除', N'sys_menu_mgr_delete', 2, NULL, NULL, NULL, N'sysMenu:delete', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914647, 142307070914642, N'[0],[142307070914633],[142307070914642],', N'菜单详情', N'sys_menu_mgr_detail', 2, NULL, NULL, NULL, N'sysMenu:detail', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914648, 142307070914651, N'[0],[142307070914633],[142307070914651],', N'菜单授权树', N'sys_menu_mgr_grant_tree', 2, NULL, NULL, NULL, N'sysMenu:treeForGrant', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914649, 142307070914651, N'[0],[142307070914633],[142307070914651],', N'菜单树', N'sys_menu_mgr_tree', 2, NULL, NULL, NULL, N'sysMenu:tree', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914650, 142307070914642, N'[0],[142307070914633],[142307070914642],', N'菜单切换', N'sys_menu_mgr_change', 2, NULL, NULL, NULL, N'sysMenu:change', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914651, 142307070910563, N'[0],[142307070910563],', N'角色管理', N'sys_role_mgr', 1, NULL, N'/role', N'system/role/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914652, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色查询', N'sys_role_mgr_page', 2, NULL, NULL, NULL, N'sysRole:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914653, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色增加', N'sys_role_mgr_add', 2, NULL, NULL, NULL, N'sysRole:add', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914654, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色编辑', N'sys_role_mgr_edit', 2, NULL, NULL, NULL, N'sysRole:edit', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914655, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色删除', N'sys_role_mgr_delete', 2, NULL, NULL, NULL, N'sysRole:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914656, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色详情', N'sys_role_mgr_detail', 2, NULL, NULL, NULL, N'sysRole:detail', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914657, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色下拉', N'sys_role_mgr_drop_down', 2, NULL, NULL, NULL, N'sysRole:dropDown', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914658, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色授权菜单', N'sys_role_mgr_grant_menu', 2, NULL, NULL, NULL, N'sysRole:grantMenu', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914659, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色拥有菜单', N'sys_role_mgr_own_menu', 2, NULL, NULL, NULL, N'sysRole:ownMenu', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914660, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色授权数据', N'sys_role_mgr_grant_data', 2, NULL, NULL, NULL, N'sysRole:grantData', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914661, 142307070914651, N'[0],[142307070910563],[142307070914651],', N'角色拥有数据', N'sys_role_mgr_own_data', 2, NULL, NULL, NULL, N'sysRole:ownData', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914662, 0, N'[0],', N'开发管理', N'system_tools', 0, N'euro', N'/tools', N'PageView', NULL, N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914663, 142307070914662, N'[0],[142307070914662],', N'系统配置', N'system_tools_config', 1, NULL, N'/config', N'system/config/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914664, 142307070914663, N'[0],[142307070914662],[142307070914663],', N'配置查询', N'system_tools_config_page', 2, NULL, NULL, NULL, N'sysConfig:page', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914665, 142307070914663, N'[0],[142307070914662],[142307070914663],', N'配置列表', N'system_tools_config_list', 2, NULL, NULL, NULL, N'sysConfig:list', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914666, 142307070914663, N'[0],[142307070914662],[142307070914663],', N'配置增加', N'system_tools_config_add', 2, NULL, NULL, NULL, N'sysConfig:add', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914667, 142307070914663, N'[0],[142307070914662],[142307070914663],', N'配置编辑', N'system_tools_config_edit', 2, NULL, NULL, NULL, N'sysConfig:edit', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914668, 142307070914663, N'[0],[142307070914662],[142307070914663],', N'配置删除', N'system_tools_config_delete', 2, NULL, NULL, NULL, N'sysConfig:delete', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914669, 142307070914663, N'[0],[142307070914662],[142307070914663],', N'配置详情', N'system_tools_config_detail', 2, NULL, NULL, NULL, N'sysConfig:detail', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914670, 142307070914663, N'[0],[142307070914662],[142307070914663],', N'设为默认应用', N'sys_app_mgr_set_as_default', 2, NULL, NULL, NULL, N'sysApp:setAsDefault', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914671, 142307070914662, N'[0],[142307070914662],', N'邮件发送', N'sys_email_mgr', 1, NULL, N'/email', N'system/email/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914672, 142307070914671, N'[0],[142307070914662],[142307070914671],', N'发送文本邮件', N'sys_email_mgr_send_email', 2, NULL, NULL, NULL, N'email:sendEmail', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914673, 142307070914671, N'[0],[142307070914662],[142307070914671],', N'发送html邮件', N'sys_email_mgr_send_email_html', 2, NULL, NULL, NULL, N'email:sendEmailHtml', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914674, 142307070914662, N'[0],[142307070914662],', N'短信管理', N'sys_sms_mgr', 1, NULL, N'/sms', N'system/sms/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914675, 142307070914674, N'[0],[142307070914662],[142307070914674],', N'短信发送查询', N'sys_sms_mgr_page', 2, NULL, NULL, NULL, N'sms:page', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914676, 142307070914674, N'[0],[142307070914662],[142307070914674],', N'发送验证码短信', N'sys_sms_mgr_send_login_message', 2, NULL, NULL, NULL, N'sms:sendLoginMessage', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914677, 142307070914674, N'[0],[142307070914662],[142307070914674],', N'验证短信验证码', N'sys_sms_mgr_validate_message', 2, NULL, NULL, NULL, N'sms:validateMessage', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914678, 142307070914662, N'[0],[142307070914662],', N'字典管理', N'sys_dict_mgr', 1, NULL, N'/dict', N'system/dict/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914679, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典类型查询', N'sys_dict_mgr_dict_type_page', 2, NULL, NULL, NULL, N'sysDictType:page', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914680, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典类型列表', N'sys_dict_mgr_dict_type_list', 2, NULL, NULL, NULL, N'sysDictType:list', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914681, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典类型增加', N'sys_dict_mgr_dict_type_add', 2, NULL, NULL, NULL, N'sysDictType:add', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914682, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典类型删除', N'sys_dict_mgr_dict_type_delete', 2, NULL, NULL, NULL, N'sysDictType:delete', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914683, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典类型编辑', N'sys_dict_mgr_dict_type_edit', 2, NULL, NULL, NULL, N'sysDictType:edit', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914684, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典类型详情', N'sys_dict_mgr_dict_type_detail', 2, NULL, NULL, NULL, N'sysDictType:detail', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914685, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典类型下拉', N'sys_dict_mgr_dict_type_drop_down', 2, NULL, NULL, NULL, N'sysDictType:dropDown', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914686, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典类型修改状态', N'sys_dict_mgr_dict_type_change_status', 2, NULL, NULL, NULL, N'sysDictType:changeStatus', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070914687, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典值查询', N'sys_dict_mgr_dict_page', 2, NULL, NULL, NULL, N'sysDictData:page', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918725, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典值列表', N'sys_dict_mgr_dict_list', 2, NULL, NULL, NULL, N'sysDictData:list', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918726, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典值增加', N'sys_dict_mgr_dict_add', 2, NULL, NULL, NULL, N'sysDictData:add', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918727, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典值删除', N'sys_dict_mgr_dict_delete', 2, NULL, NULL, NULL, N'sysDictData:delete', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918728, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典值编辑', N'sys_dict_mgr_dict_edit', 2, NULL, NULL, NULL, N'sysDictData:edit', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918729, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典值详情', N'sys_role_mgr_grant_data', 2, NULL, NULL, NULL, N'sysDictData:detail', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
GO
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918730, 142307070914678, N'[0],[142307070914662],[142307070914678],', N'字典值修改状态', N'sys_dict_mgr_dict_change_status', 2, NULL, NULL, NULL, N'sysDictData:changeStatus', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918731, 142307070914662, N'[0],[142307070914662],', N'接口文档', N'sys_swagger_mgr', 1, NULL, N'/swagger', N'Iframe', NULL, N'system', 2, N'Y', N'http://localhost:5566/', NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918732, 0, N'[0],', N'日志管理', N'sys_log_mgr', 0, N'read', N'/log', N'PageView', NULL, N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918733, 142307070918732, N'[0],[142307070918732],', N'访问日志', N'sys_log_mgr_vis_log', 1, NULL, N'/vislog', N'system/log/vislog/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918734, 142307070918733, N'[0],[142307070918732],[142307070918733],', N'访问日志查询', N'sys_log_mgr_vis_log_page', 2, NULL, NULL, NULL, N'sysVisLog:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918735, 142307070918733, N'[0],[142307070918732],[142307070918733],', N'访问日志清空', N'sys_log_mgr_vis_log_delete', 2, NULL, NULL, NULL, N'sysVisLog:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918736, 142307070918732, N'[0],[142307070918732],', N'操作日志', N'sys_log_mgr_op_log', 1, NULL, N'/oplog', N'system/log/oplog/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918737, 142307070918736, N'[0],[142307070918732],[142307070918736],', N'操作日志查询', N'sys_log_mgr_op_log_page', 2, NULL, NULL, NULL, N'sysOpLog:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918738, 142307070918736, N'[0],[142307070918732],[142307070918736],', N'操作日志清空', N'sys_log_mgr_op_log_delete', 2, NULL, NULL, NULL, N'sysOpLog:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918739, 0, N'[0],', N'系统监控', N'sys_monitor_mgr', 0, N'deployment-unit', N'/monitor', N'PageView', NULL, N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918740, 142307070918739, N'[0],[142307070918739],', N'服务监控', N'sys_monitor_mgr_machine_monitor', 1, NULL, N'/machine', N'system/machine/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918741, 142307070918740, N'[0],[142307070918739],[142307070918740],', N'服务监控查询', N'sys_monitor_mgr_machine_monitor_query', 2, NULL, NULL, NULL, N'sysMachine:query', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918742, 142307070918739, N'[0],[142307070918739],', N'在线用户', N'sys_monitor_mgr_online_user', 1, NULL, N'/onlineUser', N'system/onlineUser/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918743, 142307070918742, N'[0],[142307070918739],[142307070918742],', N'在线用户列表', N'sys_monitor_mgr_online_user_list', 2, NULL, NULL, NULL, N'sysOnlineUser:list', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918744, 142307070918742, N'[0],[142307070918739],[142307070918742],', N'在线用户强退', N'sys_monitor_mgr_online_user_force_exist', 2, NULL, NULL, NULL, N'sysOnlineUser:forceExist', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918745, 142307070918739, N'[0],[142307070918739],', N'数据监控', N'sys_monitor_mgr_druid', 1, NULL, N'/druid', N'Iframe', NULL, N'system', 2, N'N', N'http://localhost:82/druid/login.html', NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918746, 0, N'[0],', N'通知公告', N'sys_notice', 0, N'sound', N'/notice', N'PageView', NULL, N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918747, 142307070918746, N'[0],[142307070918746],', N'公告管理', N'sys_notice_mgr', 1, NULL, N'/notice', N'system/notice/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918748, 142307070918747, N'[0],[142307070918746],[142307070918747],', N'公告查询', N'sys_notice_mgr_page', 2, NULL, NULL, NULL, N'sysNotice:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918749, 142307070918747, N'[0],[142307070918746],[142307070918747],', N'公告增加', N'sys_notice_mgr_add', 2, NULL, NULL, NULL, N'sysNotice:add', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918750, 142307070918747, N'[0],[142307070918746],[142307070918747],', N'公告编辑', N'sys_notice_mgr_edit', 2, NULL, NULL, NULL, N'sysNotice:edit', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918751, 142307070918747, N'[0],[142307070918746],[142307070918747],', N'公告删除', N'sys_notice_mgr_delete', 2, NULL, NULL, NULL, N'sysNotice:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918752, 142307070918747, N'[0],[142307070918746],[142307070918747],', N'公告查看', N'sys_notice_mgr_detail', 2, NULL, NULL, NULL, N'sysNotice:detail', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918753, 142307070918747, N'[0],[142307070918746],[142307070918747],', N'公告修改状态', N'sys_notice_mgr_changeStatus', 2, NULL, NULL, NULL, N'sysNotice:changeStatus', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918754, 142307070918746, N'[0],[142307070918746],', N'已收公告', N'sys_notice_mgr_received', 1, NULL, N'/noticeReceived', N'system/noticeReceived/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918755, 142307070918754, N'[0],[142307070918746],[142307070918754],', N'已收公告查询', N'sys_notice_mgr_received_page', 2, NULL, NULL, NULL, N'sysNotice:received', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918756, 0, N'[0],', N'文件管理', N'sys_file_mgr', 0, N'file', N'/file', N'PageView', NULL, N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918757, 142307070918756, N'[0],[142307070918756],', N'系统文件', N'sys_file_mgr_sys_file', 1, NULL, N'/file', N'system/file/index', NULL, N'manage', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918758, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'文件查询', N'sys_file_mgr_sys_file_page', 2, NULL, NULL, NULL, N'sysFileInfo:page', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918759, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'文件列表', N'sys_file_mgr_sys_file_list', 2, NULL, NULL, NULL, N'sysFileInfo:list', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918760, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'文件删除', N'sys_file_mgr_sys_file_delete', 2, NULL, NULL, NULL, N'sysFileInfo:delete', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918761, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'文件详情', N'sys_file_mgr_sys_file_detail', 2, NULL, NULL, NULL, N'sysFileInfo:detail', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918762, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'文件上传', N'sys_file_mgr_sys_file_upload', 2, NULL, NULL, NULL, N'sysFileInfo:upload', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918763, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'文件下载', N'sys_file_mgr_sys_file_download', 2, NULL, NULL, NULL, N'sysFileInfo:download', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918764, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'图片预览', N'sys_file_mgr_sys_file_preview', 2, NULL, NULL, NULL, N'sysFileInfo:preview', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918765, 0, N'[0],', N'定时任务', N'sys_timers', 0, N'dashboard', N'/timers', N'PageView', NULL, N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918766, 142307070918765, N'[0],[142307070918765],', N'任务管理', N'sys_timers_mgr', 1, NULL, N'/timers', N'system/timers/index', NULL, N'system', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918767, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务查询', N'sys_timers_mgr_page', 2, NULL, NULL, NULL, N'sysTimers:page', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918768, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务列表', N'sys_timers_mgr_list', 2, NULL, NULL, NULL, N'sysTimers:list', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918769, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务详情', N'sys_timers_mgr_detail', 2, NULL, NULL, NULL, N'sysTimers:detail', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918770, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务增加', N'sys_timers_mgr_add', 2, NULL, NULL, NULL, N'sysTimers:add', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918771, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务删除', N'sys_timers_mgr_delete', 2, NULL, NULL, NULL, N'sysTimers:delete', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918772, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务编辑', N'sys_timers_mgr_edit', 2, NULL, NULL, NULL, N'sysTimers:edit', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918773, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务可执行列表', N'sys_timers_mgr_get_action_classes', 2, NULL, NULL, NULL, N'sysTimers:getActionClasses', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918774, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务启动', N'sys_timers_mgr_start', 2, NULL, NULL, NULL, N'sysTimers:start', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918775, 142307070918766, N'[0],[142307070918765],[142307070918766],', N'定时任务关闭', N'sys_timers_mgr_stop', 2, NULL, NULL, NULL, N'sysTimers:stop', N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918776, 0, N'[0],', N'代码生成', N'code_gen', 1, N'thunderbolt', N'/codeGenerate/index', N'gen/codeGenerate/index', NULL, N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918777, 142307070910564, N'[0],[142307070910563],[142307070910564],', N'用户登录信息', N'sys_user_mgr_login', 2, NULL, NULL, NULL, N'getLoginUser', N'manage', 0, N'N', NULL, NULL, 1, 100, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918782, 0, N'[0],', N'SaaS租户', N'sys_tenant', 1, N'switcher', N'/tenant', N'PageView', NULL, N'platform', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070918783, 142307070918782, N'[0],[142307070918782],', N'租户管理', N'sys_tenant_mgr', 1, NULL, N'/tenant', N'system/tenant/index', NULL, N'platform', 1, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922821, 142307070918783, N'[0],[142307070918782],[142307070918783],', N'租户查询', N'sys_tenant_mgr_page', 2, NULL, NULL, NULL, N'sysTenant:page', N'platform', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922822, 142307070918783, N'[0],[142307070918782],[142307070918783],', N'租户详情', N'sys_tenant_mgr_detail', 2, NULL, NULL, NULL, N'sysTenant:detail', N'platform', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922823, 142307070918783, N'[0],[142307070918782],[142307070918783],', N'租户增加', N'sys_tenant_mgr_add', 2, NULL, NULL, NULL, N'sysTenant:add', N'platform', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922824, 142307070918783, N'[0],[142307070918782],[142307070918783],', N'租户删除', N'sys_tenant_mgr_delete', 2, NULL, NULL, NULL, N'sysTenant:delete', N'platform', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922825, 142307070918783, N'[0],[142307070918782],[142307070918783],', N'租户编辑', N'sys_tenant_mgr_edit', 2, NULL, NULL, NULL, N'sysTenant:edit', N'platform', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922826, 142307070918783, N'[0],[142307070918782],[142307070918783],', N'授权租户菜单', N'sys_tenant_mgr_grant_menu', 2, NULL, NULL, NULL, N'sysTenant:grantMenu', N'platform', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922827, 142307070918783, N'[0],[142307070918782],[142307070918783],', N'重置租户密码', N'sys_tenant_mgr_reset_pwd', 2, NULL, NULL, NULL, N'sysTenant:resetPwd', N'platform', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922870, 0, N'[0],', N'表单设计', N'form_design', 1, N'robot', N'/formDesign/index', N'system/formDesign/index', NULL, N'system', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922874, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'头像上传', N'sys_file_mgr_sys_file_upload_avatar', 2, NULL, NULL, NULL, N'sysFileInfo:uploadAvatar', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922875, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'文档上传', N'sys_file_mgr_sys_file_upload_document', 2, NULL, NULL, NULL, N'sysFileInfo:uploadDocument', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070922876, 142307070918757, N'[0],[142307070918756],[142307070918757],', N'商城上传', N'sys_file_mgr_sys_file_upload_shop', 2, NULL, NULL, NULL, N'sysFileInfo:uploadShop', N'manage', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (178075287240773, 0, N'[0],', N'大屏监控', N'main_screen_monitor', 1, N'pie-chart', N'/monitor', N'main/screenMonitor/index', N'', N'busiapp', 0, N'Y', NULL, N'', 2, 100, NULL, 0, CAST(N'2021-07-07T14:50:13.943' AS DateTime), CAST(N'2021-07-07T14:54:25.190' AS DateTime), 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (178079567294533, 0, N'[0],', N'地理信息', N'main_map', 1, N'environment', N'/map', N'main/map/index', N'', N'busiapp', 0, N'Y', NULL, N'', 2, 100, NULL, 0, CAST(N'2021-07-07T15:07:38.880' AS DateTime), CAST(N'2021-07-08T15:21:28.267' AS DateTime), 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182612191891525, 0, N'[0],', N'数据库管理', N'database_manager', 1, N'radar-chart', N'/database/index', N'gen/database/index', N'', N'system', 0, N'Y', NULL, N'', 1, 100, NULL, 0, CAST(N'2021-07-20T10:30:56.680' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182692422213701, 182612191891525, N'[0],[182612191891525],', N'新增数据表', N'table_add', 2, N'', N'', N'', N'table:add', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2021-07-20T16:21:16.130' AS DateTime), 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182692650123333, 182612191891525, N'[0],[182612191891525],', N'编辑数据表', N'table_edit', 2, N'', N'', N'', N'table:edit', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T15:58:19.803' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182692815732805, 182612191891525, N'[0],[182612191891525],', N'删除数据表', N'table_delete', 2, N'', N'', N'', N'table:delete', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T15:59:00.237' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182693142773829, 182612191891525, N'[0],[182612191891525],', N'新增数据列', N'column_add', 2, N'', N'', N'', N'column:add', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:00:20.080' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182693266526277, 182612191891525, N'[0],[182612191891525],', N'编辑数据列', N'column_edit', 2, N'', N'', N'', N'column:edit', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:00:50.293' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182693372485701, 182612191891525, N'[0],[182612191891525],', N'删除数据列', N'column_delete', 2, N'', N'', N'', N'column:delete', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:01:16.163' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182699700703301, 142307070918776, N'[0],[142307070918776],', N'新增代码生成', N'codeGenerate_add', 2, N'', N'', N'', N'codeGenerate:add', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:27:01.137' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182700299632709, 142307070918776, N'[0],[142307070918776],', N'编辑代码生成', N'codeGenerate_edit', 2, N'', N'', N'', N'codeGenerate:edit', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:29:27.360' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182700412936261, 142307070918776, N'[0],[142307070918776],', N'删除代码生成', N'codeGenerate:delete', 2, N'', N'', N'', N'codeGenerate:delete', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:29:55.023' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182700585140293, 142307070918776, N'[0],[142307070918776],', N'开始生成', N'codeGenerate_runDown', 2, N'', N'', N'', N'codeGenerate:runDown', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:30:37.063' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182700864315461, 142307070918776, N'[0],[142307070918776],', N'生成到本地', N'codeGenerate_runLocal', 2, N'', N'', N'', N'codeGenerate:runLocal', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:31:45.223' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (182701004218437, 142307070918776, N'[0],[142307070918776],', N'生成代码配置', N'codeGenerate_config', 2, N'', N'', N'', N'codeGenerate:config', N'system', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2021-07-20T16:32:19.377' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (183425655615557, 182612191891525, N'[0],[182612191891525],', N'数据库表查询', N'dataBase_tableInfoList', 2, N'', N'', N'', N'dataBase:tableInfoList', N'system', 0, N'Y', N'', N'', 1, 98, NULL, 0, NULL, CAST(N'2021-07-22T17:41:23.773' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (183425947672645, 182612191891525, N'[0],[182612191891525],', N'数据表列查询', N'dataBase_columnInfoList', 2, N'', N'', N'', N'dataBase:columnInfoList', N'system', 0, N'Y', N'', N'', 1, 99, NULL, 0, CAST(N'2021-07-22T17:42:07.527' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (183426282242117, 142307070918776, N'[0],[142307070918776],', N'代码生成查询', N'codeGenerate_page', 2, N'', N'', N'', N'codeGenerate:page', N'system', 0, N'Y', N'', N'', 1, 98, NULL, 0, CAST(N'2021-07-22T17:43:29.207' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (183426519642181, 142307070918776, N'[0],[142307070918776],', N'代码生成配置查询', N'sysCodeGenerateConfig_list', 2, N'', N'', N'', N'sysCodeGenerateConfig:list', N'system', 0, N'Y', N'', N'', 1, 99, NULL, 0, CAST(N'2021-07-22T17:44:27.167' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (246828204404805, 249828267671621, N'[0],[249828267671621],', N'表单管理', N'flc_form_mgr', 1, N'', N'/flcForm', N'flowCenter/form/index', N'', N'flowcenter', 0, N'Y', NULL, N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:57:36.147' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (246829143507013, 246828204404805, N'[0],[249828267671621],[246828204404805],', N'表单查询', N'flc_form_mgr_page', 2, N'', N'', N'', N'flcForm:page', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:15.723' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (246829667049541, 246828204404805, N'[0],[249828267671621],[246828204404805],', N'表单新增', N'flc_form_mgr_add', 2, N'', N'', N'', N'flcForm:add', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:15.723' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (246829802606661, 246828204404805, N'[0],[249828267671621],[246828204404805],', N'表单编辑', N'flc_form_mgr_edit', 2, N'', N'', N'', N'flcForm:edit', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:15.723' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (246829942235205, 246828204404805, N'[0],[249828267671621],[246828204404805],', N'表单删除', N'flc_form_mgr_delete', 2, N'', N'', N'', N'flcForm:delete', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:15.723' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (246830165426245, 246828204404805, N'[0],[249828267671621],[246828204404805],', N'表单详情', N'flc_form_mgr_detail', 2, N'', N'', N'', N'flcForm:detail', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:15.723' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (246841718005829, 246828204404805, N'[0],[249828267671621],[246828204404805],', N'表单列表', N'flc_form_mgr_list', 2, N'', N'', N'', N'flcForm:list', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:15.723' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (247090057326661, 246828204404805, N'[0],[249828267671621],[246828204404805],', N'表单设计', N'flc_form_mgr_design', 2, N'', N'', N'', N'flcForm:design', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2022-01-18T15:12:03.047' AS DateTime), CAST(N'2022-01-26T08:55:15.723' AS DateTime), 142307070910551, N'superAdmin', 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (248420412096581, 249828267671621, N'[0],[249828267671621],', N'流程管理', N'flc_flow_mgr', 1, N'', N'/flcFlow', N'flowCenter/flow/index', NULL, N'flowcenter', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:57:47.367' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (248420412231749, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程查询', N'flc_flow_mgr_page', 2, NULL, NULL, NULL, N'flcFlowscheme:page', N'flowcenter', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:07.453' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (248420412231750, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程详情', N'flc_flow_mgr_detail', 2, NULL, NULL, NULL, N'flcFlowscheme:detail', N'flowcenter', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:07.453' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (248420412231751, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程增加', N'flc_flow_mgr_add', 2, NULL, NULL, NULL, N'flcFlowscheme:add', N'flowcenter', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:07.453' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (248420412231752, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程删除', N'flc_flow_mgr_delete', 2, NULL, NULL, NULL, N'flcFlowscheme:delete', N'flowcenter', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:07.453' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (248420412231753, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程编辑', N'flc_flow_mgr_edit', 2, NULL, NULL, NULL, N'flcFlowscheme:edit', N'flowcenter', 0, N'Y', NULL, NULL, 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:07.453' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (248433799409733, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程列表', N'flc_flow_mgr_list', 2, N'', N'', N'', N'flcFlowscheme:list', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:07.453' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (248433972678725, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程设计', N'flc_flow_mgr_design', 2, N'', N'', N'', N'flcFlowscheme:design', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:55:07.453' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (249684917448773, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程预览', N'flc_flow_mgr_preview', 2, N'', N'', N'', N'flcFlowscheme:preview', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2022-01-25T23:10:33.820' AS DateTime), CAST(N'2022-01-26T08:55:07.453' AS DateTime), 142307070910551, N'superAdmin', 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (249685119098949, 246828204404805, N'[0],[249828267671621],[246828204404805],', N'表单预览', N'flc_form_mgr_preview', 2, N'', N'', N'', N'flcForm:preview', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2022-01-25T23:11:23.050' AS DateTime), CAST(N'2022-01-26T08:55:15.723' AS DateTime), 142307070910551, N'superAdmin', 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (249828267671621, 0, N'[0],', N'工作流设置', N'flc_mgr', 0, N'retweet', N'/flc', N'PageView', N'', N'flowcenter', 0, N'Y', NULL, N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-26T08:54:53.350' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (249839600734277, 0, N'[0],', N'工作流', N'flc_center', 0, N'qrcode', N'/flcCenter', N'PageView', N'', N'flowcenter', 0, N'Y', NULL, N'', 1, 100, NULL, 0, CAST(N'2022-01-26T09:39:58.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
GO
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (249840339677253, 249839600734277, N'[0],[249839600734277],', N'我的申请', N'flc_center_my', 1, NULL, N'/workflow/my', N'flowCenter/workflow/my', N'', N'flowcenter', 0, N'Y', NULL, N'', 1, 2, NULL, 0, NULL, CAST(N'2022-01-27T15:23:07.820' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (249840961151045, 249839600734277, N'[0],[249839600734277],', N'待处理申请', N'flc_center_undone', 1, NULL, N'/workflow/undone', N'flowCenter/workflow/undone', N'', N'flowcenter', 1, N'Y', NULL, N'', 1, 3, NULL, 0, NULL, CAST(N'2022-01-27T15:23:12.537' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (249841253343301, 249839600734277, N'[0],[249839600734277],', N'已处理申请', N'flc_center_done', 1, NULL, N'/workflow/done', N'flowCenter/workflow/done', N'', N'flowcenter', 0, N'Y', NULL, N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T15:23:16.227' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (249845560930373, 249839600734277, N'[0],[249839600734277],', N'创建申请', N'flc_center_create', 1, NULL, N'/workflow/create', N'flowCenter/workflow/create', N'', N'flowcenter', 0, N'Y', NULL, N'', 1, 1, NULL, 0, NULL, CAST(N'2022-01-27T15:23:02.753' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250246088646725, 249845560930373, N'[0],[249839600734277],[249845560930373],', N'创建申请', N'flc_center_create_add', 2, N'', N'', N'', N'flcFlowinstance:add', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T13:55:52.017' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250246654218309, 249845560930373, N'[0],[249839600734277],[249845560930373],', N'流程列表', N'flc_center_create_page', 2, N'', N'', N'', N'flcFlowscheme:page', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2022-01-27T13:16:16.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250248590839877, 249840339677253, N'[0],[249839600734277],[249840339677253],', N'申请查询', N'flc_center_my_page', 2, N'', N'', N'', N'flcFlowinstance:page', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T13:56:03.513' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250249084047429, 249840961151045, N'[0],[249839600734277],[249840961151045],', N'申请查询', N'flc_center_undone_page', 2, N'', N'', N'', N'flcFlowinstance:page', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T13:56:20.900' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250249277808709, 249841253343301, N'[0],[249839600734277],[249841253343301],', N'申请查询', N'flc_center_done_page', 2, N'', N'', N'', N'flcFlowinstance:page', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T13:56:27.310' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250255905538117, 249840339677253, N'[0],[249839600734277],[249840339677253],', N'申请详情', N'flc_center_my_detail', 2, N'', N'', N'', N'flcFlowinstance:detail', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T13:56:11.560' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250257271820357, 249841253343301, N'[0],[249839600734277],[249841253343301],', N'申请详情', N'flc_center_done_detail', 2, N'', N'', N'', N'flcFlowinstance:detail', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2022-01-27T13:59:28.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250258434728005, 249840961151045, N'[0],[249839600734277],[249840961151045],', N'申请处理', N'flc_center_undone_verification', 2, N'', N'', N'', N'flcFlowinstance:verification', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T14:06:08.940' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250258651136069, 249840339677253, N'[0],[249839600734277],[249840339677253],', N'申请编辑', N'flc_center_my_edit', 2, N'', N'', N'', N'flcFlowinstance:edit', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T14:05:58.917' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250258822766661, 249840339677253, N'[0],[249839600734277],[249840339677253],', N'申请删除', N'flc_center_my_delete', 2, N'', N'', N'', N'flcFlowinstance:delete', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T14:06:04.077' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250259140735045, 249840339677253, N'[0],[249839600734277],[249840339677253],', N'申请撤回', N'flc_center_my_cancle', 2, N'', N'', N'', N'flcFlowinstance:cancle', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, NULL, CAST(N'2022-01-27T14:07:16.057' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (250609169530949, 248420412096581, N'[0],[249828267671621],[248420412096581],', N'流程变更状态', N'flc_flow_mgr_changestatus', 2, N'', N'', N'', N'flcFlowscheme:changeStatus', N'flowcenter', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2022-01-28T13:51:21.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277111901716549, 0, N'[0],', N'文档管理', N'doc_manager', 0, N'folder', N'/doc', N'PageView', N'', N'manage', 1, N'Y', NULL, N'', 1, 100, NULL, 0, CAST(N'2022-04-13T11:11:14.900' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277116957925445, 277111901716549, N'[0],[277111901716549],', N'文档管理', N'zxzyadmin_document_mgr', 1, NULL, N'/document', N'system/fileManage/document/index', NULL, N'manage', 1, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-13T11:31:49.327' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277116957995077, 277116957925445, N'[0],[277111901716549],[277116957925445],', N'文档查询', N'zxzyadmin_document_mgr_page', 2, NULL, NULL, NULL, N'Document:page', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-13T11:31:49.343' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277116957995078, 277116957925445, N'[0],[277111901716549],[277116957925445],', N'文档详情', N'zxzyadmin_document_mgr_detail', 2, NULL, NULL, NULL, N'Document:detail', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-13T11:31:49.343' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277116957995079, 277116957925445, N'[0],[277111901716549],[277116957925445],', N'文档增加', N'zxzyadmin_document_mgr_add', 2, NULL, NULL, NULL, N'Document:add', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-13T11:31:49.343' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277116957995080, 277116957925445, N'[0],[277111901716549],[277116957925445],', N'文档删除', N'zxzyadmin_document_mgr_delete', 2, NULL, NULL, NULL, N'Document:delete', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-13T11:31:49.343' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277116957995081, 277116957925445, N'[0],[277111901716549],[277116957925445],', N'文档编辑', N'zxzyadmin_document_mgr_edit', 2, NULL, NULL, NULL, N'Document:edit', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-13T11:31:49.343' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (277289592221765, 142307070918783, N'[0],[142307070918782],[142307070918783],', N'模拟登录', N'sysTenant_simulation_login', 2, N'', N'', N'', N'simulationTenantLogin', N'platform', 0, N'Y', N'', N'', 2, 100, N'模拟租户登录', 0, CAST(N'2022-04-16T23:14:16.000' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (278944617066565, 277111901716549, N'[0],[277111901716549],', N'回收站', N'zxzyadmin_trash_mgr', 1, NULL, N'/trash', N'system/fileManage/trash/index', NULL, N'manage', 1, N'Y', NULL, NULL, 2, 100, NULL, 0, NULL, CAST(N'2022-04-18T16:37:17.910' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (278944617115717, 278944617066565, N'[0],[277111901716549],[278944617066565],', N'回收站查询', N'zxzyadmin_trash_mgr_page', 2, NULL, NULL, NULL, N'Trash:page', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-18T15:28:35.183' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (278944617115718, 278944617066565, N'[0],[277111901716549],[278944617066565],', N'回收站详情', N'zxzyadmin_trash_mgr_detail', 2, NULL, NULL, NULL, N'Trash:detail', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-18T15:28:35.183' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (278944617115719, 278944617066565, N'[0],[277111901716549],[278944617066565],', N'回收站增加', N'zxzyadmin_trash_mgr_add', 2, NULL, NULL, NULL, N'Trash:add', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-18T15:28:35.183' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (278944617115720, 278944617066565, N'[0],[277111901716549],[278944617066565],', N'回收站删除', N'zxzyadmin_trash_mgr_delete', 2, NULL, NULL, NULL, N'Trash:delete', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-18T15:28:35.183' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (278944617115721, 278944617066565, N'[0],[277111901716549],[278944617066565],', N'回收站编辑', N'zxzyadmin_trash_mgr_edit', 2, NULL, NULL, NULL, N'Trash:edit', N'manage', 0, N'Y', NULL, NULL, 2, 100, NULL, 0, CAST(N'2022-04-18T15:28:35.183' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_menu] ([Id], [Pid], [Pids], [Name], [Code], [Type], [Icon], [Router], [Component], [Permission], [Application], [OpenType], [Visible], [Link], [Redirect], [Weight], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (279313808535621, 277116957925445, N'[0],[277111901716549],[277116957925445],', N'文档下载', N'document_download', 2, N'', N'', N'', N'Document:download', N'manage', 0, N'Y', N'', N'', 1, 100, NULL, 0, CAST(N'2022-04-19T16:30:49.807' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179794426552389, N'1', N'1111<p></p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:25:31.123' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:25:25.690' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179794551148613, N'2', N'<p>333</p>', 2, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:25:56.110' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:25:56.110' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179798127382597, N'4', N'444<p></p>', 2, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:40:29.210' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:40:29.213' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179798369882181, N'6', N'6666<p></p>', 2, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:41:28.417' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:41:28.417' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179799297638469, N'777', N'玉婷<p></p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:45:14.920' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:45:14.920' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179799792885829, N'Ang', N'frgf<p></p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:47:15.830' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:47:15.830' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179799966392389, N'fgfg', N'fgfg<p></p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:47:58.190' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:47:58.190' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179800281276485, N'878', N'8888<p></p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:49:15.067' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:49:15.067' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179801393012805, N'hgfhh', N'gfhgf<p></p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:53:49.537' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:53:46.487' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179801499226181, N'jlkjllj', N'<p>hjkhjkjh</p>', 2, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:54:12.417' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:54:12.417' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179801551765573, N'jhkhkhj', N'<p>hkhjkh</p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T11:54:25.243' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T11:54:25.243' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179803119427653, N'FGHGF', N'GFHGF<p></p>', 2, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T12:00:47.973' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T12:00:47.973' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179803196371013, N'HAHAH', N'<p>FDGFDGFD</p>', 2, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T12:01:06.760' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T12:01:06.760' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179803415650373, N'HAHAHA', N'GFHGF<p></p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T12:02:00.293' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T12:02:00.293' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (179826348257349, N'呵呵呵', N'第三方大幅度<p></p>', 1, 177325484421189, N'郑国静', 177325089079365, N'系统机构', CAST(N'2021-07-12T13:35:19.073' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-07-12T13:35:19.077' AS DateTime), NULL, 177325484421189, N'admin', NULL, NULL, 0)
INSERT [dbo].[sys_notice] ([Id], [Title], [Content], [Type], [PublicUserId], [PublicUserName], [PublicOrgId], [PublicOrgName], [PublicTime], [CancelTime], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (193416668713029, N'风格和规范', N'风格化规范化<p></p>', 1, 142307070910551, N'超级管理员', 177325089079365, N'系统机构', CAST(N'2021-08-19T23:14:28.403' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2021-08-19T23:14:28.407' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179794426552389, 177325484421189, CAST(N'2021-07-12T11:40:09.753' AS DateTime), 1)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179794551148613, 177325484421189, CAST(N'2021-07-12T11:40:13.633' AS DateTime), 1)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179798127382597, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179798369882181, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179799297638469, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179799792885829, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179799966392389, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179800281276485, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179803119427653, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179803196371013, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179803415650373, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179826348257349, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179801393012805, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179801499226181, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (179801551765573, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[sys_notice_user] ([NoticeId], [UserId], [ReadTime], [ReadStatus]) VALUES (193416668713029, 177325484421189, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[sys_online_user] ON 

INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (11, N'adMKFkjXFA1viX0X58NRLg', 142307070910551, CAST(N'2021-06-30T17:58:23.717' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (12, N'Vy8zuu-rSGHytMtIAOiD0g', 142307070910551, CAST(N'2021-06-30T17:59:43.670' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (13, N'sByI59aVrFETZqoUH9QBUw', 142307070910551, CAST(N'2021-06-30T18:04:50.197' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (14, N'qH6SKAdmmpnv-VaqVehXBQ', 142307070910551, CAST(N'2021-07-05T11:56:16.393' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (21, N'JOVkl6w6bygEBnNrrZ0RnQ', 142307070910551, CAST(N'2021-07-05T13:59:57.117' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (22, N'FbXdzMr-bbkKUPQeYyESkQ', 142307070910551, CAST(N'2021-07-05T14:07:35.770' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (23, N'8wtPh5tvU12JafAFaQ6m-A', 142307070910551, CAST(N'2021-07-05T14:08:41.073' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (24, N'D7dB13ZXnuwJSgN-zzyVmw', 142307070910551, CAST(N'2021-07-05T14:13:23.813' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (25, N'TWlwYMJ3IjjiwMVQLT5WHg', 142307070910551, CAST(N'2021-07-05T14:21:30.823' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (26, N'nfxxrN4gwK226LDX65JZqw', 142307070910551, CAST(N'2021-07-05T14:27:27.787' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (27, N'1fJ3-mIKHHWPDyMw1kWGaA', 142307070910551, CAST(N'2021-07-05T15:02:47.807' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (28, N'l2Md46FxhSNXGxgR9znDcQ', 142307070910551, CAST(N'2021-07-05T16:26:57.577' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (29, N'-Lr_1jzeNqGWb1U3FZ4QuQ', 142307070910551, CAST(N'2021-07-05T16:30:23.857' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (30, N'OD9slXIOOgL7b3LCydwfhw', 142307070910551, CAST(N'2021-07-06T11:58:08.943' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (31, N'nd5xCdhqQh0q8WhjccS5TA', 142307070910551, CAST(N'2021-07-06T13:44:39.250' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (32, N'S7j8IPs6LL8H80hcli79Vw', 142307070910551, CAST(N'2021-07-06T13:49:03.553' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (33, N'jHfBSc0v647cOqup9MdzMw', 142307070910551, CAST(N'2021-07-06T15:05:12.160' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (34, N'3nuDpclqqLoq-jTlLw79TQ', 142307070910551, CAST(N'2021-07-06T15:06:22.223' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (35, N'qDA9PC00X1ik9wXop6cfXg', 142307070910551, CAST(N'2021-07-06T15:07:02.467' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (37, N'6kvKRmRV6E_pt2ISnoYOPw', 142307070910551, CAST(N'2021-07-06T15:12:59.893' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (39, N'DYX7vfW1_TAYRSk9mwVDNA', 142307070910551, CAST(N'2021-07-06T15:15:20.253' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (41, N'MZeegRKM9wvedKQnCWu1LQ', 142307070910551, CAST(N'2021-07-06T15:18:28.907' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (43, N'6RusCQIdE-GCCRX6nl-BnQ', 142307070910551, CAST(N'2021-07-06T15:20:56.407' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (44, N'pVs63jMbceoBPhC54DcL3g', 142307070910551, CAST(N'2021-07-06T15:24:19.560' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (47, N'-54fmntGh9xyrAVxJ9yMvw', 142307070910551, CAST(N'2021-07-06T16:08:42.617' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (48, N'NT3M8Z6q58CbNACUZF3o-g', 142307070910551, CAST(N'2021-07-06T16:11:32.060' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (49, N'5xgNPDvk6ygf3nAUgoapAg', 142307070910551, CAST(N'2021-07-06T16:14:10.857' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (51, N'M73IEwX-wNeF3Femt_4pkA', 142307070910551, CAST(N'2021-07-06T16:21:53.550' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (52, N'Td9X9QOA5DBtB9gSW0jyHA', 142307070910551, CAST(N'2021-07-06T16:26:41.337' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (53, N'dszDowX81JLyo5UWxITRkw', 142307070910551, CAST(N'2021-07-06T16:29:39.483' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (55, N'RFcWJQ6pySED1II2YQg7vg', 142307070910551, CAST(N'2021-07-06T16:43:19.223' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (56, N'JL7IAiNoLJKOZ11PAfMEhQ', 142307070910551, CAST(N'2021-07-06T16:45:57.557' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (57, N'Ir_Yfp5WGEyZ7AcDAA6x6g', 142307070910551, CAST(N'2021-07-06T16:47:04.547' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (59, N'd9AKXzkz49djAIv_ScGe0g', 142307070910551, CAST(N'2021-07-06T16:48:34.513' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (60, N'qv99VReqcL_jzp8ERW4GVA', 142307070910551, CAST(N'2021-07-06T16:51:04.083' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (62, N'5Q1xSCNUoeXuhC_r2erlhw', 142307070910551, CAST(N'2021-07-06T16:59:45.097' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (65, N'efPIQozlW7llCCYiAK04Gg', 142307070910551, CAST(N'2021-07-06T17:43:40.023' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (67, N'GcjvlyH5-6no5RRIpSZSJg', 142307070910551, CAST(N'2021-07-06T17:44:28.330' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (68, N'8UT1BYqo6-qR5EorCSNLTQ', 142307070910551, CAST(N'2021-07-06T17:50:42.533' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (69, N'y5dUvOq3dS08NlyLCh7rJQ', 142307070910551, CAST(N'2021-07-06T17:51:28.010' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (70, N'vvJFyFZCdnr3fZ20uefUIg', 142307070910551, CAST(N'2021-07-07T09:36:32.980' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (71, N'Wxn2gYNm-LzOxT6V1-U4TQ', 142307070910551, CAST(N'2021-07-07T09:37:47.190' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (72, N'kT9jcDDhAg16RE09pdHY3A', 142307070910551, CAST(N'2021-07-07T09:42:08.943' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (74, N'Ec_DAav4z2gC0qzTzoeUSw', 142307070910551, CAST(N'2021-07-07T09:49:53.223' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (75, N'4fyrli8eefOrklm7TMc1pQ', 142307070910551, CAST(N'2021-07-07T09:54:30.293' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (77, N'HWxLgwo8OaKfdyn98lDgsQ', 142307070910551, CAST(N'2021-07-07T09:55:17.037' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (78, N'i8YPs15-P2NJZwoTWq_dEg', 142307070910551, CAST(N'2021-07-07T09:57:10.850' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (79, N'y_OtQWVPjsSumlVoXzJlOw', 142307070910551, CAST(N'2021-07-07T10:01:03.973' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (80, N'ItLAw0fAGLcLqGbcwpUcvQ', 142307070910551, CAST(N'2021-07-07T10:03:21.017' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (83, N'egnhPASlH9fC-HYCt9D82w', 142307070910551, CAST(N'2021-07-07T11:27:06.003' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (84, N'k6_M-CkmrdcleHUy_B1iMw', 142307070910551, CAST(N'2021-07-07T11:29:42.243' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (92, N'dr9sooirX1nWUQ17szxGOg', 142307070910551, CAST(N'2021-07-07T15:16:58.053' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (97, N'La3B1z_XZsjvnSJYKFPGNQ', 142307070910551, CAST(N'2021-07-07T15:30:25.510' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (99, N'x4KbzR1pqIMhemB1iTJ8sw', 142307070910551, CAST(N'2021-07-07T17:12:18.517' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (104, N'vzPEcyR0B04fZKt9UM2o-A', 142307070910551, CAST(N'2021-07-07T18:00:21.480' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (106, N'Bc5dosaX5o_PfChJ81lZeg', 177325484421189, CAST(N'2021-07-08T10:11:56.833' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (107, N'qZEv4UrbIjEszQ8EKMWVZw', 177325484421189, CAST(N'2021-07-08T10:14:33.167' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (117, N'E6K5VvCbHyvU3mSngUeLYg', 142307070910551, CAST(N'2021-07-08T15:42:22.360' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (118, N'XZqTIuibHrdQVop4agKfsg', 142307070910551, CAST(N'2021-07-08T15:46:22.640' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (119, N'_wm_ghmuS-pig2e3qVDfAw', 142307070910551, CAST(N'2021-07-08T15:46:24.103' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (140, N'dTWXRmyJ7e79mzGXDRj8eA', 177325484421189, CAST(N'2021-07-09T11:33:39.827' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (173, N'umbPxuXbsEQEylCTDrn7Nw', 177325484421189, CAST(N'2021-07-09T15:53:58.300' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (178, N'1meTukn0c5_Ewebu9UVMGA', 177325484421189, CAST(N'2021-07-09T16:06:25.610' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (192, N'qnMuiDuvjkP9jxfEA_poWw', 142307070910551, CAST(N'2021-07-09T16:38:57.407' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (193, N'4k7QdD664Ek1PVGSU0Vr5g', 177325484421189, CAST(N'2021-07-09T16:39:06.127' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (196, N'EWSbUzwAv37MIv0MC090bg', 142307070910551, CAST(N'2021-07-09T16:54:30.010' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (197, N'Hwm0NSUQbcKHiUfh7O-1iA', 177325484421189, CAST(N'2021-07-09T16:54:30.187' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (198, N'N9Mab7r9qmbhCQNtkkgABQ', 142307070910551, CAST(N'2021-07-09T16:55:31.870' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (199, N'nBv4YOuSb9NA43zpyJrqSg', 177325484421189, CAST(N'2021-07-09T16:55:32.147' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (200, N'yhL98YrNCu0-WJqdCHFYhA', 177325484421189, CAST(N'2021-07-09T16:57:39.543' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (201, N'n2HQaU0Smsc_JIqvWVaQgQ', 142307070910551, CAST(N'2021-07-09T16:57:39.543' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (202, N'cguk5Z7X4xKYbPk1RT-s-w', 142307070910551, CAST(N'2021-07-09T17:02:22.303' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (203, N'G4-hmKWs5stNWBDTG89zjQ', 177325484421189, CAST(N'2021-07-09T17:02:24.157' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (204, N'G2cOF26FoSGSklZqS10CSQ', 177325484421189, CAST(N'2021-07-09T17:05:26.580' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (205, N'rwge0nRqDXdUyM0NoyLI0w', 142307070910551, CAST(N'2021-07-09T17:05:30.730' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (206, N'MEuV9I27gnFDAOT9B6r0wg', 142307070910551, CAST(N'2021-07-09T17:08:21.847' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (207, N'kux6u9r9w0A6PApDMDZGug', 177325484421189, CAST(N'2021-07-09T17:08:23.183' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (208, N'qlB_GSTfOaVrs2hvYH3-Hg', 142307070910551, CAST(N'2021-07-09T17:09:00.703' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (209, N'VrW11zs7uYiLDFnFdeZgCg', 177325484421189, CAST(N'2021-07-09T17:09:00.637' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (210, N'_voQgvQY-Nm3sbpJxZz9FQ', 142307070910551, CAST(N'2021-07-09T17:10:18.827' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (211, N'en3Zi7AKzdMy2A7J-sqBew', 177325484421189, CAST(N'2021-07-09T17:10:19.147' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (212, N'vHFYLdPHP1bAh8o3vo-hGQ', 177325484421189, CAST(N'2021-07-09T17:12:21.127' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (213, N'TQQ-HNooLNQwHc1oOGIqQg', 142307070910551, CAST(N'2021-07-09T17:12:21.127' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (214, N'TRRhHbBcCe0gB5Gq3_UniQ', 142307070910551, CAST(N'2021-07-09T17:15:57.800' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (215, N'3EODzD0F0O9LqwFUCCWlVg', 177325484421189, CAST(N'2021-07-09T17:15:57.703' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (216, N'7bWKTmZl2Qpk6Qv7TvOFng', 142307070910551, CAST(N'2021-07-09T17:18:53.997' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (219, N'j2RL8NnCYAx31a0Oa0lUyg', 142307070910551, CAST(N'2021-07-09T17:44:31.827' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (220, N'hB5JGM0fDze8Gu8uwkATDg', 142307070910551, CAST(N'2021-07-09T17:46:31.550' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (245, N'GXzOPNNFm8V91-e0wkvVRQ', 142307070910551, CAST(N'2021-07-12T09:36:07.907' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (246, N'4m8pP_-xiFX0BLN-PWSI9Q', 142307070910551, CAST(N'2021-07-12T09:40:49.340' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (247, N'pUo_xj8t5g1SEh5GpXnqAg', 142307070910551, CAST(N'2021-07-12T09:45:17.930' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (250, N'y6mIEEO8BDPcVNtlhMTUxg', 177325484421189, CAST(N'2021-07-12T10:15:51.597' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (253, N'qfa5DAzj4b1J5zu-2nbUdQ', 177325484421189, CAST(N'2021-07-12T10:21:48.093' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (267, N'o1Z06gbVihWcSMZc6WOiDg', 177325484421189, CAST(N'2021-07-12T10:53:52.480' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (276, N'isqvpiiFw-1HsbuALAhUFg', 177325484421189, CAST(N'2021-07-12T11:25:14.907' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (292, N'mwrVx8ufkRDP_nEacNTFKg', 177325484421189, CAST(N'2021-07-12T13:46:45.663' AS DateTime), N'127.0.0.1', N'admin', N'郑国静', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (294, N'jrgEzlfsAjC7Ym2ugP3yQQ', 142307070910551, CAST(N'2021-07-12T16:06:05.043' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (295, N'bgFOsMz246d2C9mPJ1OJnQ', 142307070910551, CAST(N'2021-07-13T11:31:43.257' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (297, N'2cHvT2lzr2sr_afBTc0Png', 142307070910551, CAST(N'2021-07-13T11:37:14.840' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
GO
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (298, N'1DezwqgGsSeujbtw8tR6iQ', 142307070910551, CAST(N'2021-07-13T13:32:44.107' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (299, N'Uf03ylAM-iviEyeKgvRNmA', 142307070910551, CAST(N'2021-07-13T14:04:17.463' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (301, N'isUXuWDc31KQdGxLIikvnQ', 142307070910551, CAST(N'2021-07-13T14:10:11.573' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (302, N'vipoZLknKUH-Lme8VKgHyw', 142307070910551, CAST(N'2021-07-16T13:34:51.390' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (304, N'Jz456LbXoGQuI0TRUjnicg', 142307070910551, CAST(N'2021-07-16T13:50:52.783' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (305, N'5wbYxyTHo6izQDmmDSOqXg', 142307070910551, CAST(N'2021-07-16T14:54:16.240' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (317, N'lfCuqni-tveuWwrgBLdNcg', 142307070910551, CAST(N'2021-07-16T15:40:16.497' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (320, N'vmhuAEMWrHzEsi7psUdLWA', 142307070910551, CAST(N'2021-07-16T15:42:34.550' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (324, N'hBsoQllKmDsujgbL7sVPig', 142307070910551, CAST(N'2021-07-16T16:03:28.523' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (325, N'E8Fv9oDplf5fXd9CyTSHUg', 142307070910551, CAST(N'2021-07-16T16:12:33.217' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (331, N'pAfeoQ-VTpPHjKv7MbQUcg', 175624015269957, CAST(N'2021-07-16T18:06:47.210' AS DateTime), N'127.0.0.1', N'toudou@qq.com', N'tdadmin', 175624014975045)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (332, N'QaBskrKJ8LXEmnuIt8e0tQ', 142307070910551, CAST(N'2021-07-19T14:05:58.797' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (334, N'RQcXcIqQl5b4dClysnXwPg', 142307070910551, CAST(N'2021-07-19T14:15:49.397' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (364, N'18OXZEba_J-7hnBW-hdLrA', 182314279026757, CAST(N'2021-07-19T15:13:28.877' AS DateTime), N'127.0.0.1', N'zhangsan', N'张三', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (370, N'IssGLX49x-GVCCwAOlGSXA', 142307070910551, CAST(N'2021-07-19T17:09:51.117' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (372, N'WDh1f2-q51-ZhingVza5IQ', 142307070910551, CAST(N'2021-07-19T17:28:04.473' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (374, N'dUF0mlCxFfTmVnDbeU0TWw', 142307070910551, CAST(N'2021-07-19T17:49:08.440' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (375, N'FUvdLENiHgCxKg3xnpeqCA', 142307070910551, CAST(N'2021-07-19T17:51:00.063' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (377, N'Pz1bluUJmU_HC_gUKL6Ezw', 142307070910551, CAST(N'2021-07-19T17:52:23.863' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (378, N'wiyBYRgEuhKDW-IzFXEDrQ', 142307070910551, CAST(N'2021-07-19T17:55:21.940' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (383, N'uqzn3i_6Ppu033Ra8Ks1Uw', 142307070910551, CAST(N'2021-07-19T18:00:07.697' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (386, N'JY5gz8_M6RpLl0aE4HnbCQ', 142307070910551, CAST(N'2021-07-20T09:48:38.653' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (387, N'CnFw0lOrDo4DYkmUlC-unw', 142307070910551, CAST(N'2021-07-20T10:08:23.277' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (388, N'nJVJORYoAd2YbltHEISdeg', 142307070910551, CAST(N'2021-07-20T10:10:14.260' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (408, N'7jmXkPz-8FlEpaUP-n1gSg', 142307070910551, CAST(N'2021-07-20T11:20:46.843' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (417, N'hHhJOSfVMgMne1u1H8B-8A', 142307070910551, CAST(N'2021-07-20T15:37:24.427' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (419, N'-fRjFtl2mXUdtvdXPDtKXg', 142307070910551, CAST(N'2021-07-20T15:51:43.603' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (425, N'U1FckIbeKSnBUIPxrAHMEA', 142307070910551, CAST(N'2021-07-20T16:22:47.533' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (433, N'zTShVo5w1nDkFLNOguc-1w', 142307070910551, CAST(N'2021-07-20T17:08:38.810' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (434, N'wKkSl3bD5As5ELOAgyVVRg', 142307070910551, CAST(N'2021-07-20T17:10:50.997' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (435, N'doWrs4HRfBAqquRSIfZ_7Q', 142307070910551, CAST(N'2021-07-20T17:23:17.513' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (436, N'5fD2V95K7J188nplBiGsig', 142307070910551, CAST(N'2021-07-20T17:23:18.727' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (437, N'odNOVPLxAsh0X2doRGDG0A', 142307070910551, CAST(N'2021-07-20T17:26:10.570' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (438, N'YkifsiRHrMl3oURzNhFbbA', 142307070910551, CAST(N'2021-07-20T17:26:11.720' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (439, N'lzDzWGJD0THiqYmRvZtZcw', 142307070910551, CAST(N'2021-07-20T17:29:21.007' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (440, N'WGwAhXkKNBkx3ktf_njx5Q', 142307070910551, CAST(N'2021-07-20T17:29:21.713' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (454, N'lQG-W2o0ZTWDpCxJhAqhuQ', 142307070910551, CAST(N'2021-07-21T11:56:36.447' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (459, N'HNwFCuL9jnelYQyuoia5Dg', 142307070910551, CAST(N'2021-07-21T13:57:22.427' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (461, N'Rldrw9edq_ts7hI-0keizA', 142307070910551, CAST(N'2021-07-21T13:58:20.233' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (464, N'lRhgS2s0aoSPmRDYDITu2A', 142307070910551, CAST(N'2021-07-21T14:15:33.120' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (467, N'KQ--tNT0iCGdEtu0hin6wQ', 142307070910551, CAST(N'2021-07-21T14:32:36.890' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (478, N'n5odw5Uk0hjSf5KW_BOrwA', 142307070910551, CAST(N'2021-07-21T14:53:05.830' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (480, N'04NLSUKVQjOjDKP_6UjaDQ', 142307070910551, CAST(N'2021-07-21T15:06:01.307' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (482, N'vx3dMBMW5whHzIeaCOwDhA', 142307070910551, CAST(N'2021-07-21T15:11:13.900' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (483, N'GhZZtisIsEXh1tpVil9u_w', 142307070910551, CAST(N'2021-07-21T15:39:36.453' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (486, N'Ulgri0OOWOrr2QY-zK6KpQ', 142307070910551, CAST(N'2021-07-21T16:07:24.183' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (492, N'P589jF8cK9EYrw3lAQRJBg', 142307070910551, CAST(N'2021-07-21T16:31:39.573' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (509, N'1pv99DCr5o2Z4UvgjgNQZA', 142307070910551, CAST(N'2021-07-21T17:47:42.550' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (512, N'VTCrpD8ShIaE6q3IWH3X0w', 142307070910551, CAST(N'2021-07-21T17:59:25.827' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (515, N'3wRpTOg1gpkCqEXbA5GYXg', 142307070910551, CAST(N'2021-07-21T18:06:22.083' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (516, N'DsoCvauaq8BH2-EWIMXZDg', 142307070910551, CAST(N'2021-07-21T18:07:35.983' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (518, N'bYRFXNm0zkwVdxjcJWasnA', 142307070910551, CAST(N'2021-07-22T11:50:19.843' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (519, N'FiPw8GwdaZypp9DOcFAxDA', 142307070910551, CAST(N'2021-07-22T11:53:38.853' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (520, N'C_YYiyCEpPU8vKtcGjVbCQ', 142307070910551, CAST(N'2021-07-22T11:55:20.873' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (522, N'IHf-BxSP3K-yOEvJ0-7xmw', 142307070910551, CAST(N'2021-07-22T11:56:51.907' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (523, N'FZ8_IaAaopuzLg4bK7TR4g', 142307070910551, CAST(N'2021-07-22T11:58:42.293' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (524, N'oHy6FyBqYz2dC72NGcoVPA', 142307070910551, CAST(N'2021-07-22T12:01:45.170' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (525, N'MxqsxmG0R51t_dVpWjoqBQ', 142307070910551, CAST(N'2021-07-22T12:02:55.827' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (526, N'ObijEmjfoNfFZKTggbkIKg', 142307070910551, CAST(N'2021-07-22T12:04:06.827' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (527, N'o9AbVoww2hWZNdB_swqM0Q', 142307070910551, CAST(N'2021-07-22T13:31:32.867' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (528, N'tk1UpmM__MwndL8w-Zd5og', 142307070910551, CAST(N'2021-07-22T13:33:05.277' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (529, N'oEknfTIajexSooTMzwpuJw', 142307070910551, CAST(N'2021-07-22T13:35:30.933' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (530, N'686EaXN_jlc-sRZqBxsY8Q', 142307070910551, CAST(N'2021-07-22T13:38:09.857' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (531, N'fL1WrBtWHMDaGDiEWXJ5pw', 142307070910551, CAST(N'2021-07-22T13:40:57.350' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (532, N'Xg9SUJClrQ4NfPYdNPvOsw', 142307070910551, CAST(N'2021-07-22T13:42:50.783' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (533, N'jhw8vw1g8ami4MsHRChsgQ', 142307070910551, CAST(N'2021-07-22T13:44:12.827' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (534, N'h5OSCeA6VPG7FldmPt5TQQ', 142307070910551, CAST(N'2021-07-22T13:49:51.870' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (535, N'w9ESejgH2MgR3TSOA7UEOQ', 142307070910551, CAST(N'2021-07-22T13:52:30.667' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (536, N'7xrmHJDU8ZOOSe8YIaARDQ', 142307070910551, CAST(N'2021-07-22T13:56:10.337' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (537, N'UtJJJhFKVq0vB2FWjTZwcA', 142307070910551, CAST(N'2021-07-22T14:06:57.833' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (542, N'tk1pJ65Wfhjq3-vWlXvENg', 175624015269957, CAST(N'2021-07-22T15:01:49.867' AS DateTime), N'127.0.0.1', N'toudou@qq.com', N'tdadmin', 175624014975045)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (546, N'iK30XtBvdVgrtrOLgJbnfQ', 142307070910551, CAST(N'2021-07-22T17:39:21.113' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (548, N'elzrJYxw1cb1DTVlTaTDaA', 177325484421189, CAST(N'2021-07-22T17:46:06.513' AS DateTime), N'127.0.0.1', N'admin', N'管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (555, N'yTABgzAedL2ulmR3nbKEyQ', 142307070910551, CAST(N'2021-07-23T14:54:03.393' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (556, N'aNM5xnX23g-yAYoLnCFzFQ', 142307070910551, CAST(N'2021-07-23T16:05:45.143' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (566, N'z7UJw8fFYGdbCZnTne84cw', 142307070910551, CAST(N'2021-07-23T17:50:29.710' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (567, N'eu_Y4LkEX3oav4maPBg7cg', 142307070910551, CAST(N'2021-07-23T17:52:52.877' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (568, N'BXFOmhF241TZaKsM3C9H1A', 142307070910551, CAST(N'2021-07-23T18:00:59.673' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (571, N'EFLLGjMK2r3DGq8whdZgcQ', 142307070910551, CAST(N'2021-07-23T18:02:55.820' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (573, N'Wi1n9FnaftDxS56kwoqkWg', 142307070910551, CAST(N'2021-07-23T18:03:47.243' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (575, N'OEHbC9FTu1Q67Zo2c_1R-A', 142307070910551, CAST(N'2021-07-23T18:05:24.353' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (582, N'vVS3xTmDXynDGLXPEvsiQQ', 142307070910551, CAST(N'2021-07-29T14:19:07.357' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (670, N'izr6i2f1w_sjqU37h0lHvw', 142307070910551, CAST(N'2021-08-06T11:36:28.833' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (675, N'6ddeUcv0Yo7q3nJhOAQfRQ', 142307070910551, CAST(N'2021-08-19T23:14:50.863' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (677, N'TflhcawF3oQvVIUSzPkAJg', 177325484421189, CAST(N'2021-08-19T23:17:56.440' AS DateTime), N'127.0.0.1', N'admin', N'管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (680, N'RtyD5vxtGEubeKVAuntQkA', 177325484421189, CAST(N'2021-08-19T23:23:45.413' AS DateTime), N'127.0.0.1', N'admin', N'管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (681, N'kyNSgg06umrHk48RS4Gv9A', 177325484421189, CAST(N'2021-08-19T23:40:52.890' AS DateTime), N'127.0.0.1', N'admin', N'管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (693, N'RK2Xnw8MLb6Tv8D0emfaiQ', 142307070910551, CAST(N'2021-08-31T23:20:37.733' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (696, N'zazW2kvW9ngyxdMPBZAlyA', 142307070910551, CAST(N'2021-08-31T23:25:16.277' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (700, N'dLtI4RKKYCxGEzkckjX-IA', 142307070910551, CAST(N'2021-09-03T23:53:12.673' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (702, N'DpxX2OQdSYZbYsh64ATDIQ', 142307070910551, CAST(N'2022-04-16T00:42:27.557' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (704, N'uy_Nc8s34wyCUEyMmleWGw', 142307070910551, CAST(N'2022-04-16T00:43:20.930' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (705, N'kfVbymHTuTeK44Hzv1cQ2A', 142307070910551, CAST(N'2022-04-16T00:56:02.840' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (706, N'QAfj8TfbfeqLxe_vFeMzag', 142307070910551, CAST(N'2022-04-16T00:56:03.253' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (707, N'cgax8vv-hcXqENOIQxCQtg', 142307070910551, CAST(N'2022-04-16T01:03:13.007' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (708, N'xMcE-HK0ckFkFpVfRRDjAA', 142307070910551, CAST(N'2022-04-16T01:03:15.493' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (711, N'u8wMneXNdAnOjlmIrH2VoA', 142307070910551, CAST(N'2022-04-16T01:05:30.583' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (713, N'wZF4OBJ-TLcXf-LWHNvEWA', 142307070910551, CAST(N'2022-04-16T01:07:14.480' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (717, N'mfKiSjBz5hRJx47xBOfvAQ', 142307070910551, CAST(N'2022-04-27T11:06:25.917' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (719, N'b94B_xGxZQDYu6KqMF3_UQ', 142307070910551, CAST(N'2022-04-27T11:09:07.267' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
GO
INSERT [dbo].[sys_online_user] ([Id], [ConnectionId], [UserId], [LastTime], [LastLoginIp], [Account], [Name], [TenantId]) VALUES (728, N'oN7yZTThvDx-GxudX-ntZQ', 142307070910551, CAST(N'2022-04-27T13:53:34.943' AS DateTime), N'127.0.0.1', N'superAdmin', N'超级管理员', 142307070918780)
SET IDENTITY_INSERT [dbo].[sys_online_user] OFF
INSERT [dbo].[sys_org] ([Id], [Pid], [Pids], [Name], [Code], [Contacts], [Tel], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (175624015089733, 0, N'[0],', N'土豆新车', N'1', N'tdadmin', NULL, 0, NULL, 0, CAST(N'2021-06-30T16:35:58.830' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 175624014975045)
INSERT [dbo].[sys_org] ([Id], [Pid], [Pids], [Name], [Code], [Contacts], [Tel], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (177325089079365, 0, N'[0],', N'系统机构', N'SystemOrg', NULL, NULL, 1, NULL, 0, CAST(N'2021-07-05T11:57:40.097' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 142307070918780)
INSERT [dbo].[sys_org] ([Id], [Pid], [Pids], [Name], [Code], [Contacts], [Tel], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (182313953165381, 177325089079365, N'[0],[177325089079365],', N'机构1', N'1', NULL, NULL, 100, NULL, 0, CAST(N'2021-07-19T14:17:24.493' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 142307070918780)
INSERT [dbo].[sys_org] ([Id], [Pid], [Pids], [Name], [Code], [Contacts], [Tel], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (182314008641605, 182313953165381, N'[0],[177325089079365],[182313953165381],', N'机构2', N'2', NULL, NULL, 100, NULL, 0, CAST(N'2021-07-19T14:17:38.037' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 142307070918780)
INSERT [dbo].[sys_org] ([Id], [Pid], [Pids], [Name], [Code], [Contacts], [Tel], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (278024843092037, 0, N'[0],', N'租户1', N'1', N'租户1管理员', NULL, 0, NULL, 0, CAST(N'2022-04-16T01:06:00.980' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 278024843046981)
INSERT [dbo].[sys_pos] ([Id], [Name], [Code], [Sort], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (177325394366533, N'系统职位', N'SystemPos', 1, NULL, 0, CAST(N'2021-07-05T11:58:54.630' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 142307070918780)
INSERT [dbo].[sys_role] ([Id], [Name], [Code], [Sort], [DataScopeType], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId], [RoleType]) VALUES (175624015192133, N'系统管理员', N'1', 0, 1, NULL, 0, CAST(N'2021-06-30T16:35:58.853' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 175624014975045, 1)
INSERT [dbo].[sys_role] ([Id], [Name], [Code], [Sort], [DataScopeType], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId], [RoleType]) VALUES (175631636172869, N'财务', N'cw', 100, 1, NULL, 0, CAST(N'2021-06-30T17:06:59.447' AS DateTime), NULL, 175624015269957, N'toudou@qq.com', NULL, NULL, 0, 175624014975045, 0)
INSERT [dbo].[sys_role] ([Id], [Name], [Code], [Sort], [DataScopeType], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId], [RoleType]) VALUES (175633246363717, N'普通用户', N'pt', 100, 1, NULL, 0, CAST(N'2021-06-30T17:13:32.560' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 142307070918780, 0)
INSERT [dbo].[sys_role] ([Id], [Name], [Code], [Sort], [DataScopeType], [Remark], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId], [RoleType]) VALUES (278024843124805, N'系统管理员', N'1', 0, 1, NULL, 0, CAST(N'2022-04-16T01:06:00.987' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 278024843046981, 1)
INSERT [dbo].[sys_role_data_scope] ([SysRoleId], [SysOrgId]) VALUES (278024843124805, 278024843092037)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307000914633)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307000914633)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307000914633)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910560)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910560)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910561)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910561)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910562)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910562)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910563)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910563)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910563)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910564)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910564)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910564)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910565)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910565)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910565)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910566)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910566)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910566)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910567)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910567)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910567)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910568)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910568)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910568)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910569)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910569)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910569)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910570)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910570)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910570)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910571)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910571)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910571)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910572)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910572)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910572)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910573)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910573)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910573)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910574)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910574)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910574)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910575)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910575)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910575)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910576)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910576)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910576)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910577)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910577)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910577)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910578)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910578)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910578)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910579)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910579)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910579)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910580)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910580)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910580)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910581)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910581)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910581)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910582)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910582)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910582)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910583)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910583)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910583)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910584)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910584)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910584)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910585)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910585)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910585)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910586)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910586)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910586)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910587)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910587)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910587)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910588)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910588)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910588)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910589)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910589)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910589)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910590)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910590)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910590)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070910591)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070910591)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070910591)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070911739)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070911739)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070911740)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070911740)
GO
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070911741)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070911741)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914629)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914629)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914629)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914630)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914630)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914630)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914631)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914631)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914631)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914632)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914632)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914632)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914633)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914633)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914634)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914634)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914635)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914635)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914636)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914636)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914637)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914637)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914638)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914638)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914639)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914639)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914640)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914640)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914641)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914641)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914642)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914642)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914643)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914643)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914644)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914644)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914645)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914645)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914646)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914646)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914647)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914647)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914648)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914648)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914648)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914649)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914649)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914649)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914650)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914650)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914651)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914651)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914651)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914652)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914652)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914652)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914653)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914653)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914653)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914654)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914654)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914654)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914655)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914655)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914655)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914656)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914656)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914656)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914657)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914657)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914657)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914658)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914658)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914658)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914659)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914659)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914659)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914660)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914660)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914660)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070914661)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914661)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914661)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914662)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914662)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914663)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914663)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914664)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914664)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914665)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914665)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914666)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914666)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914667)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914667)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914668)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914668)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914669)
GO
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914669)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914670)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914670)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914671)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914671)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914672)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914672)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914673)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914673)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914674)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914674)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914675)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914675)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914676)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914676)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914677)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914677)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914678)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914678)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914679)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914679)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914680)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914680)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914681)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914681)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914682)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914682)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914683)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914683)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914684)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914684)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914685)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914685)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914686)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914686)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070914687)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070914687)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918725)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918725)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918726)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918726)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918727)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918727)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918728)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918728)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918729)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918729)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918730)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918730)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918731)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918731)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918732)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918732)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918733)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918733)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918734)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918734)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918735)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918735)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918736)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918736)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918737)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918737)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918738)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918738)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918739)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918739)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918740)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918740)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918741)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918741)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918742)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918742)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918743)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918743)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918744)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918744)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918745)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918745)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918746)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918746)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918746)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918747)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918747)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918747)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918748)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918748)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918748)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918749)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918749)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918749)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918750)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918750)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918750)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918751)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918751)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918751)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918752)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918752)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918752)
GO
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918753)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918753)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918753)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918754)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918754)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918754)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175624015192133, 142307070918755)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918755)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918755)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918756)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918756)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918757)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918757)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918758)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918758)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918759)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918759)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918760)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918760)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918761)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918761)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918762)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918762)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918763)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918763)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918764)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918764)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918765)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918765)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918766)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918766)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918767)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918767)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918768)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918768)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918769)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918769)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918770)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918770)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918771)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918771)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918772)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918772)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918773)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918773)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918774)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918774)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918775)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918775)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918776)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070918776)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918782)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070918783)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922821)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922822)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922823)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922824)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922825)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922826)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922827)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922870)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922874)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070922874)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922875)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070922875)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 142307070922876)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 142307070922876)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 178075287240773)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 178079567294533)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182612191891525)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182692422213701)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182692650123333)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182692815732805)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182693142773829)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182693266526277)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182693372485701)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182699700703301)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 182699700703301)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182700299632709)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 182700299632709)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182700412936261)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 182700412936261)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182700585140293)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 182700585140293)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182700864315461)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 182700864315461)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 182701004218437)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 182701004218437)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 183425655615557)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 183425947672645)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 183426282242117)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 183426282242117)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (175633246363717, 183426519642181)
INSERT [dbo].[sys_role_menu] ([SysRoleId], [SysMenuId]) VALUES (278024843124805, 183426519642181)
INSERT [dbo].[sys_tenant] ([Id], [Name], [AdminName], [Host], [Email], [Phone], [Connection], [Schema], [Remark], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantType]) VALUES (142307070918780, N'系统租户', N'SystemAdmin', NULL, N'SystemAdmin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[sys_tenant] ([Id], [Name], [AdminName], [Host], [Email], [Phone], [Connection], [Schema], [Remark], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantType]) VALUES (175624014975045, N'土豆新车', N'tdadmin', NULL, N'toudou@qq.com', NULL, NULL, NULL, NULL, CAST(N'2021-06-30T16:35:58.803' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 0)
INSERT [dbo].[sys_tenant] ([Id], [Name], [AdminName], [Host], [Email], [Phone], [Connection], [Schema], [Remark], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantType]) VALUES (278024843046981, N'租户1', N'租户1管理员', NULL, N'zuhutest', NULL, NULL, NULL, NULL, CAST(N'2022-04-16T01:06:00.967' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 0)
INSERT [dbo].[sys_timer] ([Id], [JobName], [DoOnce], [StartNow], [ExecuteType], [Interval], [Cron], [TimerType], [RequestUrl], [RequestParameters], [Headers], [RequestType], [Remark], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910556, N'百度api', 0, 0, 1, 5, NULL, 0, N'https://www.baidu.com', NULL, NULL, 2, N'接口API', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[sys_timer] ([Id], [JobName], [DoOnce], [StartNow], [ExecuteType], [Interval], [Cron], [TimerType], [RequestUrl], [RequestParameters], [Headers], [RequestType], [Remark], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910557, N'异常日志', 0, 0, 1, 1, NULL, 0, N'LogJobWorker/DoLogEx', NULL, NULL, 0, N'', NULL, CAST(N'2021-07-22T17:49:29.370' AS DateTime), 142307070910551, N'superAdmin', 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_timer] ([Id], [JobName], [DoOnce], [StartNow], [ExecuteType], [Interval], [Cron], [TimerType], [RequestUrl], [RequestParameters], [Headers], [RequestType], [Remark], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910558, N'操作日志', 0, 0, 1, 1, NULL, 0, N'LogJobWorker/DoLogOp', NULL, NULL, 0, N'', NULL, CAST(N'2021-07-22T17:49:31.363' AS DateTime), 142307070910551, N'superAdmin', 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_timer] ([Id], [JobName], [DoOnce], [StartNow], [ExecuteType], [Interval], [Cron], [TimerType], [RequestUrl], [RequestParameters], [Headers], [RequestType], [Remark], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted]) VALUES (142307070910559, N'访问日志', 0, 0, 1, 1, NULL, 0, N'LogJobWorker/DoLogVis', NULL, NULL, 0, N'', NULL, CAST(N'2021-07-22T17:49:33.267' AS DateTime), 142307070910551, N'superAdmin', 142307070910551, N'superAdmin', 0)
INSERT [dbo].[sys_user] ([Id], [Account], [Password], [NickName], [Name], [Avatar], [Birthday], [Sex], [Email], [Phone], [Tel], [LastLoginIp], [LastLoginTime], [AdminType], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (142307070910551, N'superAdmin', N'e10adc3949ba59abbe56e057f20f883e', N'superAdmin', N'超级管理员', N'188632919339077', CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, NULL, N'18020030720', NULL, N'127.0.0.1', CAST(N'2022-04-27T11:13:50.760' AS DateTime), 1, 0, NULL, CAST(N'2021-08-06T10:49:21.047' AS DateTime), NULL, NULL, 142307070910551, N'superAdmin', 0, 142307070918780)
INSERT [dbo].[sys_user] ([Id], [Account], [Password], [NickName], [Name], [Avatar], [Birthday], [Sex], [Email], [Phone], [Tel], [LastLoginIp], [LastLoginTime], [AdminType], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (175624015269957, N'toudou@qq.com', N'e10adc3949ba59abbe56e057f20f883e', N'tdadmin', N'tdadmin', NULL, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0, N'toudou@qq.com', NULL, NULL, N'127.0.0.1', CAST(N'2022-04-16T00:42:43.103' AS DateTime), 2, 0, CAST(N'2021-06-30T16:35:58.873' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 175624014975045)
INSERT [dbo].[sys_user] ([Id], [Account], [Password], [NickName], [Name], [Avatar], [Birthday], [Sex], [Email], [Phone], [Tel], [LastLoginIp], [LastLoginTime], [AdminType], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (177325484421189, N'admin', N'e10adc3949ba59abbe56e057f20f883e', N'admin', N'管理员', NULL, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, NULL, N'15959110752', NULL, N'0.0.0.1', CAST(N'2021-08-19T23:55:06.200' AS DateTime), 0, 0, CAST(N'2021-07-05T11:59:16.617' AS DateTime), CAST(N'2021-08-19T23:10:52.907' AS DateTime), 142307070910551, N'superAdmin', 142307070910551, N'superAdmin', 0, 142307070918780)
INSERT [dbo].[sys_user] ([Id], [Account], [Password], [NickName], [Name], [Avatar], [Birthday], [Sex], [Email], [Phone], [Tel], [LastLoginIp], [LastLoginTime], [AdminType], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (182314279026757, N'zhangsan', N'e10adc3949ba59abbe56e057f20f883e', N'张三', N'张三', NULL, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 1, NULL, N'15959110751', NULL, N'127.0.0.1', CAST(N'2021-07-19T15:13:27.183' AS DateTime), 0, 0, CAST(N'2021-07-19T14:18:44.050' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 142307070918780)
INSERT [dbo].[sys_user] ([Id], [Account], [Password], [NickName], [Name], [Avatar], [Birthday], [Sex], [Email], [Phone], [Tel], [LastLoginIp], [LastLoginTime], [AdminType], [Status], [CreatedTime], [UpdatedTime], [CreatedUserId], [CreatedUserName], [UpdatedUserId], [UpdatedUserName], [IsDeleted], [TenantId]) VALUES (278024843153477, N'zuhutest', N'e10adc3949ba59abbe56e057f20f883e', N'租户1管理员', N'租户1管理员', NULL, CAST(N'1753-01-01T00:00:00.000' AS DateTime), 0, N'zuhutest', NULL, NULL, N'127.0.0.1', CAST(N'2022-04-16T01:06:31.343' AS DateTime), 2, 0, CAST(N'2022-04-16T01:06:00.993' AS DateTime), NULL, 142307070910551, N'superAdmin', NULL, NULL, 0, 278024843046981)
INSERT [dbo].[sys_user_data_scope] ([SysUserId], [SysOrgId]) VALUES (175624015269957, 175624015089733)
INSERT [dbo].[sys_user_data_scope] ([SysUserId], [SysOrgId]) VALUES (278024843153477, 278024843092037)
INSERT [dbo].[sys_user_role] ([SysUserId], [SysRoleId]) VALUES (175624015269957, 175624015192133)
INSERT [dbo].[sys_user_role] ([SysUserId], [SysRoleId]) VALUES (177325484421189, 175633246363717)
INSERT [dbo].[sys_user_role] ([SysUserId], [SysRoleId]) VALUES (182314279026757, 175633246363717)
INSERT [dbo].[sys_user_role] ([SysUserId], [SysRoleId]) VALUES (278024843153477, 278024843124805)
/****** Object:  Index [IX_sys_dict_data_TypeId]    Script Date: 2022/4/27 18:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_sys_dict_data_TypeId] ON [dbo].[sys_dict_data]
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sys_emp_ext_org_pos_SysOrgId]    Script Date: 2022/4/27 18:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_sys_emp_ext_org_pos_SysOrgId] ON [dbo].[sys_emp_ext_org_pos]
(
	[SysOrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sys_emp_ext_org_pos_SysPosId]    Script Date: 2022/4/27 18:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_sys_emp_ext_org_pos_SysPosId] ON [dbo].[sys_emp_ext_org_pos]
(
	[SysPosId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sys_emp_pos_SysPosId]    Script Date: 2022/4/27 18:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_sys_emp_pos_SysPosId] ON [dbo].[sys_emp_pos]
(
	[SysPosId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sys_role_data_scope_SysOrgId]    Script Date: 2022/4/27 18:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_sys_role_data_scope_SysOrgId] ON [dbo].[sys_role_data_scope]
(
	[SysOrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sys_role_menu_SysMenuId]    Script Date: 2022/4/27 18:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_sys_role_menu_SysMenuId] ON [dbo].[sys_role_menu]
(
	[SysMenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sys_user_data_scope_SysOrgId]    Script Date: 2022/4/27 18:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_sys_user_data_scope_SysOrgId] ON [dbo].[sys_user_data_scope]
(
	[SysOrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sys_user_role_SysRoleId]    Script Date: 2022/4/27 18:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_sys_user_role_SysRoleId] ON [dbo].[sys_user_role]
(
	[SysRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sys_dict_data]  WITH CHECK ADD  CONSTRAINT [FK_sys_dict_data_sys_dict_type_TypeId] FOREIGN KEY([TypeId])
REFERENCES [dbo].[sys_dict_type] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_dict_data] CHECK CONSTRAINT [FK_sys_dict_data_sys_dict_type_TypeId]
GO
ALTER TABLE [dbo].[sys_emp_ext_org_pos]  WITH CHECK ADD  CONSTRAINT [FK_sys_emp_ext_org_pos_sys_emp_SysEmpId] FOREIGN KEY([SysEmpId])
REFERENCES [dbo].[sys_emp] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_emp_ext_org_pos] CHECK CONSTRAINT [FK_sys_emp_ext_org_pos_sys_emp_SysEmpId]
GO
ALTER TABLE [dbo].[sys_emp_ext_org_pos]  WITH CHECK ADD  CONSTRAINT [FK_sys_emp_ext_org_pos_sys_org_SysOrgId] FOREIGN KEY([SysOrgId])
REFERENCES [dbo].[sys_org] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_emp_ext_org_pos] CHECK CONSTRAINT [FK_sys_emp_ext_org_pos_sys_org_SysOrgId]
GO
ALTER TABLE [dbo].[sys_emp_ext_org_pos]  WITH CHECK ADD  CONSTRAINT [FK_sys_emp_ext_org_pos_sys_pos_SysPosId] FOREIGN KEY([SysPosId])
REFERENCES [dbo].[sys_pos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_emp_ext_org_pos] CHECK CONSTRAINT [FK_sys_emp_ext_org_pos_sys_pos_SysPosId]
GO
ALTER TABLE [dbo].[sys_emp_pos]  WITH CHECK ADD  CONSTRAINT [FK_sys_emp_pos_sys_emp_SysEmpId] FOREIGN KEY([SysEmpId])
REFERENCES [dbo].[sys_emp] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_emp_pos] CHECK CONSTRAINT [FK_sys_emp_pos_sys_emp_SysEmpId]
GO
ALTER TABLE [dbo].[sys_emp_pos]  WITH CHECK ADD  CONSTRAINT [FK_sys_emp_pos_sys_pos_SysPosId] FOREIGN KEY([SysPosId])
REFERENCES [dbo].[sys_pos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_emp_pos] CHECK CONSTRAINT [FK_sys_emp_pos_sys_pos_SysPosId]
GO
ALTER TABLE [dbo].[sys_role_data_scope]  WITH CHECK ADD  CONSTRAINT [FK_sys_role_data_scope_sys_org_SysOrgId] FOREIGN KEY([SysOrgId])
REFERENCES [dbo].[sys_org] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_role_data_scope] CHECK CONSTRAINT [FK_sys_role_data_scope_sys_org_SysOrgId]
GO
ALTER TABLE [dbo].[sys_role_data_scope]  WITH CHECK ADD  CONSTRAINT [FK_sys_role_data_scope_sys_role_SysRoleId] FOREIGN KEY([SysRoleId])
REFERENCES [dbo].[sys_role] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_role_data_scope] CHECK CONSTRAINT [FK_sys_role_data_scope_sys_role_SysRoleId]
GO
ALTER TABLE [dbo].[sys_role_menu]  WITH CHECK ADD  CONSTRAINT [FK_sys_role_menu_sys_menu_SysMenuId] FOREIGN KEY([SysMenuId])
REFERENCES [dbo].[sys_menu] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_role_menu] CHECK CONSTRAINT [FK_sys_role_menu_sys_menu_SysMenuId]
GO
ALTER TABLE [dbo].[sys_role_menu]  WITH CHECK ADD  CONSTRAINT [FK_sys_role_menu_sys_role_SysRoleId] FOREIGN KEY([SysRoleId])
REFERENCES [dbo].[sys_role] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_role_menu] CHECK CONSTRAINT [FK_sys_role_menu_sys_role_SysRoleId]
GO
ALTER TABLE [dbo].[sys_user_data_scope]  WITH CHECK ADD  CONSTRAINT [FK_sys_user_data_scope_sys_org_SysOrgId] FOREIGN KEY([SysOrgId])
REFERENCES [dbo].[sys_org] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_user_data_scope] CHECK CONSTRAINT [FK_sys_user_data_scope_sys_org_SysOrgId]
GO
ALTER TABLE [dbo].[sys_user_data_scope]  WITH CHECK ADD  CONSTRAINT [FK_sys_user_data_scope_sys_user_SysUserId] FOREIGN KEY([SysUserId])
REFERENCES [dbo].[sys_user] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_user_data_scope] CHECK CONSTRAINT [FK_sys_user_data_scope_sys_user_SysUserId]
GO
ALTER TABLE [dbo].[sys_user_role]  WITH CHECK ADD  CONSTRAINT [FK_sys_user_role_sys_role_SysRoleId] FOREIGN KEY([SysRoleId])
REFERENCES [dbo].[sys_role] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_user_role] CHECK CONSTRAINT [FK_sys_user_role_sys_role_SysRoleId]
GO
ALTER TABLE [dbo].[sys_user_role]  WITH CHECK ADD  CONSTRAINT [FK_sys_user_role_sys_user_SysUserId] FOREIGN KEY([SysUserId])
REFERENCES [dbo].[sys_user] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_user_role] CHECK CONSTRAINT [FK_sys_user_role_sys_user_SysUserId]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'PId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父ID列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'PIds'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文档类型:文件、文件夹' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'DocumentType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件后缀' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'FileSuffix'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件大小kb' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'FileSizeKb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'存储后的文件名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'FileObjectName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'FilePath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标签' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'Label'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文档表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'documentation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否默认激活' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'Active'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统应用表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_app'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'AuthorName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否移除表前缀' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'TablePrefix'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'GenerateType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库表名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'TableName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命名空间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'NameSpace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'业务名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'BusName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单应用分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'MenuApplication'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'MenuPid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代码生成表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代码生成主表ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'CodeGenId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库字段名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'ColumnName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字段描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'ColumnComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'.NET数据类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'NetType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作用类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'EffectType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外键实体名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'FkEntityName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外键显示字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'FkColumnName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外键显示字段.NET类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'FkColumnNetType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字典Code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'DictTypeCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列表是否缩进' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'WhetherRetract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否必填' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'WhetherRequired'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是查询条件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'QueryWhether'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'查询方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'QueryType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列表显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'WhetherTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增改' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'WhetherAddUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'ColumnKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库中类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'DataType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否通用字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'WhetherCommon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代码生成字段配置表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_code_gen_config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'属性值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'Value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是系统参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'SysFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'常量所属分类的编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'GroupCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参数配置表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字典类型Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'TypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'Value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字典值表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_data'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字典类型表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_dict_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp', @level2type=N'COLUMN',@level2name=N'JobNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机构Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp', @level2type=N'COLUMN',@level2name=N'OrgId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机构名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp', @level2type=N'COLUMN',@level2name=N'OrgName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp_ext_org_pos', @level2type=N'COLUMN',@level2name=N'SysEmpId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机构Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp_ext_org_pos', @level2type=N'COLUMN',@level2name=N'SysOrgId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职位Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp_ext_org_pos', @level2type=N'COLUMN',@level2name=N'SysPosId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工附属机构职位表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp_ext_org_pos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp_pos', @level2type=N'COLUMN',@level2name=N'SysEmpId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职位Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp_pos', @level2type=N'COLUMN',@level2name=N'SysPosId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工职位表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_emp_pos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件存储位置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'FileLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件仓库' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'FileBucket'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'FileOriginName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件后缀' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'FileSuffix'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件大小kb' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'FileSizeKb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件大小信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'FileSizeInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'存储到bucket的名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'FileObjectName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'存储路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'FilePath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件信息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_file'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit', @level2type=N'COLUMN',@level2name=N'TableName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit', @level2type=N'COLUMN',@level2name=N'ColumnName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit', @level2type=N'COLUMN',@level2name=N'NewValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'旧值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit', @level2type=N'COLUMN',@level2name=N'OldValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit', @level2type=N'COLUMN',@level2name=N'Operate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审计日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_audit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'ClassName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'方法名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'MethodName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'异常名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'ExceptionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'异常信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'ExceptionMsg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'异常源' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'ExceptionSource'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'堆栈信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'StackTrace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参数对象' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'ParamsObj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'异常时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex', @level2type=N'COLUMN',@level2name=N'ExceptionTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'异常日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_ex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否执行成功' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Success'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'具体消息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浏览器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Browser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作系统' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Os'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'ClassName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'方法名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'MethodName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'ReqMethod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Param'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返回结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Result'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'耗时' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'ElapsedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'OpTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_op'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否执行成功' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'Success'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'具体消息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'Message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'Ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浏览器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'Browser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作系统' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'Os'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'VisType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'VisTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'访问日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_log_vis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Pid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父Ids' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Pids'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Icon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路由地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Router'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组件地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Component'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Permission'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应用分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Application'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'打开方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'OpenType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否可见' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Visible'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内链地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'重定向地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Redirect'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Weight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_menu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'Content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布人Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'PublicUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布人姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'PublicUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布机构Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'PublicOrgId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布机构名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'PublicOrgName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'PublicTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'撤回时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'CancelTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'通知公告表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'通知公告Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice_user', @level2type=N'COLUMN',@level2name=N'NoticeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice_user', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'阅读时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice_user', @level2type=N'COLUMN',@level2name=N'ReadTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice_user', @level2type=N'COLUMN',@level2name=N'ReadStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'通知公告用户表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_notice_user'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UUID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Uuid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Token' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'AccessToken'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'NickName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'头像' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Avatar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'位置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户网址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Blog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所在公司' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Company'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户来源' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Source'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oauth登录用户表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_oauth_user'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线用户表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_online_user'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Pid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父Ids' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Pids'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Contacts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'租户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org', @level2type=N'COLUMN',@level2name=N'TenantId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组织机构表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_org'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'租户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos', @level2type=N'COLUMN',@level2name=N'TenantId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职位表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_pos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据范围类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'DataScopeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'租户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role', @level2type=N'COLUMN',@level2name=N'TenantId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role_data_scope', @level2type=N'COLUMN',@level2name=N'SysRoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机构Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role_data_scope', @level2type=N'COLUMN',@level2name=N'SysOrgId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色数据范围表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role_data_scope'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role_menu', @level2type=N'COLUMN',@level2name=N'SysRoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role_menu', @level2type=N'COLUMN',@level2name=N'SysMenuId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色菜单表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_role_menu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'AdminName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'Host'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库连接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'Connection'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'架构' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'Schema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'租户表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_tenant'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'JobName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'只执行一次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'DoOnce'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'立即执行' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'StartNow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'执行类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'ExecuteType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'间隔时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'Interval'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cron表达式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'Cron'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'定时器类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'TimerType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求url' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'RequestUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'RequestParameters'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Headers' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'Headers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'RequestType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'定时任务表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_timer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'NickName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'头像' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Avatar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生日' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别-男_1、女_2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Sex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后登录IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'LastLoginIp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后登录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'LastLoginTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员类型-超级管理员_1、非管理员_2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'AdminType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态-正常_0、停用_1、删除_2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'CreatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'UpdatedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'CreatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'CreatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'UpdatedUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'UpdatedUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'软删除标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'租户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user', @level2type=N'COLUMN',@level2name=N'TenantId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user_data_scope', @level2type=N'COLUMN',@level2name=N'SysUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机构Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user_data_scope', @level2type=N'COLUMN',@level2name=N'SysOrgId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户数据范围表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user_data_scope'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user_role', @level2type=N'COLUMN',@level2name=N'SysUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user_role', @level2type=N'COLUMN',@level2name=N'SysRoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户角色表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sys_user_role'
GO
USE [master]
GO
ALTER DATABASE [Magic] SET  READ_WRITE 
GO
