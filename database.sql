USE [master]
GO
/****** Object:  Database [ReChat]    Script Date: 03.06.2022 21:15:25 ******/
CREATE DATABASE [ReChat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ReChat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ReChat.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ReChat_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ReChat_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ReChat] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ReChat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ReChat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ReChat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ReChat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ReChat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ReChat] SET ARITHABORT OFF 
GO
ALTER DATABASE [ReChat] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ReChat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ReChat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ReChat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ReChat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ReChat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ReChat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ReChat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ReChat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ReChat] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ReChat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ReChat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ReChat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ReChat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ReChat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ReChat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ReChat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ReChat] SET RECOVERY FULL 
GO
ALTER DATABASE [ReChat] SET  MULTI_USER 
GO
ALTER DATABASE [ReChat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ReChat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ReChat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ReChat] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ReChat] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ReChat', N'ON'
GO
ALTER DATABASE [ReChat] SET QUERY_STORE = OFF
GO
USE [ReChat]
GO
/****** Object:  Table [dbo].[DlgInfo]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DlgInfo](
	[dialog_id] [nvarchar](25) NOT NULL,
	[lastTimeMsg] [int] NOT NULL,
	[nameOfChat] [nvarchar](25) NOT NULL,
	[typeOfDlg] [int] NOT NULL,
 CONSTRAINT [PK_UserDlgExt] PRIMARY KEY CLUSTERED 
(
	[dialog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FriendsTable]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FriendsTable](
	[tagSenderFrnd] [nvarchar](8) NOT NULL,
	[tagReceiverFrnd] [nvarchar](8) NOT NULL,
	[nameFrnd] [nvarchar](20) NOT NULL,
	[status] [smallint] NOT NULL,
 CONSTRAINT [PK_FriendsTable] PRIMARY KEY CLUSTERED 
(
	[tagSenderFrnd] ASC,
	[tagReceiverFrnd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GenderInfo]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenderInfo](
	[idGender] [int] NOT NULL,
	[nameGender] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_GenderInfo] PRIMARY KEY CLUSTERED 
(
	[idGender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InfoUsers]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InfoUsers](
	[tagUser] [nvarchar](8) NOT NULL,
	[nickUser] [nvarchar](20) NOT NULL,
	[isVisible] [bit] NOT NULL,
	[isAvatar] [bit] NOT NULL,
	[isVisionData] [int] NOT NULL,
	[gender] [int] NOT NULL,
	[birthday] [nvarchar](10) NOT NULL,
	[socialStatus] [nvarchar](50) NOT NULL,
	[country] [nvarchar](30) NOT NULL,
	[dateRegistration] [date] NOT NULL,
	[aboutMe] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_InfoUsers_1] PRIMARY KEY CLUSTERED 
(
	[tagUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MsgDlgTable]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MsgDlgTable](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dialog_id] [nvarchar](25) NOT NULL,
	[sender] [nvarchar](8) NOT NULL,
	[typeMsg] [nvarchar](10) NOT NULL,
	[textMsg] [nvarchar](max) NOT NULL,
	[timeCreated] [int] NOT NULL,
 CONSTRAINT [PK_MsgDlgTable] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypesOfDialogs]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypesOfDialogs](
	[id_type] [int] NOT NULL,
	[name_type] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_TypesOfDialogs] PRIMARY KEY CLUSTERED 
(
	[id_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDlgData]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDlgData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dialog_id] [nvarchar](25) NOT NULL,
	[tagUser] [nvarchar](8) NOT NULL,
	[enteredTime] [int] NOT NULL,
	[countMsg] [int] NOT NULL,
	[rang] [int] NOT NULL,
 CONSTRAINT [PK_UserDlgData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersData]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersData](
	[loginUser] [nvarchar](20) NOT NULL,
	[passUser] [nvarchar](32) NOT NULL,
	[tagUser] [nvarchar](8) NOT NULL,
	[deviceToken] [nvarchar](255) NULL,
 CONSTRAINT [PK_UsersData] PRIMARY KEY CLUSTERED 
(
	[tagUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisionData]    Script Date: 03.06.2022 21:15:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisionData](
	[idVisionData] [int] NOT NULL,
	[forClass] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_VisionData] PRIMARY KEY CLUSTERED 
(
	[idVisionData] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'CHAT#1bb471b4::6177dd9e', 0, N'CHAT#1bb471b4::6177dd9e', 0)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'CHAT#41f7edc3::794fd179', 1652811146, N'CHAT#41f7edc3::794fd179', 0)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'CHAT#58eb2a14::87185a92', 1650135595, N'CHAT#58eb2a14::87185a92', 0)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'CHAT#6177dd9e::87185a92', 1651855051, N'CHAT#6177dd9e::87185a92', 0)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'CHAT#794fd179::58eb2a14', 0, N'CHAT#794fd179::58eb2a14', 0)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'CHAT#794fd179::87185a92', 0, N'CHAT#794fd179::87185a92', 0)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'CHAT#87185a92::1bb471b4', 0, N'CHAT#87185a92::1bb471b4', 0)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'CHAT#cf27c26f::87185a92', 1653262978, N'CHAT#cf27c26f::87185a92', 0)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'GROUP#0', 1653259812, N'GLOBAL CHAT', 1)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'GROUP#G1651178040', 1651836825, N'ggchat', 1)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'GROUP#G1651844705', 1652810973, N'групповой чат', 1)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'GROUP#G1651854470', 1652729971, N'gg', 1)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'GROUP#G1651854481', 1651854481, N'djdjdj', 1)
INSERT [dbo].[DlgInfo] ([dialog_id], [lastTimeMsg], [nameOfChat], [typeOfDlg]) VALUES (N'GROUP#G1653333565', 1653333565, N'беседка', 1)
GO
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'41f7edc3', N'794fd179', N'dim1000127', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'41f7edc3', N'87185a92', N'timon021', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'58eb2a14', N'794fd179', N'dim1000127', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'58eb2a14', N'87185a92', N'timon021', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'6b6efde9', N'87185a92', N'timon021', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'785f10df', N'87185a92', N'timon021', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'794fd179', N'41f7edc3', N'web', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'794fd179', N'58eb2a14', N'ex', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'794fd179', N'87185a92', N'timon021', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'87185a92', N'41f7edc3', N'web', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'87185a92', N'58eb2a14', N'ex', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'87185a92', N'6b6efde9', N'timon', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'87185a92', N'785f10df', N'keklick', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'87185a92', N'794fd179', N'dim1000127', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'87185a92', N'cf27c26f', N'Полина', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'87185a92', N'fae78724', N'exam', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'cf27c26f', N'87185a92', N'timon021', 2)
INSERT [dbo].[FriendsTable] ([tagSenderFrnd], [tagReceiverFrnd], [nameFrnd], [status]) VALUES (N'fae78724', N'87185a92', N'timon021', 2)
GO
INSERT [dbo].[GenderInfo] ([idGender], [nameGender]) VALUES (0, N'UNKNOWN   ')
INSERT [dbo].[GenderInfo] ([idGender], [nameGender]) VALUES (1, N'MALE      ')
INSERT [dbo].[GenderInfo] ([idGender], [nameGender]) VALUES (2, N'FEMALE    ')
INSERT [dbo].[GenderInfo] ([idGender], [nameGender]) VALUES (3, N'OTHER     ')
GO
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'12c05ece', N'Ristly', 1, 0, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'1bb471b4', N'Громозев', 1, 1, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'41f7edc3', N'web', 1, 0, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'58eb2a14', N'ex', 1, 1, 0, 3, N'15.08.2019', N'newKeker', N'спб', CAST(N'2022-04-20' AS Date), N'второй акк')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'6177dd9e', N'Idas.exe', 1, 1, 0, 1, N'11.12.2001', N'холост', N'Россия', CAST(N'2022-04-20' AS Date), N'Программист на все руки')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'6b6efde9', N'timon', 1, 0, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'785f10df', N'keklick', 1, 0, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'794fd179', N'dim1000127', 1, 0, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'87185a92', N'timon021', 1, 1, 1, 1, N'16.05.2002', N'Студент', N'Россия ', CAST(N'2022-04-20' AS Date), N'разраб, Хех 🙃')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'bc4c5fef', N'exam2', 0, 0, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'c0125c30', N'sam', 1, 0, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'cf27c26f', N'Полина', 0, 1, 0, 2, N'', N'пишу диплом', N'Казахстан', CAST(N'2022-05-22' AS Date), N'туц туц туц')
INSERT [dbo].[InfoUsers] ([tagUser], [nickUser], [isVisible], [isAvatar], [isVisionData], [gender], [birthday], [socialStatus], [country], [dateRegistration], [aboutMe]) VALUES (N'fae78724', N'exam', 1, 0, 0, 0, N'', N'', N'', CAST(N'2022-04-20' AS Date), N'')
GO
SET IDENTITY_INSERT [dbo].[MsgDlgTable] ON 

INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1, N'GROUP#0', N'87185a92', N'TEXT', N'hello', 1644597693)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (2, N'GROUP#0', N'87185a92', N'IMAGE', N'1644597711740', 1644597711)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (3, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'qwe', 1644683313)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (4, N'GROUP#0', N'58eb2a14', N'TEXT', N'qwe', 1644684225)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (5, N'GROUP#0', N'58eb2a14', N'TEXT', N'123', 1644684687)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (6, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'er', 1644684700)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (7, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'123', 1644684743)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (8, N'GROUP#0', N'58eb2a14', N'TEXT', N'1', 1644685003)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (9, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'kek', 1644685101)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (10, N'GROUP#0', N'87185a92', N'TEXT', N'швлал', 1646567190)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (11, N'GROUP#0', N'87185a92', N'TEXT', N'луттв', 1646567191)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (12, N'GROUP#0', N'87185a92', N'TEXT', N'оцттв', 1646567191)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (13, N'GROUP#0', N'87185a92', N'TEXT', N'ттута', 1646567192)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (14, N'GROUP#0', N'87185a92', N'TEXT', N'ьбцдв', 1646567193)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (15, N'GROUP#0', N'87185a92', N'TEXT', N'иика', 1646567195)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (16, N'GROUP#0', N'87185a92', N'TEXT', N'ььута', 1646567196)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (17, N'GROUP#0', N'87185a92', N'TEXT', N'ьтуа', 1646567197)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (18, N'GROUP#0', N'87185a92', N'TEXT', N'kek', 1646577002)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (19, N'GROUP#0', N'87185a92', N'TEXT', N'ghtrk', 1646577073)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (20, N'GROUP#0', N'87185a92', N'TEXT', N'sdf', 1646577160)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (21, N'GROUP#0', N'87185a92', N'TEXT', N'qw', 1646577249)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (22, N'GROUP#0', N'87185a92', N'TEXT', N'fgh', 1646577296)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (23, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'йй', 1646577717)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (24, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'привет', 1646577720)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (25, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'как дела', 1646577763)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (26, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'что делаешь?', 1646577780)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (27, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'юхууу', 1646577793)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (28, N'GROUP#0', N'87185a92', N'TEXT', N'сообщение в глобал', 1646577799)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (29, N'GROUP#0', N'58eb2a14', N'TEXT', N'привет', 1646577819)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (30, N'GROUP#0', N'87185a92', N'IMAGE', N'1646577836849', 1646577837)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (31, N'GROUP#0', N'87185a92', N'IMAGE', N'1646655847566', 1646655846)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (32, N'CHAT#58eb2a14::87185a92', N'87185a92', N'IMAGE', N'1646655864816', 1646655863)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (33, N'CHAT#58eb2a14::87185a92', N'87185a92', N'IMAGE', N'1646656094754', 1646656093)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (34, N'CHAT#58eb2a14::87185a92', N'87185a92', N'IMAGE', N'1646761760876', 1646761761)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (36, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'IMAGE', N'1646762468358', 1646762468)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (37, N'GROUP#0', N'58eb2a14', N'IMAGE', N'1646762477583', 1646762477)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (41, N'GROUP#0', N'58eb2a14', N'TEXT', N'hehe', 1647091212)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (42, N'GROUP#0', N'87185a92', N'TEXT', N'haha', 1647091225)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (43, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'ну да', 1647091240)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (44, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'ку всем', 1647888808)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (46, N'GROUP#0', N'794fd179', N'IMAGE', N'1648230714010', 1648230717)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (47, N'GROUP#0', N'794fd179', N'IMAGE', N'1648230745184', 1648230748)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (48, N'GROUP#0', N'87185a92', N'IMAGE', N'1648230759152', 1648230760)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (49, N'GROUP#0', N'58eb2a14', N'TEXT', N'hehe', 1649353132)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (50, N'GROUP#0', N'58eb2a14', N'TEXT', N'heheh', 1649500022)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (51, N'GROUP#0', N'58eb2a14', N'TEXT', N'haha', 1649500059)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (52, N'GROUP#0', N'58eb2a14', N'TEXT', N'ex', 1649500089)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (53, N'GROUP#0', N'58eb2a14', N'TEXT', N'ggwp
dsfsdfsd', 1649500113)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (54, N'GROUP#0', N'58eb2a14', N'TEXT', N'dsfds', 1649500151)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (55, N'GROUP#0', N'58eb2a14', N'TEXT', N'fghfhg', 1649500152)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (56, N'GROUP#0', N'58eb2a14', N'TEXT', N'fghfghf', 1649500153)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (57, N'GROUP#0', N'58eb2a14', N'TEXT', N'fghf', 1649500155)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (58, N'GROUP#0', N'58eb2a14', N'TEXT', N'ывавыаыва', 1649502772)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (59, N'GROUP#0', N'58eb2a14', N'TEXT', N'ййййй', 1649502776)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (60, N'GROUP#0', N'58eb2a14', N'TEXT', N'ццццц', 1649502777)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (61, N'GROUP#0', N'58eb2a14', N'TEXT', N'ууууу', 1649502779)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (62, N'GROUP#0', N'58eb2a14', N'TEXT', N'asd', 1649503188)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (63, N'GROUP#0', N'58eb2a14', N'TEXT', N'hehe', 1649503602)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (64, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'qq', 1649503696)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (65, N'GROUP#0', N'58eb2a14', N'TEXT', N'check', 1649503894)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (66, N'GROUP#0', N'58eb2a14', N'TEXT', N'check2', 1649503902)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (67, N'GROUP#0', N'58eb2a14', N'TEXT', N'check3', 1649505532)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (68, N'GROUP#0', N'58eb2a14', N'TEXT', N'check4', 1649505553)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (69, N'GROUP#0', N'58eb2a14', N'TEXT', N'check5', 1649505696)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (70, N'GROUP#0', N'58eb2a14', N'TEXT', N'check6', 1649505752)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (71, N'GROUP#0', N'58eb2a14', N'TEXT', N'check7', 1649505885)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (72, N'GROUP#0', N'58eb2a14', N'TEXT', N'check8', 1649505943)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (73, N'GROUP#0', N'58eb2a14', N'TEXT', N'check9', 1649506146)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (74, N'GROUP#0', N'58eb2a14', N'TEXT', N'check10', 1649506168)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (75, N'GROUP#0', N'58eb2a14', N'TEXT', N'check11', 1649506175)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (76, N'GROUP#0', N'58eb2a14', N'TEXT', N'check12', 1649506184)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (77, N'GROUP#0', N'58eb2a14', N'TEXT', N'check1', 1649513129)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (78, N'GROUP#0', N'58eb2a14', N'TEXT', N'check2', 1649513178)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (79, N'GROUP#0', N'58eb2a14', N'TEXT', N'check3', 1649884306)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (80, N'GROUP#0', N'58eb2a14', N'TEXT', N'check time', 1649885959)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (81, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'check 123', 1649887842)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (82, N'GROUP#0', N'58eb2a14', N'TEXT', N'check 4', 1649887851)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (83, N'GROUP#0', N'87185a92', N'TEXT', N'чек5', 1650042194)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (84, N'GROUP#0', N'87185a92', N'TEXT', N'чек6', 1650042209)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (85, N'GROUP#0', N'87185a92', N'TEXT', N'чек7', 1650042224)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (86, N'GROUP#0', N'87185a92', N'TEXT', N'чек8', 1650042810)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (87, N'GROUP#0', N'87185a92', N'TEXT', N'чек9', 1650042817)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (88, N'GROUP#0', N'87185a92', N'TEXT', N'чек10', 1650042840)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (89, N'GROUP#0', N'87185a92', N'TEXT', N'чек11', 1650042847)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (90, N'GROUP#0', N'87185a92', N'TEXT', N'чек12', 1650043041)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (91, N'GROUP#0', N'87185a92', N'TEXT', N'чек13', 1650043549)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (92, N'GROUP#0', N'87185a92', N'TEXT', N'чек14', 1650043669)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (93, N'GROUP#0', N'87185a92', N'TEXT', N'чек15', 1650043697)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (94, N'GROUP#0', N'87185a92', N'TEXT', N'чек16', 1650043710)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (95, N'GROUP#0', N'87185a92', N'TEXT', N'чек17', 1650044057)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (96, N'GROUP#0', N'87185a92', N'TEXT', N'чек18', 1650044132)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (97, N'GROUP#0', N'87185a92', N'TEXT', N'чек19', 1650044159)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (98, N'GROUP#0', N'87185a92', N'TEXT', N'чек20', 1650044501)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (99, N'GROUP#0', N'87185a92', N'TEXT', N'чек21', 1650044531)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (100, N'GROUP#0', N'87185a92', N'TEXT', N'чек22', 1650044561)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (101, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек1', 1650045038)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (102, N'GROUP#0', N'87185a92', N'TEXT', N'чек23', 1650045225)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (103, N'GROUP#0', N'87185a92', N'TEXT', N'чек24', 1650045251)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (104, N'GROUP#0', N'87185a92', N'TEXT', N'чек25', 1650045272)
GO
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (105, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек2', 1650045308)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (106, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек3', 1650045335)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (107, N'GROUP#0', N'87185a92', N'TEXT', N'чек26', 1650045479)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (108, N'GROUP#0', N'87185a92', N'TEXT', N'чек27', 1650045492)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (109, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек4', 1650045508)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (110, N'GROUP#0', N'87185a92', N'TEXT', N'чек28', 1650047741)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (111, N'GROUP#0', N'87185a92', N'TEXT', N'чек29', 1650048202)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (112, N'GROUP#0', N'87185a92', N'TEXT', N'чек30', 1650048373)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (113, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек5', 1650048515)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (114, N'GROUP#0', N'87185a92', N'TEXT', N'чек31', 1650048558)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (115, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек6', 1650048672)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (116, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек7', 1650048891)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (117, N'GROUP#0', N'87185a92', N'TEXT', N'чек32', 1650049065)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (118, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек8', 1650049217)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (119, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек9', 1650049278)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (120, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек10', 1650049330)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (121, N'GROUP#0', N'87185a92', N'TEXT', N'чек33', 1650049652)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (122, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек11', 1650049696)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (123, N'GROUP#0', N'87185a92', N'TEXT', N'чек34', 1650050098)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (124, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек12', 1650050165)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (125, N'GROUP#0', N'87185a92', N'TEXT', N'чек35', 1650050472)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (126, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек13', 1650050696)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (127, N'GROUP#0', N'87185a92', N'TEXT', N'чек36', 1650050916)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (128, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек14', 1650059205)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (129, N'GROUP#0', N'87185a92', N'TEXT', N'чек37', 1650059788)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (130, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек15', 1650059872)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (131, N'GROUP#0', N'58eb2a14', N'TEXT', N'чек38', 1650059889)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (132, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'чек16', 1650059992)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (133, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'чек17', 1650134862)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (134, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек18', 1650134912)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (135, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'чек19', 1650135026)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (136, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'чек20', 1650135245)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (137, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'чек21', 1650135409)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (138, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'чек22', 1650135541)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (139, N'CHAT#58eb2a14::87185a92', N'87185a92', N'TEXT', N'чек23', 1650135552)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (140, N'GROUP#0', N'58eb2a14', N'TEXT', N'чек39', 1650135583)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (141, N'GROUP#0', N'87185a92', N'TEXT', N'чек40', 1650135588)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (142, N'CHAT#58eb2a14::87185a92', N'58eb2a14', N'TEXT', N'чек24', 1650135595)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (143, N'GROUP#0', N'58eb2a14', N'TEXT', N'чек41', 1650135609)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (144, N'GROUP#0', N'87185a92', N'TEXT', N'чек42', 1650226322)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (145, N'GROUP#0', N'58eb2a14', N'TEXT', N'чек43', 1650226343)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (146, N'GROUP#0', N'87185a92', N'TEXT', N'чек44', 1650226633)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (147, N'GROUP#0', N'58eb2a14', N'TEXT', N'чек45', 1650226639)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (172, N'GROUP#0', N'87185a92', N'TEXT', N'ооо', 1650399376)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (176, N'GROUP#G1651178040', N'87185a92', N'TEXT', N'проверка группы в чатгг', 1651836825)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (177, N'GROUP#G1651844705', N'87185a92', N'TEXT', N'хехе', 1651844722)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (178, N'GROUP#G1651844705', N'58eb2a14', N'IMAGE', N'1651844738694', 1651844738)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (180, N'GROUP#G1651854470', N'58eb2a14', N'TEXT', N'gg', 1651854495)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (181, N'GROUP#G1651854470', N'58eb2a14', N'IMAGE', N'1651854509953', 1651854510)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (182, N'GROUP#G1651854470', N'794fd179', N'IMAGE', N'1651854509379', 1651854511)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (183, N'GROUP#G1651854470', N'58eb2a14', N'TEXT', N'xjjdjd', 1651854528)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (184, N'GROUP#G1651854470', N'58eb2a14', N'TEXT', N'bdbdb', 1651854529)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (185, N'GROUP#G1651854470', N'794fd179', N'TEXT', N'ggg', 1651854530)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (186, N'GROUP#G1651854470', N'794fd179', N'TEXT', N'we dhhsbsb', 1651854533)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (187, N'GROUP#G1651854470', N'794fd179', N'TEXT', N'bshshdj', 1651854534)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (188, N'GROUP#G1651854470', N'794fd179', N'TEXT', N'dhshhs', 1651854535)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (189, N'GROUP#G1651854470', N'794fd179', N'TEXT', N'bshss', 1651854536)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (190, N'GROUP#G1651854470', N'794fd179', N'TEXT', N'hs', 1651854536)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (191, N'GROUP#G1651854470', N'794fd179', N'TEXT', N'sbs', 1651854536)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (192, N'GROUP#G1651854470', N'794fd179', N'TEXT', N'bs', 1651854537)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (193, N'GROUP#G1651854470', N'794fd179', N'TEXT', N's', 1651854538)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (194, N'GROUP#G1651854470', N'794fd179', N'IMAGE', N'1651854575153', 1651854576)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (195, N'GROUP#G1651854470', N'58eb2a14', N'IMAGE', N'1651854608694', 1651854608)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (196, N'GROUP#0', N'6177dd9e', N'TEXT', N'емае', 1651854898)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (197, N'CHAT#6177dd9e::87185a92', N'6177dd9e', N'IMAGE', N'1651854917856', 1651854918)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (198, N'CHAT#6177dd9e::87185a92', N'6177dd9e', N'TEXT', N'намальна, изменений мое почтение', 1651855051)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1176, N'GROUP#0', N'87185a92', N'TEXT', N'лооощ', 1652729963)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1177, N'GROUP#G1651854470', N'87185a92', N'TEXT', N'ггвп', 1652729971)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1178, N'GROUP#G1651844705', N'87185a92', N'IMAGE', N'1652810970180', 1652810973)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1180, N'GROUP#0', N'cf27c26f', N'TEXT', N'чек100001', 1653259770)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1181, N'GROUP#0', N'87185a92', N'TEXT', N'ау', 1653259772)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1182, N'GROUP#0', N'87185a92', N'IMAGE', N'1653259809086', 1653259809)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1183, N'GROUP#0', N'cf27c26f', N'IMAGE', N'1653259812568', 1653259812)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1185, N'CHAT#cf27c26f::87185a92', N'cf27c26f', N'TEXT', N'чыхпых', 1653259898)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1187, N'CHAT#cf27c26f::87185a92', N'87185a92', N'TEXT', N'а может быть ты', 1653259907)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1188, N'CHAT#cf27c26f::87185a92', N'87185a92', N'IMAGE', N'1653259912463', 1653259912)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1189, N'CHAT#cf27c26f::87185a92', N'cf27c26f', N'IMAGE', N'1653259913539', 1653259913)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1190, N'CHAT#cf27c26f::87185a92', N'cf27c26f', N'TEXT', N'да ты', 1653259925)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1191, N'CHAT#cf27c26f::87185a92', N'87185a92', N'IMAGE', N'1653259929405', 1653259929)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1192, N'CHAT#cf27c26f::87185a92', N'cf27c26f', N'TEXT', N'дада', 1653259935)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1194, N'CHAT#cf27c26f::87185a92', N'cf27c26f', N'TEXT', N'приветики', 1653262949)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1195, N'CHAT#cf27c26f::87185a92', N'cf27c26f', N'TEXT', N'как дела', 1653262953)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1196, N'CHAT#cf27c26f::87185a92', N'cf27c26f', N'IMAGE', N'1653262961657', 1653262961)
INSERT [dbo].[MsgDlgTable] ([id], [dialog_id], [sender], [typeMsg], [textMsg], [timeCreated]) VALUES (1197, N'CHAT#cf27c26f::87185a92', N'cf27c26f', N'TEXT', N'это ты', 1653262978)
SET IDENTITY_INSERT [dbo].[MsgDlgTable] OFF
GO
INSERT [dbo].[TypesOfDialogs] ([id_type], [name_type]) VALUES (0, N'CHAT')
INSERT [dbo].[TypesOfDialogs] ([id_type], [name_type]) VALUES (1, N'GROUP')
GO
SET IDENTITY_INSERT [dbo].[UserDlgData] ON 

INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1, N'CHAT#1bb471b4::6177dd9e', N'1bb471b4', 1642003440, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (3, N'CHAT#1bb471b4::6177dd9e', N'6177dd9e', 1642003440, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (4, N'CHAT#58eb2a14::87185a92', N'58eb2a14', 1644507420, 14, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (5, N'CHAT#58eb2a14::87185a92', N'87185a92', 1644507420, 27, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (6, N'CHAT#6177dd9e::87185a92', N'6177dd9e', 1636621920, 2, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (7, N'CHAT#6177dd9e::87185a92', N'87185a92', 1636621920, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (8, N'CHAT#794fd179::58eb2a14', N'58eb2a14', 1647626040, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (9, N'CHAT#794fd179::58eb2a14', N'794fd179', 1647626040, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (10, N'CHAT#794fd179::87185a92', N'794fd179', 1636386780, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (11, N'CHAT#794fd179::87185a92', N'87185a92', 1636386780, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (12, N'CHAT#87185a92::1bb471b4', N'1bb471b4', 1642003500, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (13, N'CHAT#87185a92::1bb471b4', N'87185a92', 1642003500, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (17, N'GROUP#0', N'12c05ece', 1636386780, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (18, N'GROUP#0', N'1bb471b4', 1636386780, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (19, N'GROUP#0', N'41f7edc3', 1644964740, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (20, N'GROUP#0', N'58eb2a14', 1642864920, 61, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (21, N'GROUP#0', N'6177dd9e', 1636386780, 103, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (22, N'GROUP#0', N'6b6efde9', 1636386780, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (23, N'GROUP#0', N'785f10df', 1636386780, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (24, N'GROUP#0', N'794fd179', 1628697180, 99, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (25, N'GROUP#0', N'87185a92', 1628697180, 49, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (26, N'GROUP#0', N'bc4c5fef', 1644574500, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (27, N'GROUP#0', N'c0125c30', 1636386780, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (28, N'GROUP#0', N'fae78724', 1644573780, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (128, N'GROUP#G1651178040', N'87185a92', 1651178040, 0, 3)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (129, N'GROUP#G1651178040', N'58eb2a14', 1651178040, 1, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (131, N'GROUP#G1651178040', N'41f7edc3', 1651251742, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (133, N'GROUP#G1651178040', N'6b6efde9', 1651251742, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (140, N'GROUP#G1651844705', N'41f7edc3', 1651844705, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (141, N'GROUP#G1651844705', N'58eb2a14', 1651844705, 1, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (144, N'GROUP#G1651844705', N'87185a92', 1651844705, 1, 3)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (151, N'GROUP#G1651854470', N'794fd179', 1651854470, 5, 3)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (152, N'GROUP#G1651854470', N'58eb2a14', 1651854470, 11, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (153, N'GROUP#G1651854470', N'87185a92', 1651854470, 16, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (154, N'GROUP#G1651854481', N'58eb2a14', 1651854481, 0, 3)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (155, N'GROUP#G1651854481', N'87185a92', 1651854481, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (156, N'GROUP#G1651854481', N'794fd179', 1651854481, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1141, N'CHAT#41f7edc3::794fd179', N'41f7edc3', 1652811146, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1142, N'CHAT#41f7edc3::794fd179', N'794fd179', 1652811146, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1143, N'GROUP#0', N'cf27c26f', 1653259569, 108, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1144, N'CHAT#cf27c26f::87185a92', N'cf27c26f', 1653259875, 10, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1145, N'CHAT#cf27c26f::87185a92', N'87185a92', 1653259875, 4, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1146, N'GROUP#G1653333565', N'87185a92', 1653333565, 0, 3)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1147, N'GROUP#G1653333565', N'cf27c26f', 1653333565, 0, 1)
INSERT [dbo].[UserDlgData] ([id], [dialog_id], [tagUser], [enteredTime], [countMsg], [rang]) VALUES (1148, N'GROUP#G1653333565', N'794fd179', 1653333565, 0, 1)
SET IDENTITY_INSERT [dbo].[UserDlgData] OFF
GO
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'qwerty', N'0+j8g7PohqDcKqmEWlIVvw==', N'12c05ece', NULL)
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'sAp', N'EmWnrvF0c/A+P0UY2SwtnQ==', N'1bb471b4', NULL)
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'web', N'JWel7JcF63rCyYQDPgYYnQ==', N'41f7edc3', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiNDFmN2VkYzMiLCJ0aW1lRW50cnkiOiIyMDIyLTA1LTE3VDIxOjExOjMxLjAwNDU5NjcrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.n9FqTC89e-rdxipAMc-IzNMnw_f92lybvInL4G5OZ8s')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'ex', N'VNVKEmp4O8nLqMBhNxNpQw==', N'58eb2a14', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiNThlYjJhMTQiLCJ0aW1lRW50cnkiOiIyMDIyLTA1LTA2VDE2OjM5OjI1LjY5MjEwNTErMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.5Y90pK_FeMoDHFbT2IiGpsaA95LdST5FFr-ZqLe3e0k')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'Anton', N'3ZMkeiR8VZ4QUClvDshqIw==', N'6177dd9e', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiNjE3N2RkOWUiLCJ0aW1lRW50cnkiOiIyMDIyLTA1LTA2VDE5OjM0OjQzLjIyMzA4MDcrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.Dv55eWW5OyEgfZBjPlNClkTMQclUa2vf37wYrO1xj-U')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'danil', N'F+V2npBLBECBaLMiYn9cfA==', N'6b6efde9', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiNmI2ZWZkZTkiLCJ0aW1lRW50cnkiOiIyMDIyLTA0LTI5VDE5OjU2OjQ2LjA1MjM3MzMrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.DApHrM9IGXYd7wDHx7YHTe5Kls7BhR7MYNmD9_zv6r0')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'keklick', N'ICy5YqxZB1uWSwcVLSNLcA==', N'785f10df', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiNzg1ZjEwZGYiLCJ0aW1lRW50cnkiOiIyMDIyLTA0LTI5VDE5OjU5OjE4Ljg3OTk3NTUrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.vTKpUpg0ThpRHAb39jiimAuRd3quqpdLUgGatL0-bZ0')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'dim', N'ZRK9Q9nKpuAsmQsKgmUtyg==', N'794fd179', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiNzk0ZmQxNzkiLCJ0aW1lRW50cnkiOiIyMDIyLTA1LTA2VDE5OjIyOjQxLjcyMzk3NzgrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.TDnBU84eFJg6wDMNdPCWWF9GEMlByY5WvDhYyYv3Hv0')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'danil2', N'wgrU12/pd1mqJ6DJm/9nEA==', N'87185a92', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiODcxODVhOTIiLCJ0aW1lRW50cnkiOiIyMDIyLTA1LTIzVDIxOjE2OjM0LjM2MjYzMjUrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.6MmSJ0GgMee0aDl7qK0vH2bu3pwpFjNjVtVO-zDoQTs')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'exam2', N'SXx8GnQHb7RiOmGghVWJ5g==', N'bc4c5fef', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiYmM0YzVmZWYiLCJ0aW1lRW50cnkiOiIyMDIyLTA0LTE4VDE3OjIxOjUzLjIzNTY2MDUrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.PDs4xAisYoEEgfmV9sKt4OBuD0TjVnLd3S5B_NbloRo')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'sam', N'gdyb21LQTcIANtvYMT7QVQ==', N'c0125c30', NULL)
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'polina4k', N'gdyb21LQTcIANtvYMT7QVQ==', N'cf27c26f', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiY2YyN2MyNmYiLCJ0aW1lRW50cnkiOiIyMDIyLTA1LTIzVDAxOjQ2OjM2LjAxNDI0MzMrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.qZUZmXFXElP4fe5Y1Iardt0vGoYBcrZSfY1P3lFhKd8')
INSERT [dbo].[UsersData] ([loginUser], [passUser], [tagUser], [deviceToken]) VALUES (N'exam', N'ZUgW+F3+IRVnTnEVx9HqUQ==', N'fae78724', N'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0YWdVc2VyIjoiZmFlNzg3MjQiLCJ0aW1lRW50cnkiOiIyMDIyLTA0LTI5VDE5OjU3OjUwLjcyMzI3NTMrMDM6MDAiLCJpc3MiOiJTZXJ2ZXJfUmVDaGF0In0.dFYhzhzbd2i7bRylkCeoo60sj2WtY0dpx03dkjXe2Eo')
GO
INSERT [dbo].[VisionData] ([idVisionData], [forClass]) VALUES (0, N'ALL')
INSERT [dbo].[VisionData] ([idVisionData], [forClass]) VALUES (1, N'FRIENDS')
INSERT [dbo].[VisionData] ([idVisionData], [forClass]) VALUES (2, N'NOBODY')
GO
ALTER TABLE [dbo].[InfoUsers] ADD  CONSTRAINT [DF_InfoUsers_isVisionData]  DEFAULT ((0)) FOR [isVisionData]
GO
ALTER TABLE [dbo].[InfoUsers] ADD  CONSTRAINT [DF_InfoUsers_gender]  DEFAULT ((0)) FOR [gender]
GO
ALTER TABLE [dbo].[UserDlgData] ADD  CONSTRAINT [DF_UserDlgData_rang]  DEFAULT ((1)) FOR [rang]
GO
ALTER TABLE [dbo].[DlgInfo]  WITH CHECK ADD  CONSTRAINT [FK_UserDlgExt_TypesOfDialogs] FOREIGN KEY([typeOfDlg])
REFERENCES [dbo].[TypesOfDialogs] ([id_type])
GO
ALTER TABLE [dbo].[DlgInfo] CHECK CONSTRAINT [FK_UserDlgExt_TypesOfDialogs]
GO
ALTER TABLE [dbo].[FriendsTable]  WITH CHECK ADD  CONSTRAINT [FK_FriendsTable_InfoUsers] FOREIGN KEY([tagSenderFrnd])
REFERENCES [dbo].[InfoUsers] ([tagUser])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FriendsTable] CHECK CONSTRAINT [FK_FriendsTable_InfoUsers]
GO
ALTER TABLE [dbo].[InfoUsers]  WITH CHECK ADD  CONSTRAINT [FK_InfoUsers_GenderInfo] FOREIGN KEY([gender])
REFERENCES [dbo].[GenderInfo] ([idGender])
GO
ALTER TABLE [dbo].[InfoUsers] CHECK CONSTRAINT [FK_InfoUsers_GenderInfo]
GO
ALTER TABLE [dbo].[InfoUsers]  WITH CHECK ADD  CONSTRAINT [FK_InfoUsers_VisionData] FOREIGN KEY([isVisionData])
REFERENCES [dbo].[VisionData] ([idVisionData])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InfoUsers] CHECK CONSTRAINT [FK_InfoUsers_VisionData]
GO
ALTER TABLE [dbo].[MsgDlgTable]  WITH CHECK ADD  CONSTRAINT [FK_MsgDlgTable_DlgInfo] FOREIGN KEY([dialog_id])
REFERENCES [dbo].[DlgInfo] ([dialog_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MsgDlgTable] CHECK CONSTRAINT [FK_MsgDlgTable_DlgInfo]
GO
ALTER TABLE [dbo].[UserDlgData]  WITH CHECK ADD  CONSTRAINT [FK_UserDlgData_DlgInfo] FOREIGN KEY([dialog_id])
REFERENCES [dbo].[DlgInfo] ([dialog_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserDlgData] CHECK CONSTRAINT [FK_UserDlgData_DlgInfo]
GO
ALTER TABLE [dbo].[UserDlgData]  WITH CHECK ADD  CONSTRAINT [FK_UserDlgData_InfoUsers] FOREIGN KEY([tagUser])
REFERENCES [dbo].[InfoUsers] ([tagUser])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserDlgData] CHECK CONSTRAINT [FK_UserDlgData_InfoUsers]
GO
ALTER TABLE [dbo].[UsersData]  WITH CHECK ADD  CONSTRAINT [FK_UsersData_InfoUsers] FOREIGN KEY([tagUser])
REFERENCES [dbo].[InfoUsers] ([tagUser])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsersData] CHECK CONSTRAINT [FK_UsersData_InfoUsers]
GO
USE [master]
GO
ALTER DATABASE [ReChat] SET  READ_WRITE 
GO
