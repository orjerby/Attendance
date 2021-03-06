USE [master]
GO
/****** Object:  Database [site05]    Script Date: 27/01/2019 22:39:51 ******/
CREATE DATABASE [site05]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'site05_data', FILENAME = N'C:\Program Files (x86)\Plesk\Databases\MSSQL\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\site05_1e32edfe87bb44f18504b712082605db.mdf' , SIZE = 6400KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'site05_log', FILENAME = N'C:\Program Files (x86)\Plesk\Databases\MSSQL\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\site05_afe26b39c6c743aba56adc109f439350.ldf' , SIZE = 8384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [site05] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [site05].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [site05] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [site05] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [site05] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [site05] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [site05] SET ARITHABORT OFF 
GO
ALTER DATABASE [site05] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [site05] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [site05] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [site05] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [site05] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [site05] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [site05] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [site05] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [site05] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [site05] SET  DISABLE_BROKER 
GO
ALTER DATABASE [site05] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [site05] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [site05] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [site05] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [site05] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [site05] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [site05] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [site05] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [site05] SET  MULTI_USER 
GO
ALTER DATABASE [site05] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [site05] SET DB_CHAINING OFF 
GO
ALTER DATABASE [site05] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [site05] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [site05] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [site05] SET QUERY_STORE = OFF
GO
USE [site05]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [site05]
GO
/****** Object:  User [site05]    Script Date: 27/01/2019 22:39:52 ******/
CREATE USER [site05] FOR LOGIN [site05] WITH DEFAULT_SCHEMA=[site05]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [site05]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [site05]
GO
ALTER ROLE [db_datareader] ADD MEMBER [site05]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [site05]
GO
/****** Object:  Schema [site05]    Script Date: 27/01/2019 22:39:53 ******/
CREATE SCHEMA [site05]
GO
/****** Object:  View [site05].[vwAdministrators]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwAdministrators]
AS
SELECT        TOP (100) PERCENT site05.tblAdministrator.AdministratorID, site05.tblAdministrator.UserID, site05.tblUser.Password, site05.tblAdministrator.FirstName, site05.tblAdministrator.LastName, site05.tblAdministrator.Email, 
                         site05.tblAdministrator.IsActive
FROM            site05.tblAdministrator INNER JOIN
                         site05.tblUser ON site05.tblAdministrator.UserID = site05.tblUser.UserID
GO
/****** Object:  View [site05].[vwClasses]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [site05].[vwClasses]
as
SELECT        TOP (100) PERCENT ClassID, ClassName, Longitude, Latitude, IsActive, LastLocationUpdate
FROM            site05.tblClass
GO
/****** Object:  View [site05].[vwCourses]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwCourses]
AS
SELECT        TOP (100) PERCENT CourseID, CourseName, IsActive
FROM            site05.tblCourse
GO
/****** Object:  View [site05].[vwCycles]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwCycles]
AS
SELECT        TOP (100) PERCENT CycleID, CycleName, Year, IsActive, CycleName + ' ' + CONVERT(nvarchar(10), Year) AS Name
FROM            site05.tblCycle
GO
/****** Object:  View [site05].[vwDepartments]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwDepartments]
AS
SELECT        TOP (100) PERCENT DepartmentName, DepartmentID, IsActive
FROM            site05.tblDepartment
GO
/****** Object:  View [site05].[vwForms]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwForms]
	AS
	SELECT        site05.tblForm.FormID, site05.tblForm.Picture, site05.tblForm.OpenDate, site05.tblForm.EndDate, site05.tblFormOfStudent.StudentID, site05.tblFormStatus.FormStatusID, site05.tblFormStatus.FormStatusName
	FROM            site05.tblForm INNER JOIN
							 site05.tblFormOfStudent ON site05.tblForm.FormID = site05.tblFormOfStudent.FormID INNER JOIN
							 site05.tblFormStatus ON site05.tblForm.FormStatusID = site05.tblFormStatus.FormStatusID
GO
/****** Object:  View [site05].[vwLecturers]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwLecturers]
AS
SELECT        TOP (100) PERCENT site05.tblLecturer.LecturerID, site05.tblLecturer.FirstName, site05.tblLecturer.LastName, site05.tblUser.Password, site05.tblLecturer.Email, site05.tblLecturer.Picture, 
                         site05.tblLecturer.FirstName + ' ' + site05.tblLecturer.LastName AS Name, site05.tblLecturer.IsActive, site05.tblUser.UserID
FROM            site05.tblLecturer INNER JOIN
                         site05.tblUser ON site05.tblLecturer.UserID = site05.tblUser.UserID
GO
/****** Object:  View [site05].[vwLectures]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [site05].[vwLectures]
AS
SELECT        TOP (100) PERCENT site05.tblLecture.LectureID, site05.tblCourse.CourseID, site05.tblCourse.CourseName, site05.tblDepartment.DepartmentID, site05.tblDepartment.DepartmentName, site05.tblCycle.CycleID, 
                         site05.tblCycle.CycleName, site05.tblLecturer.LecturerID, site05.tblLecturer.FirstName + N' ' + site05.tblLecturer.LastName AS Name, site05.tblClass.ClassID, site05.tblClass.ClassName, site05.tblLecture.LectureDate, 
                         site05.tblLecture.BeginHour, site05.tblLecture.EndHour, site05.tblLecture.Iscanceled, site05.tblWeekday.WeekdayName, site05.tblWeekday.WeekdayID, site05.tblCycle.CycleName + ' ' + CONVERT(nvarchar(10), 
                         site05.tblCycle.Year) AS CycleFullName
FROM            site05.tblLecture INNER JOIN
                         site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID INNER JOIN
                         site05.tblDepartment ON site05.tblLecture.DepartmentID = site05.tblDepartment.DepartmentID INNER JOIN
                         site05.tblCycle ON site05.tblLecture.CycleID = site05.tblCycle.CycleID INNER JOIN
                         site05.tblLecturer ON site05.tblLecture.LecturerID = site05.tblLecturer.LecturerID INNER JOIN
                         site05.tblClass ON site05.tblLecture.ClassID = site05.tblClass.ClassID INNER JOIN
                         site05.tblWeekday ON DATEPART(dw, site05.tblLecture.LectureDate) = site05.tblWeekday.WeekdayID
GO
/****** Object:  View [site05].[vwLocationManagers]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwLocationManagers]
AS
SELECT        TOP (100) PERCENT site05.tblLocationManager.LocationManagerID, site05.tblLocationManager.UserID, site05.tblUser.Password, site05.tblLocationManager.FirstName, site05.tblLocationManager.LastName, site05.tblLocationManager.Email, 
                         site05.tblLocationManager.IsActive
FROM            site05.tblLocationManager INNER JOIN
                         site05.tblUser ON site05.tblLocationManager.UserID = site05.tblUser.UserID
GO
/****** Object:  View [site05].[vwStatuses]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwStatuses]
AS
	SELECT        tblStatus.*
	FROM            tblStatus
GO
/****** Object:  View [site05].[vwStudents]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [site05].[vwStudents]
AS
SELECT        TOP (100) PERCENT site05.tblStudent.StudentID, site05.tblStudent.FirstName, site05.tblStudent.LastName, site05.tblStudent.Email, site05.tblStudent.Picture, site05.tblStudent.IsActive, site05.tblDepartment.DepartmentID, 
                         site05.tblDepartment.DepartmentName, site05.tblCycle.CycleID, site05.tblCycle.CycleName, site05.tblUser.Password, site05.tblCycle.CycleName + ' ' + CONVERT(nvarchar(10), site05.tblCycle.Year) AS Name, 
                         site05.tblUser.UserID
FROM            site05.tblStudent INNER JOIN
                         site05.tblUser ON site05.tblStudent.UserID = site05.tblUser.UserID LEFT OUTER JOIN
                         site05.tblCycle ON site05.tblStudent.CycleID = site05.tblCycle.CycleID LEFT OUTER JOIN
                         site05.tblDepartment ON site05.tblStudent.DepartmentID = site05.tblDepartment.DepartmentID
GO
/****** Object:  View [site05].[vwWeekdays]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [site05].[vwWeekdays]
AS
SELECT TOP (100) PERCENT * FROM tblWeekday ORDER BY WeekdayID
GO
/****** Object:  Table [site05].[tblAdministrator]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblAdministrator](
	[AdministratorID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[FirstName] [nvarchar](35) NOT NULL,
	[LastName] [nvarchar](35) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AdministratorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblClass]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblClass](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](30) NOT NULL,
	[Longitude] [decimal](9, 6) NULL,
	[Latitude] [decimal](9, 6) NULL,
	[IsActive] [bit] NOT NULL,
	[LastLocationUpdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblCourse]    Script Date: 27/01/2019 22:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblCourse](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblCoursesInDepartment]    Script Date: 27/01/2019 22:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblCoursesInDepartment](
	[CourseID] [int] NOT NULL,
	[DepartmentID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblCoursesOfStudent]    Script Date: 27/01/2019 22:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblCoursesOfStudent](
	[StudentID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[CycleID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC,
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblCycle]    Script Date: 27/01/2019 22:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblCycle](
	[CycleID] [int] IDENTITY(1,1) NOT NULL,
	[CycleName] [nvarchar](10) NOT NULL,
	[Year] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CycleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblCyclesInDepartment]    Script Date: 27/01/2019 22:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblCyclesInDepartment](
	[DepartmentID] [int] NOT NULL,
	[CycleID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC,
	[CycleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblDepartment]    Script Date: 27/01/2019 22:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblDepartment](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblForm]    Script Date: 27/01/2019 22:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblForm](
	[FormID] [int] IDENTITY(1,1) NOT NULL,
	[Picture] [nvarchar](max) NOT NULL,
	[FormStatusID] [int] NOT NULL,
	[OpenDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FormID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblFormOfStudent]    Script Date: 27/01/2019 22:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblFormOfStudent](
	[FormID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FormID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblFormStatus]    Script Date: 27/01/2019 22:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblFormStatus](
	[FormStatusID] [int] NOT NULL,
	[FormStatusName] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FormStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblLecture]    Script Date: 27/01/2019 22:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblLecture](
	[LectureID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[CycleID] [int] NOT NULL,
	[LecturerID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[LectureDate] [date] NOT NULL,
	[BeginHour] [time](7) NOT NULL,
	[EndHour] [time](7) NOT NULL,
	[IsCanceled] [bit] NOT NULL,
	[TimerStarted] [datetime] NULL,
	[TimerLong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[LectureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblLecturer]    Script Date: 27/01/2019 22:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblLecturer](
	[LecturerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[FirstName] [nvarchar](35) NOT NULL,
	[LastName] [nvarchar](35) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Picture] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[QRMode] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[LecturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblLecturersInCourse]    Script Date: 27/01/2019 22:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblLecturersInCourse](
	[CourseID] [int] NOT NULL,
	[LecturerID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[LecturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblLecturesInSemester]    Script Date: 27/01/2019 22:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblLecturesInSemester](
	[CourseID] [int] NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[CycleID] [int] NOT NULL,
	[LecturerID] [int] NOT NULL,
	[WeekdayID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[BeginHour] [time](7) NOT NULL,
	[EndHour] [time](7) NOT NULL,
	[OpenDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblLocationManager]    Script Date: 27/01/2019 22:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblLocationManager](
	[LocationManagerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[FirstName] [nvarchar](35) NOT NULL,
	[LastName] [nvarchar](35) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationManagerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblRole]    Script Date: 27/01/2019 22:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblRole](
	[RoleID] [int] NOT NULL,
	[RoleName] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblStatus]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblStatus](
	[StatusID] [int] NOT NULL,
	[StatusName] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblStudent](
	[StudentID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[DepartmentID] [int] NULL,
	[CycleID] [int] NULL,
	[FirstName] [nvarchar](35) NOT NULL,
	[LastName] [nvarchar](35) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Picture] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblStudentsInLecture]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblStudentsInLecture](
	[LectureID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LectureID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblUser]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblUser](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Token] [nvarchar](100) NULL,
	[RoleID] [int] NULL,
	[AfterFirstLogin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [site05].[tblWeekday]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[tblWeekday](
	[WeekdayID] [int] NOT NULL,
	[WeekdayName] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WeekdayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [site05].[tblAdministrator] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblClass] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblCourse] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblCoursesOfStudent] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblCycle] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblDepartment] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblLecture] ADD  DEFAULT (NULL) FOR [TimerStarted]
GO
ALTER TABLE [site05].[tblLecture] ADD  DEFAULT ((15)*(60)) FOR [TimerLong]
GO
ALTER TABLE [site05].[tblLecturer] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblLecturer] ADD  CONSTRAINT [DF__tblLectur__QRMod__6FAA73D4]  DEFAULT ((1)) FOR [QRMode]
GO
ALTER TABLE [site05].[tblLocationManager] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblStudent] ADD  DEFAULT (NULL) FOR [DepartmentID]
GO
ALTER TABLE [site05].[tblStudent] ADD  DEFAULT (NULL) FOR [CycleID]
GO
ALTER TABLE [site05].[tblStudent] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [site05].[tblStudentsInLecture] ADD  DEFAULT ((1)) FOR [StatusID]
GO
ALTER TABLE [site05].[tblUser] ADD  DEFAULT ((0)) FOR [AfterFirstLogin]
GO
ALTER TABLE [site05].[tblAdministrator]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [site05].[tblUser] ([UserID])
GO
ALTER TABLE [site05].[tblCoursesInDepartment]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [site05].[tblCourse] ([CourseID])
GO
ALTER TABLE [site05].[tblCoursesInDepartment]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [site05].[tblDepartment] ([DepartmentID])
GO
ALTER TABLE [site05].[tblCoursesOfStudent]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [site05].[tblCourse] ([CourseID])
GO
ALTER TABLE [site05].[tblCoursesOfStudent]  WITH CHECK ADD FOREIGN KEY([CycleID])
REFERENCES [site05].[tblCycle] ([CycleID])
GO
ALTER TABLE [site05].[tblCoursesOfStudent]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [site05].[tblStudent] ([StudentID])
GO
ALTER TABLE [site05].[tblCyclesInDepartment]  WITH CHECK ADD FOREIGN KEY([CycleID])
REFERENCES [site05].[tblCycle] ([CycleID])
GO
ALTER TABLE [site05].[tblCyclesInDepartment]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [site05].[tblDepartment] ([DepartmentID])
GO
ALTER TABLE [site05].[tblForm]  WITH CHECK ADD FOREIGN KEY([FormStatusID])
REFERENCES [site05].[tblFormStatus] ([FormStatusID])
GO
ALTER TABLE [site05].[tblFormOfStudent]  WITH CHECK ADD FOREIGN KEY([FormID])
REFERENCES [site05].[tblForm] ([FormID])
GO
ALTER TABLE [site05].[tblFormOfStudent]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [site05].[tblStudent] ([StudentID])
GO
ALTER TABLE [site05].[tblLecture]  WITH CHECK ADD FOREIGN KEY([ClassID])
REFERENCES [site05].[tblClass] ([ClassID])
GO
ALTER TABLE [site05].[tblLecture]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [site05].[tblCourse] ([CourseID])
GO
ALTER TABLE [site05].[tblLecture]  WITH CHECK ADD FOREIGN KEY([CycleID])
REFERENCES [site05].[tblCycle] ([CycleID])
GO
ALTER TABLE [site05].[tblLecture]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [site05].[tblDepartment] ([DepartmentID])
GO
ALTER TABLE [site05].[tblLecture]  WITH CHECK ADD FOREIGN KEY([LecturerID])
REFERENCES [site05].[tblLecturer] ([LecturerID])
GO
ALTER TABLE [site05].[tblLecturer]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [site05].[tblUser] ([UserID])
GO
ALTER TABLE [site05].[tblLecturersInCourse]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [site05].[tblCourse] ([CourseID])
GO
ALTER TABLE [site05].[tblLecturersInCourse]  WITH CHECK ADD FOREIGN KEY([LecturerID])
REFERENCES [site05].[tblLecturer] ([LecturerID])
GO
ALTER TABLE [site05].[tblLecturesInSemester]  WITH CHECK ADD FOREIGN KEY([ClassID])
REFERENCES [site05].[tblClass] ([ClassID])
GO
ALTER TABLE [site05].[tblLecturesInSemester]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [site05].[tblCourse] ([CourseID])
GO
ALTER TABLE [site05].[tblLecturesInSemester]  WITH CHECK ADD FOREIGN KEY([CycleID])
REFERENCES [site05].[tblCycle] ([CycleID])
GO
ALTER TABLE [site05].[tblLecturesInSemester]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [site05].[tblDepartment] ([DepartmentID])
GO
ALTER TABLE [site05].[tblLecturesInSemester]  WITH CHECK ADD FOREIGN KEY([LecturerID])
REFERENCES [site05].[tblLecturer] ([LecturerID])
GO
ALTER TABLE [site05].[tblLecturesInSemester]  WITH CHECK ADD FOREIGN KEY([WeekdayID])
REFERENCES [site05].[tblWeekday] ([WeekdayID])
GO
ALTER TABLE [site05].[tblLocationManager]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [site05].[tblUser] ([UserID])
GO
ALTER TABLE [site05].[tblStudent]  WITH CHECK ADD FOREIGN KEY([CycleID])
REFERENCES [site05].[tblCycle] ([CycleID])
GO
ALTER TABLE [site05].[tblStudent]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [site05].[tblDepartment] ([DepartmentID])
GO
ALTER TABLE [site05].[tblStudent]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [site05].[tblUser] ([UserID])
GO
ALTER TABLE [site05].[tblStudentsInLecture]  WITH CHECK ADD FOREIGN KEY([LectureID])
REFERENCES [site05].[tblLecture] ([LectureID])
GO
ALTER TABLE [site05].[tblStudentsInLecture]  WITH CHECK ADD FOREIGN KEY([StatusID])
REFERENCES [site05].[tblStatus] ([StatusID])
GO
ALTER TABLE [site05].[tblStudentsInLecture]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [site05].[tblStudent] ([StudentID])
GO
ALTER TABLE [site05].[tblUser]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [site05].[tblRole] ([RoleID])
GO
/****** Object:  StoredProcedure [site05].[spAcceptForm]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAcceptForm]
@FormID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @OpenDate date = (SELECT OpenDate FROM tblForm WHERE FormID = @FormID)
			declare @EndDate date = (SELECT EndDate FROM tblForm WHERE FormID = @FormID)
			declare @StudentID int = (SELECT StudentID FROM tblFormOfStudent WHERE FormID = @FormID)
			UPDATE tblStudentsInLecture SET StatusID = 4 FROM site05.tblLecture INNER JOIN site05.tblStudentsInLecture ON site05.tblLecture.LectureID = site05.tblStudentsInLecture.LectureID WHERE (StudentID = @StudentID) AND (StatusID = 1) AND (@OpenDate <= LectureDate AND @EndDate >= LectureDate) 
			UPDATE tblForm SET FormStatusID = 2 WHERE FormID = @FormID

			SELECT        site05.tblUser.Token
			FROM		  site05.tblStudent INNER JOIN site05.tblUser ON site05.tblStudent.UserID = site05.tblUser.UserID
			WHERE         (site05.tblStudent.StudentID = @StudentID)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spActivateTimer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spActivateTimer]
@LectureID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @Now datetime = GETDATE()
			declare @CurrentDate date = CONVERT(DATE, @Now)
			declare @CurrentTime time = CONVERT(TIME, @Now)
			IF EXISTS (SELECT tblLecture.LectureID FROM tblLecture	WHERE (LectureID = @LectureID) AND (tblLecture.LectureDate = @CurrentDate) AND (tblLecture.BeginHour <= @CurrentTime) AND (tblLecture.EndHour >= @CurrentTime))
			BEGIN
				UPDATE tblLecture SET TimerStarted = GETDATE(), TimerLong = 15 * 60, TimerFired = 1 WHERE LectureID = @LectureID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddAdministrator]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddAdministrator] -- V -- spAddAdministrator
@AdministratorID int,
@Password nvarchar(max),
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email nvarchar(100)
AS
BEGIN
	IF EXISTS (SELECT * FROM tblAdministrator WHERE AdministratorID = @AdministratorID)
	BEGIN
		RAISERROR ('מספר זהות תפוס', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT * FROM tblAdministrator WHERE Email = @Email)
	BEGIN
		RAISERROR ('אימייל תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblUser] (Password, RoleID) Values (@Password,1)
			INSERT [tblAdministrator] (AdministratorID, UserID, FirstName, LastName, Email) Values (@AdministratorID,SCOPE_IDENTITY(),LTRIM(RTRIM(@FirstName)),LTRIM(RTRIM(@LastName)),LTRIM(RTRIM(LOWER(@Email))))
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddClass]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddClass] -- V -- spAddClass
@ClassName nvarchar(30),
@Longitude decimal(9,6) = NULL,
@Latitude decimal(9,6) = NULL
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblClass] ([ClassName], [Longitude], [Latitude]) Values (LTRIM(RTRIM(@ClassName)),@Longitude,@Latitude)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddCourse]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddCourse] -- V -- spAddCourse
@CourseName nvarchar(50)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblCourse] (CourseName) Values (LTRIM(RTRIM(@CourseName)))
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddCycle]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddCycle] -- V -- spAddCycle
@CycleName nvarchar(10),
@Year int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblCycle] (CycleName, Year) Values (LTRIM(RTRIM(@CycleName)), @Year)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddDepartment]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddDepartment] -- V -- spAddDepartment
@DepartmentName nvarchar(50)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblDepartment] (DepartmentName) Values (LTRIM(RTRIM(@DepartmentName)))
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddForm]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddForm]
@StudentID int,
@OpenDate date,
@EndDate date,
@Picture nvarchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT tblForm (Picture, FormStatusID, OpenDate, EndDate) Values (@Picture, 1, @OpenDate, @EndDate)
			declare @FormID int = SCOPE_IDENTITY()
			INSERT tblFormOfStudent (FormID, StudentID) Values (@FormID, @StudentID)
			SELECT        site05.tblForm.FormID, site05.tblForm.OpenDate, site05.tblForm.EndDate, site05.tblForm.Picture, site05.tblFormOfStudent.StudentID, site05.tblFormStatus.FormStatusID, site05.tblFormStatus.FormStatusName
			FROM            site05.tblForm INNER JOIN
									 site05.tblFormOfStudent ON site05.tblForm.FormID = site05.tblFormOfStudent.FormID INNER JOIN
									 site05.tblFormStatus ON site05.tblForm.FormStatusID = site05.tblFormStatus.FormStatusID
			WHERE        (site05.tblForm.FormID = @FormID)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddLecturer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddLecturer] -- V -- spAddLecturer
@LecturerID int,
@Password varchar(max),
@FirstName nvarchar(35),
@LastName nvarchar(35) = '',
@Email nvarchar(100),
@Picture nvarchar(max)
AS
BEGIN
	IF EXISTS (SELECT * FROM tblLecturer WHERE LecturerID = @LecturerID)
	BEGIN
		RAISERROR ('מספר זהות תפוס', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT * FROM tblLecturer WHERE Email = @Email)
	BEGIN
		RAISERROR ('אימייל תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblUser] (Password, RoleID) Values (@Password,2)
			INSERT [tblLecturer] (LecturerID, UserID, FirstName, LastName, Email, Picture) Values (@LecturerID,SCOPE_IDENTITY(),LTRIM(RTRIM(@FirstName)),LTRIM(RTRIM(@LastName)),LTRIM(RTRIM(LOWER(@Email))), @Picture)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddLectures]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddLectures] -- V -- spAddLectures
@CourseID int,
@DepartmentID int,
@CycleID int,
@LecturerID int,
@WeekdayID int,
@ClassID int,
@BeginHour time,
@EndHour time,
@OpenDate date,
@EndDate date
AS
BEGIN
	WHILE (@OpenDate <= @EndDate) -- בדיקה לגבי הרצאות, ולא לגבי זמני הקורסים
	BEGIN	
		IF (DATEPART(WEEKDAY,@OpenDate) = @WeekdayID)
		BEGIN
			IF EXISTS (SELECT LectureID FROM tblLecture WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID AND LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
			BEGIN
				RAISERROR ('המחזור והמגמה תפוסים', 16, 1)
				RETURN
			END
			IF EXISTS (SELECT LectureID FROM tblLecture WHERE ClassID = @ClassID AND LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
			BEGIN
				RAISERROR ('הכיתה תפוסה', 16, 1)
				RETURN
			END
			IF EXISTS (SELECT LectureID FROM tblLecture WHERE LecturerID = @LecturerID AND LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
			BEGIN
				RAISERROR ('המרצה תפוס', 16, 1)
				RETURN
			END
			INSERT [tblLecture] (CourseID, ClassID, DepartmentID, CycleID, LecturerID, LectureDate, BeginHour, EndHour, Iscanceled, TimerStarted) Values (@CourseID,@ClassID,@DepartmentID,@CycleID,@LecturerID,@OpenDate,@BeginHour,@EndHour, 0, CAST(@OpenDate AS datetime) + CAST(@BeginHour AS datetime))
			DECLARE @LectureID INT = SCOPE_IDENTITY()
			EXEC spAddStudentsInLectures @DepartmentID, @CycleID, @CourseID, @LectureID
		END
		SELECT @OpenDate = DATEADD(day, 1, @OpenDate)
	END
END

GO
/****** Object:  StoredProcedure [site05].[spAddLecturesInSemester]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddLecturesInSemester] -- V -- spAddLecturesInSemester
@CourseID int,
@DepartmentID int,
@CycleID int,
@LecturerID int,
@WeekdayID int,
@ClassID int,
@BeginHour time,
@EndHour time,
@OpenDate date,
@EndDate date
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @OpenDateChosen date = @OpenDate
			declare @LectureID int
			WHILE (@OpenDate <= @EndDate)
			BEGIN
				IF (DATEPART(WEEKDAY,@OpenDate) = @WeekdayID)
				BEGIN
					WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE ((CycleID = @CycleID AND DepartmentID = @DepartmentID) OR ClassID = @ClassID OR LecturerID = @LecturerID) AND LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
					BEGIN
						SELECT @LectureID = (SELECT TOP 1 LectureID FROM tblLecture WHERE ((CycleID = @CycleID AND DepartmentID = @DepartmentID) OR ClassID = @ClassID OR LecturerID = @LecturerID) AND LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
						exec spDeleteLecture @LectureID
					END
					INSERT [tblLecture] (CourseID, ClassID, DepartmentID, CycleID, LecturerID, LectureDate, BeginHour, EndHour, Iscanceled, TimerStarted) Values (@CourseID,@ClassID,@DepartmentID,@CycleID,@LecturerID,@OpenDate,@BeginHour,@EndHour, 0, CAST(@OpenDate AS datetime) + CAST(@BeginHour AS datetime))
					SET @LectureID = SCOPE_IDENTITY()
					EXEC spAddStudentsInLectures @DepartmentID, @CycleID, @CourseID, @LectureID
				END
			SELECT @OpenDate = DATEADD(day, 1, @OpenDate)
			END
		INSERT [tblLecturesInSemester] (CourseID, DepartmentID, CycleID, LecturerID, WeekdayID, ClassID, BeginHour, EndHour, OpenDate, EndDate) Values (@CourseID,@DepartmentID,@CycleID,@LecturerID,@WeekdayID,@ClassID,@BeginHour,@EndHour,@OpenDateChosen,@EndDate)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddLecturesInSemesterTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddLecturesInSemesterTry] -- V -- spAddLecturesInSemesterTry
@CourseID int,
@DepartmentID int,
@CycleID int,
@LecturerID int,
@WeekdayID int,
@ClassID int,
@BeginHour time,
@EndHour time,
@OpenDate date,
@EndDate date
AS
BEGIN
	BEGIN TRANSACTION
		declare @IsSucceeded bit = 1
		declare @Index int = 0
		declare @OpenDateChosen date = @OpenDate
		WHILE (@OpenDate <= @EndDate)
		BEGIN	
			IF (DATEPART(WEEKDAY,@OpenDate) = @WeekdayID)
			BEGIN
				IF EXISTS (SELECT LectureID FROM tblLecture WHERE ((CycleID = @CycleID AND DepartmentID = @DepartmentID) OR ClassID = @ClassID OR LecturerID = @LecturerID) AND  LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
				BEGIN
					SET @IsSucceeded = 0
					ROLLBACK TRANSACTION
					RAISERROR ('ההרצאות שבחרת להוסיף מתנגשות עם הרצאות אחרות. ההרצאות יוחלפו', 16, 1)
					RETURN
				END
				ELSE
				BEGIN
				BEGIN TRY
					BEGIN TRANSACTION
						-- אין התנגשות
						IF (@Index = 0)
						BEGIN
							INSERT [tblLecturesInSemester] (CourseID, DepartmentID, CycleID, LecturerID, WeekdayID, ClassID, BeginHour, EndHour, OpenDate, EndDate) Values (@CourseID,@DepartmentID,@CycleID,@LecturerID,@WeekdayID,@ClassID,@BeginHour,@EndHour,@OpenDateChosen,@EndDate)
						END
						SET @Index = @Index + 1
						INSERT [tblLecture] (CourseID, ClassID, DepartmentID, CycleID, LecturerID, LectureDate, BeginHour, EndHour, Iscanceled, TimerStarted) Values (@CourseID,@ClassID,@DepartmentID,@CycleID,@LecturerID,@OpenDate,@BeginHour,@EndHour, 0, CAST(@OpenDate AS datetime) + CAST(@BeginHour AS datetime))
						DECLARE @LectureID INT = SCOPE_IDENTITY()
						EXEC spAddStudentsInLectures @DepartmentID, @CycleID, @CourseID, @LectureID
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					SET @IsSucceeded = 0
					ROLLBACK TRANSACTION
				END CATCH
				END
			END
			SELECT @OpenDate = DATEADD(day, 1, @OpenDate)
		END
	IF (@IsSucceeded=1)
	BEGIN
		COMMIT TRANSACTION
	END
END

GO
/****** Object:  StoredProcedure [site05].[spAddLectureTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddLectureTry] -- V -- spAddLectureTry
@CourseID int,
@DepartmentID int,
@CycleID int,
@LecturerID int,
@ClassID int,
@LectureDate date,
@BeginHour time,
@EndHour time
AS
BEGIN
	IF EXISTS (SELECT LectureID FROM tblLecture WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID AND LectureDate = @LectureDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
	BEGIN
		RAISERROR ('המחזור והמגמה תפוסים', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT ClassID FROM tblLecture WHERE ClassID = @ClassID AND LectureDate = @LectureDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
	BEGIN
		RAISERROR ('הכיתה תפוסה', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT LecturerID FROM tblLecture WHERE LecturerID = @LecturerID AND LectureDate = @LectureDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
	BEGIN
		RAISERROR ('המרצה תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblLecture] ([CourseID], [DepartmentID], [CycleID], [LecturerID], [ClassID], [LectureDate], [BeginHour], [EndHour], [Iscanceled], TimerStarted) Values (@CourseID,@DepartmentID,@CycleID,@LecturerID,@ClassID,@LectureDate,@BeginHour,@EndHour,0, CAST(@LectureDate AS datetime) + CAST(@BeginHour AS datetime))
			DECLARE @LectureID INT = SCOPE_IDENTITY()
			EXEC spAddStudentsInLectures @DepartmentID, @CycleID, @CourseID, @LectureID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spAddLocationManager]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddLocationManager]
@LocationManagerID int,
@Password nvarchar(max),
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email nvarchar(100)
AS
BEGIN
	IF EXISTS (SELECT * FROM tblLocationManager WHERE LocationManagerID = @LocationManagerID)
	BEGIN
		RAISERROR ('מספר זהות תפוס', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT * FROM tblLocationManager WHERE Email = @Email)
	BEGIN
		RAISERROR ('אימייל תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblUser] (Password, RoleID) Values (@Password,4)
			INSERT [tblLocationManager] (LocationManagerID, UserID, FirstName, LastName, Email) Values (@LocationManagerID,SCOPE_IDENTITY(),LTRIM(RTRIM(@FirstName)),LTRIM(RTRIM(@LastName)),LTRIM(RTRIM(LOWER(@Email))))
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddStudent] -- V -- spAddStudent
@StudentID int,
@Password varchar(max),
@DepartmentID int,
@CycleID int,
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email nvarchar(100),
@Picture nvarchar(max)
AS
BEGIN
	IF EXISTS (SELECT * FROM tblStudent WHERE StudentID = @StudentID)
	BEGIN
		RAISERROR ('מספר זהות תפוס', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT * FROM tblStudent WHERE Email = @Email)
	BEGIN
		RAISERROR ('אימייל תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblUser] (Password, RoleID) Values (@Password,3)
			INSERT [tblStudent] (StudentID, UserID, DepartmentID, CycleID, FirstName, LastName, Email, Picture) Values (@StudentID,SCOPE_IDENTITY(),@DepartmentID,@CycleID,LTRIM(RTRIM(@FirstName)),LTRIM(RTRIM(@LastName)),LTRIM(RTRIM(LOWER(@Email))), @Picture)
			SELECT CourseID Into #TempCourses FROM tblCoursesInDepartment WHERE DepartmentID = @DepartmentID
			declare @CourseID int
			declare @LectureID int
			WHILE EXISTS (SELECT * FROM #TempCourses)
			BEGIN
				SET @CourseID = (Select TOP 1 * From #TempCourses)
				INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, @CycleID)
				SELECT tblLecture.* INTO #TempLectures FROM tblLecture WHERE CourseID = @CourseID AND DepartmentID = @DepartmentID AND (CycleID = @CycleID)
				WHILE EXISTS (SELECT LectureID FROM #TempLectures)
				BEGIN
					SET @LectureID = (Select TOP 1 LectureID From #TempLectures)
					INSERT [tblStudentsInLecture] ([LectureID], [StudentID], [StatusID]) Values (@LectureID, @StudentID, 1)
					Delete #TempLectures Where LectureID = @LectureID
				END
				drop table #TempLectures
				Delete #TempCourses Where CourseID = @CourseID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spAddStudentsInLectures]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הוסף סטודנטים להרצאות לפי מגמה והרצאה

CREATE PROC [site05].[spAddStudentsInLectures] -- V -- spAddStudentsInLectures
@DepartmentID int,
@CycleID int,
@CourseID int,
@LectureID int
AS
BEGIN
	declare @StudentID int
	SELECT * INTO #TempStudents FROM tblStudent
	WHILE EXISTS (SELECT * FROM #TempStudents)
	BEGIN
		SET @StudentID = (SELECT TOP 1 StudentID FROM #TempStudents)
		IF EXISTS (SELECT tblStudent.StudentID FROM tblStudent INNER JOIN tblCycle ON tblStudent.CycleID = tblCycle.CycleID INNER JOIN tblCoursesOfStudent ON tblStudent.StudentID = tblCoursesOfStudent.StudentID
			WHERE (tblStudent.StudentID = @StudentID) AND (DepartmentID = @DepartmentID) AND (tblCycle.CycleID = @CycleID) AND ((SELECT IsActive FROM tblCoursesOfStudent WHERE (StudentID = @StudentID) AND (CourseID = @CourseID)) = 1))
		BEGIN
			INSERT [tblStudentsInLecture] (LectureID, StudentID, StatusID) Values (@LectureID,@StudentID,1)
		END
		DELETE #TempStudents WHERE StudentID = @StudentID
	END
	DROP TABLE #TempStudents
END

GO
/****** Object:  StoredProcedure [site05].[spAddWeekday]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spAddWeekday] -- V -- spAddWeekday
@WeekdayID int,
@WeekdayName nvarchar(10)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT [tblWeekday] (WeekdayID, WeekdayName) Values (@WeekdayID,LTRIM(RTRIM(@WeekdayName)))
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spCheckAddLecture]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- בודק אימות של הוספת קורס
--------------------------------- אם יש תקלה עוצר שם, אם אין תקלה ממשיך לפרוצדורה הבאה

CREATE PROC [site05].[spCheckAddLecture] -- V -- spCheckAddLecture
@CourseID int,
@DepartmentID int,
@CycleID int,
@LecturerID int,
@BeginHour time,
@EndHour time
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM tblCyclesInDepartment WHERE (CycleID = @CycleID) AND (DepartmentID = @DepartmentID))
	BEGIN
		RAISERROR ('המגמה לא משויכת למחזור', 16, 1)
		RETURN
	END
	IF NOT EXISTS (SELECT * FROM tblCoursesInDepartment WHERE (CourseID = @CourseID) AND (DepartmentID = @DepartmentID))
	BEGIN
		RAISERROR ('הקורס לא משוייך למגמה', 16, 1)
		RETURN
	END
	IF NOT EXISTS (SELECT * FROM tblLecturersInCourse WHERE (LecturerID = @LecturerID) AND (CourseID = @CourseID))
	BEGIN
		RAISERROR ('המרצה לא משויך לקורס', 16, 1)
		RETURN
	END
	IF (@EndHour <= @BeginHour)
	BEGIN
		RAISERROR ('שעת ההתחלה חייבת להיות קטנה יותר משעת הסיום', 16, 1)
		RETURN
	END
	IF (DATEDIFF(MINUTE, @BeginHour, @EndHour) < 45)
	BEGIN
		RAISERROR ('כל שיעור חייב להמשך לפחות 45 דקות', 16, 1)
		RETURN
	END
END

GO
/****** Object:  StoredProcedure [site05].[spCheckAddLecturesInSemester]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------------- בודק אם מתנגש בהרצאה מתוך טבלת הרצאות לפי סמסטרים
--------------------------------- אם יש תקלה עוצר שם, אם אין תקלה ממשיך לפרוצדורה הבאה

CREATE PROC [site05].[spCheckAddLecturesInSemester] -- V -- spCheckAddLecturesInSemester
@CourseID int,
@DepartmentID int,
@CycleID int,
@LecturerID int,
@WeekdayID int,
@ClassID int,
@BeginHour time,
@EndHour time,
@OpenDate date,
@EndDate date
AS
BEGIN
	declare @LecturerIssue bit = 0
	declare @ClassIssue bit = 0
	declare @CycleIssue bit = 0
	WHILE (@OpenDate <= @EndDate)
	BEGIN
		IF (DATEPART(WEEKDAY,@OpenDate) = @WeekdayID)
		BEGIN
			IF EXISTS (SELECT * FROM tblLecture WHERE (LecturerID = @LecturerID) AND LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
			BEGIN
				SET @LecturerIssue = 1
			END
			ELSE IF EXISTS (SELECT * FROM tblLecture WHERE (ClassID = @ClassID) AND LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
			BEGIN
				SET @ClassIssue = 1
			END
			ELSE IF EXISTS (SELECT * FROM tblLecture WHERE (CycleID = @CycleID) AND (DepartmentID = @DepartmentID) AND LectureDate = @OpenDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
			BEGIN
				SET @CycleIssue = 1
			END
			IF (@LecturerIssue = 1 OR @ClassIssue = 1 OR @CycleIssue = 1)
			BEGIN
				SELECT * INTO #Temp FROM tblLecturesInSemester WHERE (CycleID = @CycleID OR ClassID = @ClassID OR LecturerID = @LecturerID) AND WeekdayID = DATEPART(WEEKDAY,@OpenDate) AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour)))
				WHILE EXISTS (SELECT * FROM #Temp)
				BEGIN
					IF (@OpenDate BETWEEN (SELECT TOP(1) OpenDate FROM #Temp) AND (SELECT TOP(1) EndDate FROM #Temp))
					BEGIN
						IF (@LecturerIssue = 1)
						BEGIN
							RAISERROR ('המרצה תפוס', 16, 1)
							RETURN
						END
						ELSE IF (@ClassIssue = 1)
						BEGIN
							RAISERROR ('הכיתה תפוסה', 16, 1)
							RETURN
						END
						ELSE IF (@CycleIssue = 1)
						BEGIN
							RAISERROR ('המחזור תפוס', 16, 1)
							RETURN
						END
					END
				DELETE #Temp WHERE OpenDate = (SELECT TOP(1) OpenDate FROM #Temp) AND EndDate = (SELECT TOP(1) EndDate FROM #Temp)
				END
			END
		END
		SELECT @OpenDate = DATEADD(day, 1, @OpenDate)
	END
END

GO
/****** Object:  StoredProcedure [site05].[spCheckDeleteClass]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- לבדוק לגבי מחיקת כיתה

CREATE PROC [site05].[spCheckDeleteClass] -- V
@ClassID int
AS
BEGIN
	DECLARE @LectureID int
	IF EXISTS (SELECT LectureID FROM tblLecture WHERE ClassID = @ClassID)
	BEGIN
		RAISERROR ('הכיתה רשומה להרצאות. ההרצאות ימחקו', 16, 1)
		RETURN
	END
END

GO
/****** Object:  StoredProcedure [site05].[spCheckDeleteCourse]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- בדוק לגבי מחיקת קורס

CREATE PROC [site05].[spCheckDeleteCourse] -- V
@CourseID int
AS
BEGIN
	BEGIN TRANSACTION
		IF EXISTS (SELECT LectureID FROM [tblLecture] WHERE CourseID = @CourseID)
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('הקורס רשום להרצאות. ההרצאות ימחקו', 16, 1)
			RETURN 
		END
	COMMIT TRANSACTION
END

GO
/****** Object:  StoredProcedure [site05].[spCheckDeleteCycle]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- בודק לגבי מחיקת מחזור

CREATE PROC [site05].[spCheckDeleteCycle] -- V
@CycleID int
AS
BEGIN
	BEGIN TRANSACTION
		IF EXISTS (SELECT LectureID FROM tblLecture WHERE (CycleID = @CycleID))
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('המחזור רשום להרצאות. ההרצאות ימחקו', 16, 1)
			RETURN
		END
	COMMIT TRANSACTION
END

GO
/****** Object:  StoredProcedure [site05].[spCheckDeleteDepartment]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- בודק לגבי מחיקה של מגמה

CREATE PROC [site05].[spCheckDeleteDepartment] -- V
@DepartmentID int
AS
BEGIN
	BEGIN TRANSACTION
		IF EXISTS (SELECT LectureID FROM tblLecture WHERE DepartmentID = @DepartmentID)
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('המגמה רשומה להרצאות. ההרצאות ימחקו', 16, 1)
			RETURN
		END
	COMMIT TRANSACTION
END

GO
/****** Object:  StoredProcedure [site05].[spCheckDeleteLecturer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spCheckDeleteLecturer] -- V
@LecturerID int
AS
BEGIN
	BEGIN TRANSACTION
		declare @UserID int = (SELECT UserID FROM tblLecturer WHERE LecturerID = @LecturerID)
		IF EXISTS (SELECT LectureID FROM [tblLecture] WHERE LecturerID = @LecturerID)
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('המרצה רשום להרצאות. ההרצאות ימחקו', 16, 1)
			RETURN
		END
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [site05].[spCheckUpcommingLectures]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spCheckUpcommingLectures]
AS
BEGIN
	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)
	declare @In5Min time = (SELECT DATEADD(MINUTE,5, @CurrentTime))
	declare @In5MinHour int = (SELECT DATEPART(hour,@In5Min))
	declare @In5MinMinute int = (SELECT DATEPART(minute,@In5Min))

	declare @LectureID int = (SELECT LectureID FROM site05.tblLecture WHERE (LectureDate = @CurrentDate) AND (DATEPART(hour, BeginHour) = @In5MinHour) AND (DATEPART(minute, BeginHour) = @In5MinMinute))

	SELECT        site05.tblLecture.LectureID, site05.tblCourse.CourseID, site05.tblCourse.CourseName,  site05.tblStudent.StudentID, site05.tblStudent.FirstName, site05.tblUser.UserID, site05.tblUser.Token, site05.tblClass.ClassID, site05.tblClass.ClassName
	FROM            site05.tblLecture INNER JOIN
                         site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID INNER JOIN
                         site05.tblStudentsInLecture ON site05.tblLecture.LectureID = site05.tblStudentsInLecture.LectureID INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID INNER JOIN
                         site05.tblUser ON site05.tblStudent.UserID = site05.tblUser.UserID INNER JOIN
                         site05.tblClass ON site05.tblLecture.ClassID = site05.tblClass.ClassID
	WHERE        (tblLecture.LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1)

	SELECT        site05.tblLecture.LectureID, site05.tblLecturer.LecturerID, site05.tblLecturer.FirstName, site05.tblUser.UserID, site05.tblUser.Token, site05.tblDepartment.DepartmentID, site05.tblDepartment.DepartmentName, site05.tblCycle.CycleID, site05.tblCycle.CycleName, 
                         site05.tblCourse.CourseID, site05.tblCourse.CourseName, site05.tblClass.ClassID, site05.tblClass.ClassName
	FROM            site05.tblLecture INNER JOIN
                         site05.tblLecturer ON site05.tblLecture.LecturerID = site05.tblLecturer.LecturerID INNER JOIN
                         site05.tblUser ON site05.tblLecturer.UserID = site05.tblUser.UserID INNER JOIN
                         site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID INNER JOIN
                         site05.tblDepartment ON site05.tblLecture.DepartmentID = site05.tblDepartment.DepartmentID INNER JOIN
                         site05.tblCycle ON site05.tblLecture.CycleID = site05.tblCycle.CycleID INNER JOIN
                         site05.tblClass ON site05.tblLecture.ClassID = site05.tblClass.ClassID
	WHERE        (site05.tblLecture.LectureID = @LectureID) AND (site05.tblLecturer.IsActive = 1)
END
GO
/****** Object:  StoredProcedure [site05].[spCheckUpdateStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spCheckUpdateStudent] -- V -- spUpdateStudentTry
@StudentID int,
@Email nvarchar(100)
AS
BEGIN
	IF EXISTS (SELECT * FROM tblStudent WHERE Email = @Email AND StudentID <> @StudentID)
	BEGIN
		RAISERROR ('אימייל תפוס', 16, 1)
		RETURN
	END
END
GO
/****** Object:  StoredProcedure [site05].[spDeclineForm]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spDeclineForm]
@FormID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @StudentID int = (SELECT StudentID FROM tblFormOfStudent WHERE FormID = @FormID)
			UPDATE tblForm SET FormStatusID = 3 WHERE FormID = @FormID

			SELECT        site05.tblUser.Token
			FROM		  site05.tblStudent INNER JOIN site05.tblUser ON site05.tblStudent.UserID = site05.tblUser.UserID
			WHERE         (site05.tblStudent.StudentID = @StudentID)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spDeleteAdministrator]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spDeleteAdministrator] -- V
@AdministratorID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblAdministrator WHERE AdministratorID = @AdministratorID)
			DELETE FROM tblAdministrator WHERE AdministratorID = @AdministratorID
			DELETE FROM tblUser WHERE UserID = @UserID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spDeleteClassHard]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק כיתה

CREATE PROC [site05].[spDeleteClassHard] -- V
@ClassID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @LectureID int
			WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE ClassID = @ClassID)
			BEGIN
				SELECT @LectureID = (SELECT TOP(1) LectureID FROM tblLecture WHERE ClassID = @ClassID)
				exec spDeleteLecture @LectureID
			END
			DELETE [tblLecturesInSemester] WHERE ClassID = @ClassID
			DELETE [tblClass] WHERE ClassID = @ClassID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteClassSoft]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק כיתה

CREATE PROC [site05].[spDeleteClassSoft] -- V
@ClassID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE [tblClass] WHERE ClassID = @ClassID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteCourseHard]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק קורס

CREATE PROC [site05].[spDeleteCourseHard] -- V
@CourseID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @LectureID int
			WHILE EXISTS (SELECT LectureID FROM [tblLecture] WHERE CourseID = @CourseID)
			BEGIN
				SELECT @LectureID = (SELECT TOP(1) LectureID FROM tblLecture WHERE CourseID = @CourseID)
				exec spDeleteLecture @LectureID
			END
			DELETE FROM [tblCoursesInDepartment] WHERE CourseID = @CourseID
			DELETE [tblLecturesInSemester] WHERE CourseID = @CourseID
			DELETE FROM [tblLecturersInCourse] WHERE CourseID = @CourseID
			DELETE FROM [tblCoursesOfStudent] WHERE CourseID = @CourseID
			DELETE FROM [tblCourse] WHERE CourseID = @CourseID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteCourseSoft]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק קורס

CREATE PROC [site05].[spDeleteCourseSoft] -- V
@CourseID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM [tblCoursesInDepartment] WHERE CourseID = @CourseID
			DELETE FROM [tblLecturersInCourse] WHERE CourseID = @CourseID
			DELETE FROM [tblCoursesOfStudent] WHERE CourseID = @CourseID
			DELETE FROM [tblCourse] WHERE CourseID = @CourseID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteCycleHard]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק מחזור

CREATE PROC [site05].[spDeleteCycleHard] -- V
@CycleID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @LectureID int
			DELETE [tblCyclesInDepartment] WHERE CycleID = @CycleID
			UPDATE [tblStudent] SET CycleID = null WHERE CycleID = @CycleID
			WHILE EXISTS (
			SELECT tblLecture.LectureID FROM tblLecture INNER JOIN tblCycle ON tblLecture.CycleID = tblCycle.CycleID WHERE (tblCycle.CycleID = @CycleID))
			BEGIN
				SELECT @LectureID = (SELECT TOP(1) LectureID FROM tblLecture INNER JOIN tblCycle ON tblLecture.CycleID = tblCycle.CycleID WHERE (tblCycle.CycleID = @CycleID))
				exec spDeleteLecture @LectureID
			END
			DELETE tblLecturesInSemester FROM tblCycle INNER JOIN tblLecturesInSemester ON tblCycle.CycleID = tblLecturesInSemester.CycleID WHERE (tblCycle.CycleID = @CycleID)
			DELETE [tblCoursesOfStudent] WHERE CycleID = @CycleID
			DELETE FROM [tblCycle] WHERE CycleID = @CycleID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteCycleSoft]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק מחזור

CREATE PROC [site05].[spDeleteCycleSoft] -- V
@CycleID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE [tblCyclesInDepartment] WHERE CycleID = @CycleID
			UPDATE [tblStudent] SET CycleID = null WHERE CycleID = @CycleID
			DELETE [tblCoursesOfStudent] WHERE CycleID = @CycleID
			DELETE [tblCycle] WHERE CycleID = @CycleID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteDepartmentHard]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק מגמה

CREATE PROC [site05].[spDeleteDepartmentHard] -- V
@DepartmentID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @LectureID int
			DELETE tblCoursesOfStudent FROM tblCoursesOfStudent INNER JOIN tblStudent ON tblCoursesOfStudent.StudentID = tblStudent.StudentID WHERE (tblStudent.DepartmentID = @DepartmentID)
			UPDATE [tblStudent] SET DepartmentID = NULL, CycleID = NULL WHERE DepartmentID = @DepartmentID
			WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE DepartmentID = @DepartmentID)
			BEGIN
				SELECT @LectureID = (SELECT TOP(1) LectureID FROM tblLecture WHERE DepartmentID = @DepartmentID)
				EXEC spDeleteLecture @LectureID
			END
			DELETE [tblLecturesInSemester] WHERE DepartmentID = @DepartmentID
			DELETE FROM [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID
			DELETE [tblCyclesInDepartment] WHERE DepartmentID = @DepartmentID
			DELETE FROM [tblDepartment] WHERE DepartmentID = @DepartmentID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteDepartmentSoft]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spDeleteDepartmentSoft] -- V
@DepartmentID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE tblCoursesOfStudent FROM tblCoursesOfStudent INNER JOIN tblStudent ON tblCoursesOfStudent.StudentID = tblStudent.StudentID WHERE (tblStudent.DepartmentID = @DepartmentID)
			UPDATE [tblStudent] SET DepartmentID = NULL, CycleID = NULL WHERE DepartmentID = @DepartmentID
			DELETE FROM [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID
			DELETE [tblCyclesInDepartment] WHERE DepartmentID = @DepartmentID
			DELETE FROM [tblDepartment] WHERE DepartmentID = @DepartmentID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spDeleteForm]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spDeleteForm]
@FormID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT Picture FROM tblForm WHERE FormID = @FormID
			DELETE tblFormOfStudent WHERE FormID = @FormID
			DELETE tblForm WHERE FormID = @FormID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spDeleteLecture]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [site05].[spDeleteLecture] -- V
@LectureID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM tblStudentsInLecture WHERE LectureID = @LectureID
			DELETE FROM tblLecture WHERE LectureID = @LectureID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteLecturerHard]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק מרצה

CREATE PROC [site05].[spDeleteLecturerHard] -- V
@LecturerID int
AS
BEGIN
	BEGIN TRY
		IF ((SELECT tblUser.RoleID FROM tblLecturer INNER JOIN tblUser ON tblLecturer.UserID = tblUser.UserID WHERE tblLecturer.LecturerID = @LecturerID) = 2)
		BEGIN
			BEGIN TRANSACTION
				declare @UserID int = (SELECT UserID FROM tblLecturer WHERE LecturerID = @LecturerID)
				declare @LectureID int
				WHILE EXISTS (SELECT LectureID FROM [tblLecture] WHERE LecturerID = @LecturerID)
				BEGIN
					SELECT @LectureID = (SELECT TOP(1) LectureID FROM tblLecture WHERE LecturerID = @LecturerID)
					exec spDeleteLecture @LectureID
				END
				DELETE FROM [tblLecturersInCourse] WHERE LecturerID = @LecturerID
				DELETE [tblLecturesInSemester] WHERE LecturerID = @LecturerID
				DELETE FROM [tblLecturer] WHERE LecturerID = @LecturerID
				DELETE FROM tblUser WHERE UserID = @UserID
			COMMIT TRANSACTION
		END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteLecturerSoft]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- תנסה למחוק מרצה

CREATE PROC [site05].[spDeleteLecturerSoft] -- V
@LecturerID int
AS
BEGIN
	IF ((SELECT tblUser.RoleID FROM tblLecturer INNER JOIN tblUser ON tblLecturer.UserID = tblUser.UserID WHERE tblLecturer.LecturerID = @LecturerID) = 2)
	BEGIN
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblLecturer WHERE LecturerID = @LecturerID)
			DELETE FROM [tblLecturersInCourse] WHERE LecturerID = @LecturerID
			DELETE FROM [tblLecturer] WHERE LecturerID = @LecturerID
			DELETE FROM tblUser WHERE UserID = @UserID
		COMMIT TRANSACTION
	END
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteLectures]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק הרצאות לפי הזמנים של הקורס

CREATE PROC [site05].[spDeleteLectures] -- V -- spDeleteLectures
@DepartmentID int,
@CycleID int,
@WeekdayID int,
@BeginHour time,
@EndHour time,
@OpenDate date,
@EndDate date
AS
BEGIN
	DECLARE @LectureID int
	WHILE (@OpenDate <= @EndDate)
	BEGIN
		IF (DATEPART(WEEKDAY,@OpenDate) = @WeekdayID)
		BEGIN
			SET @LectureID = (SELECT LectureID FROM [tblLecture] WHERE CycleID = @CycleID AND @DepartmentID = @DepartmentID AND BeginHour = @BeginHour AND EndHour = @EndHour AND LectureDate = @OpenDate)
			EXEC spDeleteStudentsInLectures @DepartmentID, @CycleID, @LectureID
			DELETE [tblLecture] WHERE CycleID = @CycleID AND @DepartmentID = @DepartmentID AND BeginHour = @BeginHour AND EndHour = @EndHour AND LectureDate = @OpenDate
		END
		SELECT @OpenDate = DATEADD(day, 1, @OpenDate)
	END
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteLecturesInSemester]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק הגדרת זמנים לקורס

CREATE PROC [site05].[spDeleteLecturesInSemester] -- V -- spDeleteLecturesInSemester
@DepartmentID int,
@CycleID int,
@WeekdayID int,
@BeginHour time,
@EndHour time,
@OpenDate date,
@EndDate date
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE [tblLecturesInSemester] WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID AND WeekdayID = @WeekdayID AND BeginHour = @BeginHour AND EndHour = @EndHour AND OpenDate = @OpenDate AND EndDate = @EndDate
			IF (@@ROWCOUNT = 0)
			BEGIN
				ROLLBACK TRANSACTION
			END
			EXEC spDeleteLectures @DepartmentID,@CycleID,@WeekdayID,@BeginHour,@EndHour,@OpenDate,@EndDate
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteLocationManager]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spDeleteLocationManager]
@LocationManagerID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblLocationManager WHERE LocationManagerID = @LocationManagerID)
			DELETE FROM tblLocationManager WHERE LocationManagerID = @LocationManagerID
			DELETE FROM tblUser WHERE UserID = @UserID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END


GO
/****** Object:  StoredProcedure [site05].[spDeleteStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spDeleteStudent] -- V
@StudentID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @FormID int
			declare @UserID int = (SELECT UserID FROM tblStudent WHERE (StudentID = @StudentID))
			WHILE EXISTS (SELECT FormID FROM tblFormOfStudent WHERE StudentID = @StudentID)
			BEGIN
				SELECT @FormID = (SELECT TOP(1) FormID FROM tblFormOfStudent WHERE StudentID = @StudentID)
				exec spDeleteForm @FormID
			END
			DELETE FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID
			DELETE FROM [tblStudentsInLecture] WHERE StudentID = @StudentID
			DELETE FROM [tblStudent] WHERE StudentID = @StudentID
			DELETE FROM tblUser WHERE UserID = @UserID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spDeleteStudentInLecture]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק סטודנט מהרצאה לפי הרצאה

CREATE PROC [site05].[spDeleteStudentInLecture] -- V
@LectureID int,
@StudentID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM tblStudentsInLecture WHERE LectureID = @LectureID AND StudentID = @StudentID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spDeleteStudentsInLectures]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- מחק סטודנטים מהרצאות לפי מגמה והרצאה

CREATE PROC [site05].[spDeleteStudentsInLectures] -- V -- spDeleteStudentsInLectures
@DepartmentID int,
@CycleID int,
@LectureID int
AS
BEGIN
	declare @StudentID int
	WHILE EXISTS (SELECT tblStudentsInLecture.StudentID FROM tblLecture INNER JOIN tblStudentsInLecture ON tblLecture.LectureID = tblStudentsInLecture.LectureID WHERE tblLecture.DepartmentID = @DepartmentID AND tblLecture.LectureID = @LectureID AND tblLecture.CycleID = @CycleID)
	BEGIN
		Select Top 1 @StudentID = StudentID From tblLecture INNER JOIN tblStudentsInLecture ON tblLecture.LectureID = tblStudentsInLecture.LectureID WHERE tblLecture.DepartmentID = @DepartmentID AND tblLecture.LectureID = @LectureID AND tblLecture.CycleID = @CycleID
		DELETE [tblStudentsInLecture] WHERE StudentID = @StudentID AND LectureID = @LectureID
	END
END

GO
/****** Object:  StoredProcedure [site05].[spFireTimer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spFireTimer]
@LectureID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @Now datetime = GETDATE()
			declare @CurrentDate date = CONVERT(DATE, @Now)
			declare @CurrentTime time = CONVERT(TIME, @Now)
			IF EXISTS (SELECT tblLecture.LectureID FROM tblLecture	WHERE (LectureID = @LectureID) AND (tblLecture.LectureDate = @CurrentDate) AND (tblLecture.BeginHour <= @CurrentTime) AND (tblLecture.EndHour >= @CurrentTime))
			BEGIN
				declare @TimerLong int = 15 * 60
				UPDATE tblLecture SET TimerStarted = GETDATE(), TimerLong = @TimerLong WHERE LectureID = @LectureID

				UPDATE tblStudentsInLecture SET StatusID = 1 WHERE LectureID = @LectureID
				SELECT LectureID, TimerLong FROM tblLecture WHERE LectureID = @LectureID
				
				SELECT StatusID, StatusName FROM tblStatus WHERE StatusID = 1
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spGetAdministrators]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetAdministrators]
AS
BEGIN
	SELECT * FROM vwAdministrators
	ORDER BY UserID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetAdministratorsBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetAdministratorsBy] -- V
@AdministratorID int = 0,
@FirstName nvarchar(35) = '',
@LastName nvarchar(35) = ''
AS
	IF (@FirstName = '' AND @LastName = '' AND @AdministratorID <> 0)
	BEGIN
		SELECT * FROM vwAdministrators
		WHERE AdministratorID = @AdministratorID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @AdministratorID <> 0)
	BEGIN
		SELECT * FROM vwAdministrators
		WHERE AdministratorID = @AdministratorID AND FirstName LIKE '%'+@FirstName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @AdministratorID <> 0)
	BEGIN
		SELECT * FROM vwAdministrators
		WHERE AdministratorID = @AdministratorID AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @AdministratorID = 0)
	BEGIN
		SELECT * FROM vwAdministrators
		WHERE LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @AdministratorID = 0)
	BEGIN
		SELECT * FROM vwAdministrators
		WHERE FirstName LIKE '%'+@FirstName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @AdministratorID <> 0)
	BEGIN
		SELECT * FROM vwAdministrators
		WHERE @AdministratorID = @AdministratorID AND FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @AdministratorID = 0)
	BEGIN
		SELECT * FROM vwAdministrators
		WHERE FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
GO
/****** Object:  StoredProcedure [site05].[spGetClasses]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetClasses] -- V
AS
BEGIN
	SELECT * FROM vwClasses
	ORDER BY ClassID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetClassesBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetClassesBy] -- V
@ClassName nvarchar(50) = ''
AS
BEGIN
	IF (@ClassName <> '')
	BEGIN
		SELECT * FROM vwClasses
		WHERE ClassName LIKE '%'+@ClassName+'%'
		ORDER BY ClassID DESC
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetClassesByLocationManager]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [site05].[spGetClassesByLocationManager]
AS
BEGIN
	SELECT * FROM vwClasses
	WHERE IsActive = 1
	ORDER BY ClassID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetCourseDataByLecturer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCourseDataByLecturer]
@LecturerID int,
@CourseID int
AS
BEGIN

	DECLARE @DepartmentID int
	DECLARE @CycleID int
	DECLARE @DepartmentName nvarchar(50)
	DECLARE @CycleName nvarchar(50)
	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)

	SELECT DISTINCT site05.tblDepartment.DepartmentID, site05.tblCycle.CycleID, site05.tblDepartment.DepartmentName, site05.tblCycle.CycleName
	INTO #TempCoursesForLecturer
	FROM site05.tblLecturer
	INNER JOIN site05.tblLecture ON site05.tblLecturer.LecturerID = site05.tblLecture.LecturerID INNER JOIN
    site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID INNER JOIN
	site05.tblDepartment ON site05.tblLecture.DepartmentID = site05.tblDepartment.DepartmentID INNER JOIN
	site05.tblCycle ON site05.tblLecture.CycleID = site05.tblCycle.CycleID
	WHERE (site05.tblLecturer.LecturerID = @LecturerID) AND (site05.tblCourse.CourseID = @CourseID)

	WHILE EXISTS (SELECT * FROM #TempCoursesForLecturer)
	BEGIN
		Select Top 1 @DepartmentID = DepartmentID From #TempCoursesForLecturer
		Select Top 1 @CycleID = CycleID From #TempCoursesForLecturer
		Select Top 1 @DepartmentName = DepartmentName From #TempCoursesForLecturer
		Select Top 1 @CycleName = CycleName From #TempCoursesForLecturer

		declare @TotalLectureCount int = (SELECT COUNT(LectureID) FROM site05.tblLecture WHERE (LecturerID = @LecturerID) AND (CourseID = @CourseID) AND (IsCanceled = 0) AND (DepartmentID = @DepartmentID) AND (CycleID = @CycleID))

		IF (@TotalLectureCount > 0)
		BEGIN

			declare @PastLectureCount int = (SELECT COUNT(LectureID) FROM site05.tblLecture WHERE (LecturerID = @LecturerID) AND (CourseID = @CourseID) AND (IsCanceled = 0) AND (DepartmentID = @DepartmentID) AND (CycleID = @CycleID) AND ((site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			declare @StatusCount int = (SELECT COUNT(site05.tblStudentsInLecture.StudentID)
			FROM site05.tblLecture INNER JOIN site05.tblStudentsInLecture ON site05.tblLecture.LectureID = site05.tblStudentsInLecture.LectureID
			WHERE (site05.tblLecture.LecturerID = @LecturerID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblLecture.CourseID = @CourseID) AND (site05.tblLecture.DepartmentID = @DepartmentID) AND (site05.tblLecture.CycleID = @CycleID) AND ((site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			declare @MissCount int = (SELECT COUNT(site05.tblLecture.LectureID)
			FROM            site05.tblLecture INNER JOIN site05.tblStudentsInLecture ON site05.tblLecture.LectureID = site05.tblStudentsInLecture.LectureID
			WHERE        (site05.tblLecture.LecturerID = @LecturerID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 1) AND (site05.tblLecture.CourseID = @CourseID) AND (site05.tblLecture.DepartmentID = @DepartmentID) AND (site05.tblLecture.CycleID = @CycleID) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			declare @LateCount int = (SELECT COUNT(site05.tblLecture.LectureID)
			FROM            site05.tblLecture INNER JOIN site05.tblStudentsInLecture ON site05.tblLecture.LectureID = site05.tblStudentsInLecture.LectureID
			WHERE        (site05.tblLecture.LecturerID = @LecturerID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 2) AND (site05.tblLecture.CourseID = @CourseID) AND (site05.tblLecture.DepartmentID = @DepartmentID) AND (site05.tblLecture.CycleID = @CycleID) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			declare @HereCount int = (SELECT COUNT(site05.tblLecture.LectureID)
			FROM            site05.tblLecture INNER JOIN site05.tblStudentsInLecture ON site05.tblLecture.LectureID = site05.tblStudentsInLecture.LectureID
			WHERE        (site05.tblLecture.LecturerID = @LecturerID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 3) AND (site05.tblLecture.CourseID = @CourseID) AND (site05.tblLecture.DepartmentID = @DepartmentID) AND (site05.tblLecture.CycleID = @CycleID) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))
		
			declare @JustifyCount int = (SELECT COUNT(site05.tblLecture.LectureID)
			FROM            site05.tblLecture INNER JOIN site05.tblStudentsInLecture ON site05.tblLecture.LectureID = site05.tblStudentsInLecture.LectureID
			WHERE        (site05.tblLecture.LecturerID = @LecturerID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 4) AND (site05.tblLecture.CourseID = @CourseID) AND (site05.tblLecture.DepartmentID = @DepartmentID) AND (site05.tblLecture.CycleID = @CycleID) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))
		
			declare @MissPercentage decimal(4,1) = 0
			declare @LatePercentage decimal(4,1) = 0
			declare @HerePercentage decimal(4,1) = 0
			declare @JustifyPercentage decimal(4,1) = 0

			IF (@PastLectureCount <> 0 AND @StatusCount <> 0)
			BEGIN
				SET @MissPercentage = (SELECT 100 * CAST(@MissCount AS FLOAT) / @StatusCount)
				SET @LatePercentage = (SELECT 100 * CAST(@LateCount AS FLOAT) / @StatusCount)
				SET @HerePercentage = (SELECT 100 * CAST(@HereCount AS FLOAT) / @StatusCount)
				SET @JustifyPercentage = (SELECT 100 * CAST(@JustifyCount AS FLOAT) / @StatusCount)
			END

			declare @FutureLectureCount int = (SELECT COUNT(LectureID) FROM site05.tblLecture WHERE (LecturerID = @LecturerID) AND (CourseID = @CourseID) AND (DepartmentID = @DepartmentID) AND (CycleID = @CycleID) AND (IsCanceled = 0) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour >= @CurrentTime) OR (site05.tblLecture.LectureDate > @CurrentDate)))
		
			select @DepartmentID AS DepartmentID, @CycleID AS CycleID, @DepartmentName AS DepartmentName, @CycleName AS CycleName, @TotalLectureCount AS TotalLectureCount, @PastLectureCount AS PastLectureCount, @FutureLectureCount AS FutureLectureCount, @MissCount AS MissCount, @LateCount AS LateCount, @HereCount AS HereCount, @JustifyCount as JustifyCount, @MissPercentage AS MissPercentage, @LatePercentage AS LatePercentage, @HerePercentage AS HerePercentage, @JustifyPercentage AS JustifyPercentage
		END



		Delete #TempCoursesForLecturer Where (DepartmentID = @DepartmentID AND CycleID = @CycleID)
	END

END
GO
/****** Object:  StoredProcedure [site05].[spGetCourseDataByStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCourseDataByStudent]
@StudentID int,
@CourseID int
AS
BEGIN
	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)

	declare @TotalLectureCount int = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
	FROM            site05.tblStudentsInLecture INNER JOIN
							 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
	WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0))

	IF (@TotalLectureCount > 0)
	BEGIN

		declare @PastLectureCount int = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
		FROM            site05.tblStudentsInLecture INNER JOIN
								 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
		WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))
		
		declare @MissCount int = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
		FROM            site05.tblStudentsInLecture INNER JOIN
								 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
		WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 1) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

		declare @LateCount int = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
		FROM            site05.tblStudentsInLecture INNER JOIN
								 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
		WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 2) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

		declare @HereCount int = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
		FROM            site05.tblStudentsInLecture INNER JOIN
								 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
		WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 3) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

		declare @JustifyCount int = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
		FROM            site05.tblStudentsInLecture INNER JOIN
								 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
		WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 4) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

		declare @MissPercentage decimal(4,1) = 0
		declare @LatePercentage decimal(4,1) = 0
		declare @HerePercentage decimal(4,1) = 0
		declare @JustifyPercentage decimal(4,1) = 0

		IF (@PastLectureCount <> 0)
		BEGIN
			SET @MissPercentage = (SELECT 100 * CAST(@MissCount AS FLOAT) / @PastLectureCount)
			SET @LatePercentage = (SELECT 100 * CAST(@LateCount AS FLOAT) / @PastLectureCount)
			SET @HerePercentage = (SELECT 100 * CAST(@HereCount AS FLOAT) / @PastLectureCount)
			SET @JustifyPercentage = (SELECT 100 * CAST(@JustifyCount AS FLOAT) / @PastLectureCount)
		END

		declare @FutureLectureCount int = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
		FROM            site05.tblStudentsInLecture INNER JOIN
								 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
		WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour >= @CurrentTime) OR (site05.tblLecture.LectureDate > @CurrentDate)))
		
		select @TotalLectureCount AS TotalLectureCount, @PastLectureCount AS PastLectureCount, @FutureLectureCount AS FutureLectureCount, @MissCount AS MissCount, @LateCount AS LateCount, @HereCount AS HereCount, @JustifyCount AS JustifyCount, @MissPercentage AS MissPercentage, @LatePercentage AS LatePercentage, @HerePercentage AS HerePercentage, @JustifyPercentage AS JustifyPercentage
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetCourses]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCourses] -- V
AS
BEGIN
	SELECT * FROM vwCourses
	ORDER BY CourseID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetCoursesBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCoursesBy] -- V
@CourseName nvarchar(50) = ''
AS
BEGIN
	IF (@CourseName <> '')
	BEGIN
		SELECT * FROM vwCourses
		WHERE CourseName LIKE '%'+@CourseName+'%'
		ORDER BY CourseID DESC
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetCoursesByDepartment]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCoursesByDepartment] -- V -- spGetCoursesByDepartment
@DepartmentID int
AS
BEGIN
	SELECT        TOP (100) PERCENT tblCourse.CourseID, tblCourse.CourseName
	FROM            tblDepartment INNER JOIN
                         tblCoursesInDepartment ON tblDepartment.DepartmentID = tblCoursesInDepartment.DepartmentID INNER JOIN
                         tblCourse ON tblCoursesInDepartment.CourseID = tblCourse.CourseID
	WHERE        tblDepartment.DepartmentID = @DepartmentID AND tblCourse.IsActive = 1
	ORDER BY tblCourse.CourseID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetCoursesByLecturer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCoursesByLecturer] -- V -- spGetCoursesByLecturer
@LecturerID int = -1
AS
BEGIN
	SELECT        tblLecturer.LecturerID, tblCourse.CourseID, tblCourse.CourseName
	FROM            tblCourse INNER JOIN
                         tblLecturersInCourse ON tblCourse.CourseID = tblLecturersInCourse.CourseID INNER JOIN
                         tblLecturer ON tblLecturersInCourse.LecturerID = tblLecturer.LecturerID
	WHERE        (tblLecturer.LecturerID = @LecturerID) AND (tblCourse.IsActive = 1)
END
GO
/****** Object:  StoredProcedure [site05].[spGetCoursesByStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCoursesByStudent] -- V -- spGetCoursesByStudent
@StudentID int
AS
BEGIN
	SELECT        tblCourse.CourseID, tblCourse.CourseName, tblCoursesOfStudent.IsActive, tblCycle.CycleName, tblCycle.CycleID, CycleName + ' ' + CONVERT(nvarchar(10),Year) AS Name
	FROM            tblCoursesOfStudent INNER JOIN
                         tblCourse ON tblCoursesOfStudent.CourseID = tblCourse.CourseID INNER JOIN
                         tblCycle ON tblCoursesOfStudent.CycleID = tblCycle.CycleID
	WHERE        (tblCoursesOfStudent.StudentID = @StudentID) AND (tblCourse.IsActive = 1)
END
GO
/****** Object:  StoredProcedure [site05].[spGetCycles]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCycles] -- V
AS
BEGIN
	SELECT * FROM vwCycles
	ORDER BY CycleID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetCyclesBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCyclesBy] -- V
@CycleName nvarchar(50) = '',
@Year int = 0
AS
BEGIN
	IF (@CycleName <> '' AND  @Year = 0)
	BEGIN
		SELECT * FROM vwCycles
		WHERE CycleName LIKE '%'+@CycleName+'%'
		ORDER BY CycleID DESC
	END
	ELSE IF (@CycleName <> '' AND  @Year <> 0)
	BEGIN
		SELECT * FROM vwCycles
		WHERE CycleName LIKE '%'+@CycleName+'%' AND Year = @Year
		ORDER BY CycleID DESC
	END
	ELSE IF (@CycleName = '' AND  @Year <> 0)
	BEGIN
		SELECT * FROM vwCycles
		WHERE Year = @Year
		ORDER BY CycleID DESC
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetCyclesByDepartment]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetCyclesByDepartment] -- V -- spGetCyclesByDepartment
@DepartmentID int
AS
BEGIN
	SELECT        TOP (100) PERCENT tblCycle.CycleID, tblCycle.CycleName, tblCycle.CycleName + ' ' + CONVERT(nvarchar(10),Year) AS Name
FROM            tblCyclesInDepartment INNER JOIN
                         tblCycle ON tblCyclesInDepartment.CycleID = tblCycle.CycleID
WHERE        (tblCyclesInDepartment.DepartmentID = @DepartmentID) AND tblCycle.IsActive = 1
	ORDER BY tblCycle.CycleID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetDepartments]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetDepartments] -- V
AS
BEGIN
	SELECT * FROM vwDepartments
	ORDER BY DepartmentID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetDepartmentsBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetDepartmentsBy] -- V
@DepartmentName nvarchar(50) = ''
AS
BEGIN
	IF (@DepartmentName <> '')
	BEGIN
		SELECT * FROM vwDepartments
		WHERE (DepartmentName LIKE '%' + @DepartmentName + '%')
		ORDER BY DepartmentID DESC
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetDepartmentsByCourse]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- קבל את המגמות של הקורס, עם כינוי של מגמה + מחזור

CREATE PROC [site05].[spGetDepartmentsByCourse] -- V -- spGetDepartmentsByCourse
@CourseID int = -1
AS
BEGIN
	SELECT tblDepartment.DepartmentID, tblDepartment.DepartmentName
	FROM tblDepartment INNER JOIN tblCoursesInDepartment ON tblDepartment.DepartmentID = tblCoursesInDepartment.DepartmentID
	WHERE (tblCoursesInDepartment.CourseID = @CourseID)
END

GO
/****** Object:  StoredProcedure [site05].[spGetDepartmentsByCycle]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- קבל מידע על קורסים במגמה

CREATE PROC [site05].[spGetDepartmentsByCycle] -- V -- spGetDepartmentsByCycle
@CycleID int
AS
BEGIN
	SELECT        tblDepartment.DepartmentID, tblDepartment.DepartmentName
	FROM            tblCyclesInDepartment INNER JOIN
                         tblDepartment ON tblCyclesInDepartment.DepartmentID = tblDepartment.DepartmentID
	WHERE        (tblCyclesInDepartment.CycleID = @CycleID) AND tblDepartment.IsActive = 1
	ORDER BY tblDepartment.DepartmentID DESC
END

GO
/****** Object:  StoredProcedure [site05].[spGetForms]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetForms]
AS
BEGIN
	SELECT * FROM vwForms
	ORDER BY FormID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetFormsByStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetFormsByStudent]
@StudentID int = 0
AS
BEGIN
	SELECT * FROM vwForms
	WHERE StudentID = @StudentID
	ORDER BY FormID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetLecturers]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetLecturers] -- V
AS
BEGIN
	SELECT * FROM vwLecturers
	ORDER BY UserID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetLecturersBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetLecturersBy] -- V
@LecturerID int = 0,
@FirstName nvarchar(35) = '',
@LastName nvarchar(35) = ''
AS
BEGIN
	IF (@FirstName = '' AND @LastName = '' AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLecturers
		WHERE LecturerID = @LecturerID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLecturers
		WHERE LecturerID = @LecturerID AND FirstName LIKE '%'+@FirstName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLecturers
		WHERE LecturerID = @LecturerID AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLecturers
		WHERE LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLecturers
		WHERE FirstName LIKE '%'+@FirstName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLecturers
		WHERE LecturerID = @LecturerID AND FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLecturers
		WHERE FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetLecturersByCourse]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- קבל מרצים של קורס

CREATE PROC [site05].[spGetLecturersByCourse] -- V
@CourseID int
AS
BEGIN
	SELECT        tblLecturer.LecturerID, tblLecturer.FirstName + ' ' + tblLecturer.LastName AS Name
	FROM            tblLecturersInCourse INNER JOIN
							 tblLecturer ON tblLecturersInCourse.LecturerID = tblLecturer.LecturerID
	WHERE        tblLecturersInCourse.CourseID = @CourseID AND tblLecturer.IsActive = 1
END

GO
/****** Object:  StoredProcedure [site05].[spGetLectures]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetLectures]
AS
BEGIN
	SELECT * FROM vwLectures
	ORDER BY LectureID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetLecturesBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetLecturesBy] -- V
@DepartmentID int = 0,
@CycleID int = 0,
@CourseID int = 0,
@LecturerID int = 0
AS
BEGIN
	IF (@DepartmentID = 0 AND @CycleID = 0 AND @CourseID = 0 AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			LecturerID = @LecturerID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID = 0 AND @CycleID = 0 AND @CourseID <> 0 AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			CourseID = @CourseID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID = 0 AND @CycleID = 0 AND @CourseID <> 0 AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			CourseID = @CourseID AND LecturerID = @LecturerID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID = 0 AND @CycleID <> 0 AND @CourseID = 0 AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			CycleID = @CycleID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID = 0 AND @CycleID <> 0 AND @CourseID = 0 AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			CycleID = @CycleID AND LecturerID = @LecturerID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID = 0 AND @CycleID <> 0 AND @CourseID <> 0 AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			CycleID = @CycleID AND CourseID = @CourseID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID = 0 AND @CycleID <> 0 AND @CourseID <> 0 AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			CycleID = @CycleID AND CourseID = @CourseID AND LecturerID = @LecturerID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID <> 0 AND @CycleID = 0 AND @CourseID = 0 AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			DepartmentID = @DepartmentID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID <> 0 AND @CycleID = 0 AND @CourseID = 0 AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			DepartmentID = @DepartmentID AND LecturerID = @LecturerID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID <> 0 AND @CycleID = 0 AND @CourseID <> 0 AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			DepartmentID = @DepartmentID AND CourseID = @CourseID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID <> 0 AND @CycleID = 0 AND @CourseID <> 0 AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			DepartmentID = @DepartmentID AND CourseID = @CourseID AND LecturerID = @LecturerID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID <> 0 AND @CycleID <> 0 AND @CourseID = 0 AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID <> 0 AND @CycleID <> 0 AND @CourseID = 0 AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			DepartmentID = @DepartmentID AND CycleID = @CycleID AND LecturerID = @LecturerID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID <> 0 AND @CycleID <> 0 AND @CourseID <> 0 AND @LecturerID = 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			DepartmentID = @DepartmentID AND CycleID = @CycleID AND CourseID = @CourseID
		ORDER BY LectureID DESC
	END
	ELSE IF (@DepartmentID <> 0 AND @CycleID <> 0 AND @CourseID <> 0 AND @LecturerID <> 0)
	BEGIN
		SELECT * FROM vwLectures
		WHERE			DepartmentID = @DepartmentID AND CycleID = @CycleID AND CourseID = @CourseID AND LecturerID = @LecturerID
		ORDER BY LectureID DESC
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetLecturesByLecturerAndDate]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetLecturesByLecturerAndDate]
@LecturerID int,
@LectureDate date
AS
BEGIN

	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)

	SELECT        site05.tblLecture.LectureID, site05.tblLecture.LectureDate, site05.tblLecture.BeginHour, site05.tblLecture.EndHour, site05.tblLecture.IsCanceled, site05.tblCourse.CourseID, site05.tblCourse.CourseName, 
							 site05.tblDepartment.DepartmentID, site05.tblDepartment.DepartmentName, site05.tblCycle.CycleID, site05.tblCycle.CycleName, site05.tblCycle.Year, site05.tblClass.ClassID, site05.tblClass.ClassName,
							 (SELECT  cast(  CASE WHEN LectureDate < @CurrentDate THEN 1 WHEN LectureDate > @CurrentDate THEN 0 WHEN LectureDate = @CurrentDate AND BeginHour <= @CurrentTime AND EndHour >= @CurrentTime THEN 0 WHEN LectureDate = @CurrentDate AND BeginHour >= @CurrentTime THEN 0 WHEN LectureDate = @CurrentDate AND EndHour <= @CurrentTime THEN 1 ELSE 0 END as bit ) )  AS IsOld
	FROM            site05.tblLecture INNER JOIN
							 site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID INNER JOIN
							 site05.tblDepartment ON site05.tblLecture.DepartmentID = site05.tblDepartment.DepartmentID INNER JOIN
							 site05.tblCycle ON site05.tblLecture.CycleID = site05.tblCycle.CycleID INNER JOIN
							 site05.tblLecturer ON site05.tblLecture.LecturerID = site05.tblLecturer.LecturerID INNER JOIN
							 site05.tblClass ON site05.tblLecture.ClassID = site05.tblClass.ClassID
	WHERE        (site05.tblLecture.LectureDate = @LectureDate) AND (tblLecturer.LecturerID = @LecturerID)
	ORDER BY BeginHour
END
GO
/****** Object:  StoredProcedure [site05].[spGetLecturesByStudentAndDate]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetLecturesByStudentAndDate]
@StudentID int,
@LectureDate date
AS
BEGIN

	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)

	SELECT        site05.tblLecture.LectureID, site05.tblLecture.LectureDate, site05.tblLecture.BeginHour, site05.tblLecture.EndHour, site05.tblLecture.IsCanceled, site05.tblCourse.CourseID, site05.tblCourse.CourseName, 
                         site05.tblDepartment.DepartmentID, site05.tblDepartment.DepartmentName, site05.tblCycle.CycleID, site05.tblCycle.CycleName, site05.tblCycle.Year, site05.tblClass.ClassID, site05.tblClass.ClassName, 
                         site05.tblLecturer.LecturerID, site05.tblLecturer.FirstName, site05.tblLecturer.LastName, site05.tblStatus.StatusID, site05.tblStatus.StatusName,
                             (SELECT  cast(  CASE WHEN LectureDate < @CurrentDate THEN 1 WHEN LectureDate > @CurrentDate THEN 0 WHEN LectureDate = @CurrentDate AND BeginHour <= @CurrentTime AND EndHour >= @CurrentTime THEN 0 WHEN LectureDate = @CurrentDate AND BeginHour >= @CurrentTime THEN 0 WHEN LectureDate = @CurrentDate AND EndHour <= @CurrentTime THEN 1 ELSE 0 END as bit ) )  AS IsOld
	FROM            site05.tblLecture INNER JOIN
							 site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID INNER JOIN
							 site05.tblDepartment ON site05.tblLecture.DepartmentID = site05.tblDepartment.DepartmentID INNER JOIN
							 site05.tblCycle ON site05.tblLecture.CycleID = site05.tblCycle.CycleID INNER JOIN
							 site05.tblLecturer ON site05.tblLecture.LecturerID = site05.tblLecturer.LecturerID INNER JOIN
							 site05.tblClass ON site05.tblLecture.ClassID = site05.tblClass.ClassID INNER JOIN
							 site05.tblStudentsInLecture ON site05.tblLecture.LectureID = site05.tblStudentsInLecture.LectureID INNER JOIN
							 site05.tblStatus ON site05.tblStudentsInLecture.StatusID = site05.tblStatus.StatusID
	WHERE        (site05.tblLecture.LectureDate = @LectureDate) AND (site05.tblStudentsInLecture.StudentID = @StudentID)
	ORDER BY BeginHour
END
GO
/****** Object:  StoredProcedure [site05].[spGetLecturesInSemesters]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- קבל קורסים בזמנים

CREATE PROC [site05].[spGetLecturesInSemesters] -- V -- spGetLecturesInSemesters
AS
BEGIN
	SELECT        tblCourse.CourseID, tblCourse.CourseName, tblDepartment.DepartmentID, tblDepartment.DepartmentName, tblCycle.CycleID, tblCycle.CycleName, tblClass.ClassID, tblClass.ClassName, 
                         tblLecturer.LecturerID, tblLecturer.FirstName + N' ' + tblLecturer.LastName AS Name, tblWeekday.WeekdayID, tblWeekday.WeekdayName, tblLecturesInSemester.BeginHour, tblLecturesInSemester.EndHour, 
                         tblLecturesInSemester.OpenDate, tblLecturesInSemester.EndDate, tblCycle.CycleName + ' ' + CONVERT(nvarchar(10),Year) AS CycleFullName
FROM            tblLecturesInSemester INNER JOIN
                         tblCourse ON tblLecturesInSemester.CourseID = tblCourse.CourseID INNER JOIN
                         tblDepartment ON tblLecturesInSemester.DepartmentID = tblDepartment.DepartmentID INNER JOIN
                         tblCycle ON tblLecturesInSemester.CycleID = tblCycle.CycleID INNER JOIN
                         tblClass ON tblLecturesInSemester.ClassID = tblClass.ClassID INNER JOIN
                         tblLecturer ON tblLecturesInSemester.LecturerID = tblLecturer.LecturerID INNER JOIN
                         tblWeekday ON tblLecturesInSemester.WeekdayID = tblWeekday.WeekdayID
END

GO
/****** Object:  StoredProcedure [site05].[spGetLocationManagers]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetLocationManagers]
AS
BEGIN
	SELECT * FROM vwLocationManagers
	ORDER BY UserID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetLocationManagersBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROC [site05].[spGetLocationManagersBy] -- V
@LocationManagerID int = 0,
@FirstName nvarchar(35) = '',
@LastName nvarchar(35) = ''
AS
	IF (@FirstName = '' AND @LastName = '' AND @LocationManagerID <> 0)
	BEGIN
		SELECT * FROM vwLocationManagers
		WHERE LocationManagerID = @LocationManagerID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @LocationManagerID <> 0)
	BEGIN
		SELECT * FROM vwLocationManagers
		WHERE LocationManagerID = @LocationManagerID AND FirstName LIKE '%'+@FirstName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @LocationManagerID <> 0)
	BEGIN
		SELECT * FROM vwLocationManagers
		WHERE LocationManagerID = @LocationManagerID AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @LocationManagerID = 0)
	BEGIN
		SELECT * FROM vwLocationManagers
		WHERE LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @LocationManagerID = 0)
	BEGIN
		SELECT * FROM vwLocationManagers
		WHERE FirstName LIKE '%'+@FirstName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @LocationManagerID <> 0)
	BEGIN
		SELECT * FROM vwLocationManagers
		WHERE @LocationManagerID = @LocationManagerID AND FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @LocationManagerID = 0)
	BEGIN
		SELECT * FROM vwLocationManagers
		WHERE FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
GO
/****** Object:  StoredProcedure [site05].[spGetNextLectureByLecturer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetNextLectureByLecturer]
@LecturerID int,
@IsLive bit output,
@IsExist bit output
AS
BEGIN
	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)
	declare @LectureID int
	declare @TimerStarted datetime

	IF EXISTS (SELECT LectureID FROM tblLecture WHERE (LecturerID = @LecturerID) AND (LectureDate = @CurrentDate) AND (BeginHour <= @CurrentTime) AND (EndHour >= @CurrentTime))
	BEGIN
		set @IsExist = 1
		set @IsLive = 1
		set @LectureID = (SELECT LectureID FROM tblLecture WHERE (LecturerID = @LecturerID) AND (LectureDate = @CurrentDate) AND (BeginHour <= @CurrentTime) AND (EndHour >= @CurrentTime))
		SET @TimerStarted = (SELECT TimerStarted FROM tblLecture WHERE LectureID = @LectureID)
		declare @TimerLong int = (SELECT TimerLong FROM tblLecture WHERE LectureID = @LectureID)
		declare @TimerElapsed int = Datediff(s, @TimerStarted, @Now)
		declare @TimerRemaining int = @TimerLong - @TimerElapsed
		declare @LectureDate date = (SELECT LectureDate From tblLecture WHERE LectureID = @LectureID)
		declare @EndHour time = (SELECT EndHour From tblLecture WHERE LectureID = @LectureID)
		declare @MinutesToEnd int = DATEDIFF(MINUTE, @Now, CAST(@LectureDate AS datetime) + CAST(@EndHour AS datetime))
		
		IF (@TimerRemaining IS NULL)
		BEGIN
			SET @TimerRemaining = 0
		END


		SELECT        tblLecture.LectureID, tblLecture.LectureDate, tblLecture.BeginHour, tblLecture.EndHour, tblLecture.Iscanceled, tblCourse.CourseID, tblCourse.CourseName, tblDepartment.DepartmentID, 
                        tblDepartment.DepartmentName, tblCycle.CycleID, tblCycle.CycleName, tblCycle.Year, tblClass.ClassID, tblClass.ClassName, tblClass.Longitude, tblClass.Latitude, tblLecture.TimerLong, @TimerRemaining as TimerRemaining, @MinutesToEnd as MinutesToEnd
		FROM            tblLecture INNER JOIN
                        tblCourse ON tblLecture.CourseID = tblCourse.CourseID INNER JOIN
                        tblDepartment ON tblLecture.DepartmentID = tblDepartment.DepartmentID INNER JOIN
                        tblCycle ON tblLecture.CycleID = tblCycle.CycleID INNER JOIN
                        tblLecturer ON tblLecture.LecturerID = tblLecturer.LecturerID INNER JOIN
                        tblClass ON tblLecture.ClassID = tblClass.ClassID
		WHERE			(tblLecture.LectureID = @LectureID)
		--WHERE			(tblLecturer.LecturerID = @LecturerID) AND (LectureDate = @CurrentDate) AND (BeginHour <= @CurrentTime) AND (EndHour >= @CurrentTime)
		
		SELECT        site05.tblStudent.StudentID, site05.tblStudent.FirstName, site05.tblStudent.LastName, site05.tblStudent.Picture, site05.tblStatus.StatusID, site05.tblStatus.StatusName
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID INNER JOIN
                         site05.tblStatus ON site05.tblStudentsInLecture.StatusID = site05.tblStatus.StatusID
		WHERE        (tblStudentsInLecture.LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1)
		ORDER BY tblStudent.LastName + ' ' + tblStudent.FirstName
		
		declare @MissCount int = (select COUNT(*)
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
		WHERE        (StatusID = 1) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

		declare @LateCount int = (select COUNT(*)
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
		WHERE        (StatusID = 2) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

		declare @HereCount int = (select COUNT(*)
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
		WHERE        (StatusID = 3) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

		declare @JustifyCount int = (select COUNT(*)
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
		WHERE        (StatusID = 4) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

		SELECT @MissCount as MissCount, @LateCount as LateCount, @HereCount as HereCount, @JustifyCount as JustifyCount

	END
	ELSE IF EXISTS (SELECT LectureID FROM tblLecture WHERE (LecturerID = @LecturerID) AND (LectureDate = @CurrentDate) AND (BeginHour >= @CurrentTime))
	BEGIN
		set @IsExist = 1
		set @IsLive = 0
		
		set @LectureID = (SELECT LectureID FROM tblLecture WHERE (LecturerID = @LecturerID) AND (LectureDate = @CurrentDate) AND (BeginHour >= @CurrentTime))
		SET @TimerStarted = (SELECT TimerStarted FROM tblLecture WHERE LectureID = @LectureID)
		declare @MinutesToBegin int = DATEDIFF(MINUTE, @Now, @TimerStarted)




		SELECT        top 1 tblLecture.LectureID, tblLecture.LectureDate, tblLecture.BeginHour, tblLecture.EndHour, tblLecture.Iscanceled, tblCourse.CourseID, tblCourse.CourseName, tblDepartment.DepartmentID, 
                         tblDepartment.DepartmentName, tblCycle.CycleID, tblCycle.CycleName, tblCycle.Year, tblClass.ClassID, tblClass.ClassName, tblClass.Longitude, tblClass.Latitude, @MinutesToBegin as MinutesToBegin
		FROM            tblLecture INNER JOIN
                         tblCourse ON tblLecture.CourseID = tblCourse.CourseID INNER JOIN
                         tblDepartment ON tblLecture.DepartmentID = tblDepartment.DepartmentID INNER JOIN
                         tblCycle ON tblLecture.CycleID = tblCycle.CycleID INNER JOIN
                         tblLecturer ON tblLecture.LecturerID = tblLecturer.LecturerID INNER JOIN
                         tblClass ON tblLecture.ClassID = tblClass.ClassID
		WHERE			(tblLecture.LectureID = @LectureID)
	END
	ELSE
	BEGIN
		set @IsExist = 0
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetNextLectureByStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetNextLectureByStudent]
@StudentID int,
@IsLive bit output,
@IsExist bit output
AS
BEGIN
	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)
	declare @LectureID int
	declare @TimerStarted datetime
	declare @CourseID int
	declare @TotalLectureCount int
	declare @PastLectureCount int
	declare @MissCount int
	declare @LateCount int
	declare @HereCount int
	declare @JustifyCount int
	declare @MissPercentage decimal(4,1) = 0
	declare @LatePercentage decimal(4,1) = 0
	declare @HerePercentage decimal(4,1) = 0
	declare @JustifyPercentage decimal(4,1) = 0
	declare @FutureLectureCount int

	IF EXISTS (SELECT tblLecture.LectureID
				FROM tblStudentsInLecture INNER JOIN tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID
				WHERE (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.LectureDate = @CurrentDate) AND (tblLecture.BeginHour <= @CurrentTime) AND (tblLecture.EndHour >= @CurrentTime))
	BEGIN
		SET @IsExist = 1
		SET @IsLive = 1
		SET @LectureID = (SELECT tblLecture.LectureID FROM tblStudentsInLecture INNER JOIN tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID WHERE (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.LectureDate = @CurrentDate) AND (tblLecture.BeginHour <= @CurrentTime) AND (tblLecture.EndHour >= @CurrentTime))
		SET @CourseID = (SELECT CourseID FROM tblLecture WHERE LectureID = @LectureID)
		SET @TimerStarted = (SELECT TimerStarted FROM tblLecture WHERE LectureID = @LectureID)
		declare @TimerLong int = (SELECT TimerLong FROM tblLecture WHERE LectureID = @LectureID)
		declare @TimerElapsed int = Datediff(s, @TimerStarted, @Now)
		declare @TimerRemaining int = @TimerLong - @TimerElapsed
		declare @LectureDate date = (SELECT LectureDate From tblLecture WHERE LectureID = @LectureID)
		declare @EndHour time = (SELECT EndHour From tblLecture WHERE LectureID = @LectureID)
		declare @MinutesToEnd int = DATEDIFF(MINUTE, @Now, CAST(@LectureDate AS datetime) + CAST(@EndHour AS datetime))
		IF (@TimerRemaining IS NULL)
		BEGIN
			SET @TimerRemaining = 0
		END




		SET @TotalLectureCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
		FROM            site05.tblStudentsInLecture INNER JOIN
								 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
		WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0))

		IF (@TotalLectureCount > 0)
		BEGIN

			SET @PastLectureCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))
		
			SET @MissCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 1) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			SET @LateCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 2) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			SET @HereCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 3) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			SET @JustifyCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 4) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			IF (@PastLectureCount <> 0)
			BEGIN
				SET @MissPercentage = (SELECT 100 * CAST(@MissCount AS FLOAT) / @PastLectureCount)
				SET @LatePercentage = (SELECT 100 * CAST(@LateCount AS FLOAT) / @PastLectureCount)
				SET @HerePercentage = (SELECT 100 * CAST(@HereCount AS FLOAT) / @PastLectureCount)
				SET @JustifyPercentage = (SELECT 100 * CAST(@JustifyCount AS FLOAT) / @PastLectureCount)
			END

			SET @FutureLectureCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour >= @CurrentTime) OR (site05.tblLecture.LectureDate > @CurrentDate)))
		
			--select @TotalLectureCount AS TotalLectureCount, @PastLectureCount AS PastLectureCount, @FutureLectureCount AS FutureLectureCount, @MissCount AS MissCount, @LateCount AS LateCount, @HereCount AS HereCount, @JustifyCount AS JustifyCount, @MissPercentage AS MissPercentage, @LatePercentage AS LatePercentage, @HerePercentage AS HerePercentage, @JustifyPercentage AS JustifyPercentage
		END





		SELECT        tblLecture.LectureID, tblLecture.LectureDate, tblLecture.BeginHour, tblLecture.EndHour, tblLecture.Iscanceled, tblCourse.CourseID, tblCourse.CourseName, tblDepartment.DepartmentID, 
						 tblDepartment.DepartmentName, tblCycle.CycleID, tblCycle.CycleName, tblCycle.Year, tblClass.ClassID, tblClass.ClassName, tblClass.Longitude, tblClass.Latitude, tblLecturer.LecturerID, 
						 tblLecturer.FirstName, tblLecturer.LastName, tblLecturer.Picture, tblStatus.StatusID, tblStatus.StatusName, tblLecture.TimerLong, @TimerRemaining as TimerRemaining, tblLecturer.QRMode, @MinutesToEnd as MinutesToEnd, @TotalLectureCount AS TotalLectureCount, @PastLectureCount AS PastLectureCount, @FutureLectureCount AS FutureLectureCount, @MissCount AS MissCount, @LateCount AS LateCount, @HereCount AS HereCount, @JustifyCount AS JustifyCount, @MissPercentage AS MissPercentage, @LatePercentage AS LatePercentage, @HerePercentage AS HerePercentage, @JustifyPercentage AS JustifyPercentage
		FROM            tblStudentsInLecture INNER JOIN
						 tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID INNER JOIN
						 tblCourse ON tblLecture.CourseID = tblCourse.CourseID INNER JOIN
						 tblDepartment ON tblLecture.DepartmentID = tblDepartment.DepartmentID INNER JOIN
						 tblCycle ON tblLecture.CycleID = tblCycle.CycleID INNER JOIN
						 tblLecturer ON tblLecture.LecturerID = tblLecturer.LecturerID INNER JOIN
						 tblClass ON tblLecture.ClassID = tblClass.ClassID INNER JOIN
						 tblStatus ON tblStudentsInLecture.StatusID = tblStatus.StatusID
		WHERE        (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.LectureDate = @CurrentDate) AND (tblLecture.BeginHour <= @CurrentTime) AND (tblLecture.EndHour >= @CurrentTime)
		
	END
	ELSE IF EXISTS (SELECT tblLecture.LectureID
					FROM tblStudentsInLecture INNER JOIN tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID
					WHERE (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.LectureDate = @CurrentDate) AND (BeginHour >= @CurrentTime))
	BEGIN
		SET @IsExist = 1
		SET @IsLive = 0
		SET @LectureID = (SELECT tblLecture.LectureID FROM tblStudentsInLecture INNER JOIN tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID WHERE (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.LectureDate = @CurrentDate) AND (BeginHour >= @CurrentTime))
		SET @CourseID = (SELECT CourseID FROM tblLecture WHERE LectureID = @LectureID)
		SET @TimerStarted = (SELECT TimerStarted FROM tblLecture WHERE LectureID = @LectureID)
		declare @MinutesToBegin int = DATEDIFF(MINUTE, @Now, @TimerStarted)






		SET @TotalLectureCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
		FROM            site05.tblStudentsInLecture INNER JOIN
								 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
		WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0))

		IF (@TotalLectureCount > 0)
		BEGIN

			SET @PastLectureCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))
		
			SET @MissCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 1) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			SET @LateCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 2) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			SET @HereCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 3) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			SET @JustifyCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND (site05.tblStudentsInLecture.StatusID = 4) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour <= @CurrentTime) OR (site05.tblLecture.LectureDate < @CurrentDate)))

			IF (@PastLectureCount <> 0)
			BEGIN
				SET @MissPercentage = (SELECT 100 * CAST(@MissCount AS FLOAT) / @PastLectureCount)
				SET @LatePercentage = (SELECT 100 * CAST(@LateCount AS FLOAT) / @PastLectureCount)
				SET @HerePercentage = (SELECT 100 * CAST(@HereCount AS FLOAT) / @PastLectureCount)
				SET @JustifyPercentage = (SELECT 100 * CAST(@JustifyCount AS FLOAT) / @PastLectureCount)
			END

			SET @FutureLectureCount = (SELECT COUNT(site05.tblStudentsInLecture.StatusID)
			FROM            site05.tblStudentsInLecture INNER JOIN
									 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
			WHERE        (site05.tblLecture.CourseID = @CourseID) AND (site05.tblStudentsInLecture.StudentID = @StudentID) AND (site05.tblLecture.IsCanceled = 0) AND ( (site05.tblLecture.LectureDate = @CurrentDate AND site05.tblLecture.EndHour >= @CurrentTime) OR (site05.tblLecture.LectureDate > @CurrentDate)))
		
			--select @TotalLectureCount AS TotalLectureCount, @PastLectureCount AS PastLectureCount, @FutureLectureCount AS FutureLectureCount, @MissCount AS MissCount, @LateCount AS LateCount, @HereCount AS HereCount, @JustifyCount AS JustifyCount, @MissPercentage AS MissPercentage, @LatePercentage AS LatePercentage, @HerePercentage AS HerePercentage, @JustifyPercentage AS JustifyPercentage
		END







		SELECT        tblLecture.LectureID, tblLecture.LectureDate, tblLecture.BeginHour, tblLecture.EndHour, tblLecture.Iscanceled, tblCourse.CourseID, tblCourse.CourseName, tblDepartment.DepartmentID, 
                         tblDepartment.DepartmentName, tblCycle.CycleID, tblCycle.CycleName, tblCycle.Year, tblClass.ClassID, tblClass.ClassName, tblClass.Longitude, tblClass.Latitude, tblLecturer.LecturerID, 
                         tblLecturer.FirstName, tblLecturer.LastName, tblLecturer.Picture, @MinutesToBegin as MinutesToBegin, @TotalLectureCount AS TotalLectureCount, @PastLectureCount AS PastLectureCount, @FutureLectureCount AS FutureLectureCount, @MissCount AS MissCount, @LateCount AS LateCount, @HereCount AS HereCount, @JustifyCount AS JustifyCount, @MissPercentage AS MissPercentage, @LatePercentage AS LatePercentage, @HerePercentage AS HerePercentage, @JustifyPercentage AS JustifyPercentage
		FROM            tblStudentsInLecture INNER JOIN
                         tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID INNER JOIN
                         tblCourse ON tblLecture.CourseID = tblCourse.CourseID INNER JOIN
                         tblDepartment ON tblLecture.DepartmentID = tblDepartment.DepartmentID INNER JOIN
                         tblCycle ON tblLecture.CycleID = tblCycle.CycleID INNER JOIN
                         tblLecturer ON tblLecture.LecturerID = tblLecturer.LecturerID INNER JOIN
                         tblClass ON tblLecture.ClassID = tblClass.ClassID
		WHERE (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.LectureDate = @CurrentDate) AND (BeginHour >= @CurrentTime)
	END
	ELSE
	BEGIN
		SET @IsExist = 0
	END
END
GO
/****** Object:  StoredProcedure [site05].[spGetNumberOfWaitingForms]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetNumberOfWaitingForms]
AS
BEGIN
	SELECT COUNT(FormID) as FormsCount FROM tblForm WHERE FormStatusID = 1
END
GO
/****** Object:  StoredProcedure [site05].[spGetStatuses]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetStatuses] -- V
AS
BEGIN
	SELECT * FROM vwStatuses
END
GO
/****** Object:  StoredProcedure [site05].[spGetStudents]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetStudents]
AS
BEGIN
	SELECT * FROM vwStudents
	ORDER BY UserID DESC
END
GO
/****** Object:  StoredProcedure [site05].[spGetStudentsBy]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetStudentsBy] -- V
@StudentID int = 0,
@FirstName nvarchar(35) = '',
@LastName nvarchar(35) = '',
@DepartmentID int = 0,
@CycleID int = 0
AS
BEGIN
	IF (@FirstName = '' AND @LastName = '' AND @StudentID <> 0 AND @DepartmentID = 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName = '' AND @StudentID <> 0 AND @DepartmentID = 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName = '' AND @StudentID <> 0 AND @DepartmentID <> 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND DepartmentID = @DepartmentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName = '' AND @StudentID <> 0 AND @DepartmentID <> 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @StudentID <> 0 AND @DepartmentID = 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND FirstName LIKE '%'+@FirstName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @StudentID <> 0 AND @DepartmentID = 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND FirstName LIKE '%'+@FirstName+'%' AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @StudentID <> 0 AND @DepartmentID <> 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND FirstName LIKE '%'+@FirstName+'%' AND DepartmentID = @DepartmentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @StudentID <> 0 AND @DepartmentID <> 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND FirstName LIKE '%'+@FirstName+'%' AND DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @StudentID <> 0 AND @DepartmentID = 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @StudentID <> 0 AND @DepartmentID = 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND LastName LIKE '%'+@LastName+'%' AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @StudentID <> 0 AND @DepartmentID <> 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND LastName LIKE '%'+@LastName+'%' AND DepartmentID = @DepartmentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @StudentID <> 0 AND @DepartmentID <> 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND LastName LIKE '%'+@LastName+'%' AND DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName = '' AND @StudentID = 0  AND @DepartmentID = 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName = '' AND @StudentID = 0  AND @DepartmentID <> 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE DepartmentID = @DepartmentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName = '' AND @StudentID = 0  AND @DepartmentID <> 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @StudentID = 0  AND @DepartmentID = 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @StudentID = 0  AND @DepartmentID = 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE LastName LIKE '%'+@LastName+'%' AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @StudentID = 0  AND @DepartmentID <> 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE LastName LIKE '%'+@LastName+'%' AND DepartmentID = @DepartmentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName = '' AND @LastName <> '' AND @StudentID = 0  AND @DepartmentID <> 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE LastName LIKE '%'+@LastName+'%' AND DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @StudentID = 0 AND @DepartmentID = 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE FirstName LIKE '%'+@FirstName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @StudentID = 0 AND @DepartmentID = 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE FirstName LIKE '%'+@FirstName+'%' AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @StudentID = 0 AND @DepartmentID <> 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE FirstName LIKE '%'+@FirstName+'%' AND DepartmentID = @DepartmentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName = '' AND @StudentID = 0 AND @DepartmentID <> 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE FirstName LIKE '%'+@FirstName+'%' AND DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @StudentID <> 0 AND @DepartmentID = 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @StudentID <> 0 AND @DepartmentID = 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%' AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @StudentID <> 0 AND @DepartmentID <> 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%' AND DepartmentID = @DepartmentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @StudentID <> 0 AND @DepartmentID <> 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE StudentID = @StudentID AND FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%' AND DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @StudentID = 0 AND @DepartmentID = 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%'
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @StudentID = 0 AND @DepartmentID = 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%' AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @StudentID = 0 AND @DepartmentID <> 0 AND @CycleID = 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%' AND DepartmentID = @DepartmentID
		ORDER BY UserID DESC
	END
	ELSE IF (@FirstName <> '' AND @LastName <> '' AND @StudentID = 0 AND @DepartmentID <> 0 AND @CycleID <> 0)
	BEGIN
		SELECT * FROM vwStudents
		WHERE FirstName LIKE '%'+@FirstName+'%' AND LastName LIKE '%'+@LastName+'%' AND DepartmentID = @DepartmentID AND CycleID = @CycleID
		ORDER BY UserID DESC
	END
END

GO
/****** Object:  StoredProcedure [site05].[spGetStudentsByLecture]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetStudentsByLecture] -- V -- spGetStudentsByLecture
@LectureID int
AS
BEGIN
	SELECT        tblStudentsInLecture.LectureID, tblStudentsInLecture.StudentID, tblStudent.LastName + ' ' + tblStudent.FirstName AS Name , tblStatus.StatusName, tblStatus.StatusID
	FROM            tblStudentsInLecture INNER JOIN
							 tblStatus ON tblStudentsInLecture.StatusID = tblStatus.StatusID INNER JOIN
							 tblStudent ON tblStudentsInLecture.StudentID = tblStudent.StudentID
	WHERE        tblStudentsInLecture.LectureID = @LectureID AND tblStudent.IsActive = 1
	ORDER BY tblStudent.LastName + ' ' + tblStudent.FirstName
END
GO
/****** Object:  StoredProcedure [site05].[spGetStudentsInLectureByLecture]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetStudentsInLectureByLecture]
@LectureID int
AS
BEGIN
	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)
	SELECT        site05.tblStudent.StudentID, site05.tblStudent.FirstName, site05.tblStudent.LastName, site05.tblStudent.Picture, site05.tblStatus.StatusID, site05.tblStatus.StatusName
	FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID INNER JOIN
                         site05.tblStatus ON site05.tblStudentsInLecture.StatusID = site05.tblStatus.StatusID INNER JOIN
                         site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID
	WHERE        (site05.tblStudentsInLecture.LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1)
	ORDER BY tblStudent.LastName + ' ' + tblStudent.FirstName

	declare @MissCount int = (select COUNT(*)
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
		WHERE        (StatusID = 1) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

		declare @LateCount int = (select COUNT(*)
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
		WHERE        (StatusID = 2) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

		declare @HereCount int = (select COUNT(*)
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
		WHERE        (StatusID = 3) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

		declare @JustifyCount int = (select COUNT(*)
		FROM            site05.tblStudentsInLecture INNER JOIN
                         site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
		WHERE        (StatusID = 4) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

		SELECT @MissCount as MissCount, @LateCount as LateCount, @HereCount as HereCount, @JustifyCount as JustifyCount
END
GO
/****** Object:  StoredProcedure [site05].[spGetWeekdays]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spGetWeekdays] -- V
AS
BEGIN
	SELECT * FROM vwWeekdays
END
GO
/****** Object:  StoredProcedure [site05].[spReplaceCoursesOfDepartment]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל הקורסים שאתה רוצה שיהיו במגמה

CREATE PROC [site05].[spReplaceCoursesOfDepartment] -- V -- spReplaceCoursesOfDepartment
@ListOfCourses nvarchar(max),
@DepartmentID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempCourseInDepartment FROM tblCoursesInDepartment WHERE DepartmentID = @DepartmentID
			DECLARE @LectureID int
			Declare @CourseID int
			declare @StudentID int
			DELETE [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID
			Select * Into #Temp From tblCourse WHERE @ListOfCourses like '%;'+cast(CourseID as nvarchar(20))+';%'
			SELECT * INTO #TempCoursesRemoved From #TempCourseInDepartment WHERE (CourseID NOT IN
                      (SELECT CourseID FROM #Temp))
			WHILE EXISTS (SELECT CourseID FROM #TempCoursesRemoved)
			BEGIN
				Select Top 1 @CourseID = CourseID From #TempCoursesRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE CourseID = @CourseID AND DepartmentID = @DepartmentID)
				BEGIN
					Select Top 1 @LectureID = LectureID From tblLecture WHERE CourseID = @CourseID AND DepartmentID = @DepartmentID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE CourseID = @CourseID AND DepartmentID = @DepartmentID
				SELECT * INTO #TempStudents FROM [tblStudent] WHERE DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents)
					DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID
					DELETE #TempStudents WHERE StudentID = @StudentID
				END
				drop table #TempStudents
				Delete #TempCoursesRemoved Where CourseID = @CourseID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @CourseID = CourseID From #Temp
				INSERT [tblCoursesInDepartment] ([CourseID], [DepartmentID]) Values (@CourseID,@DepartmentID)
				SELECT * INTO #TempStudents2 FROM [tblStudent] WHERE DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents2)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents2)
					IF NOT EXISTS (SELECT StudentID FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID)
					BEGIN
						INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID))
					END
					DELETE #TempStudents2 WHERE StudentID = @StudentID
				END
				drop table #TempStudents2
				Delete #Temp Where CourseID = @CourseID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceCoursesOfDepartmentTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל הקורסים שאתה רוצה שיהיו במגמה

CREATE PROC [site05].[spReplaceCoursesOfDepartmentTry] -- V -- spReplaceCoursesOfDepartmentTry
@ListOfCourses nvarchar(max),
@DepartmentID int
AS
BEGIN
	declare @IsDeletingLectures bit = 0
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempCourseInDepartment FROM tblCoursesInDepartment WHERE DepartmentID = @DepartmentID
			DECLARE @LectureID int
			Declare @CourseID int
			declare @StudentID int
			DELETE [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID
			Select * Into #Temp From tblCourse WHERE @ListOfCourses like '%;'+cast(CourseID as nvarchar(20))+';%'
			SELECT * INTO #TempCoursesRemoved From #TempCourseInDepartment WHERE (CourseID NOT IN
                      (SELECT CourseID FROM #Temp))
			WHILE EXISTS (SELECT CourseID FROM #TempCoursesRemoved)
			BEGIN
				Select Top 1 @CourseID = CourseID From #TempCoursesRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE CourseID = @CourseID AND DepartmentID = @DepartmentID)
				BEGIN
					SET @IsDeletingLectures = 1
					Select Top 1 @LectureID = LectureID From tblLecture WHERE CourseID = @CourseID AND DepartmentID = @DepartmentID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE CourseID = @CourseID AND DepartmentID = @DepartmentID
				SELECT * INTO #TempStudents FROM [tblStudent] WHERE DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents)
					DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID
					DELETE #TempStudents WHERE StudentID = @StudentID
				END
				drop table #TempStudents
				Delete #TempCoursesRemoved Where CourseID = @CourseID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @CourseID = CourseID From #Temp
				INSERT [tblCoursesInDepartment] ([CourseID], [DepartmentID]) Values (@CourseID,@DepartmentID)
				SELECT * INTO #TempStudents2 FROM [tblStudent] WHERE DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents2)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents2)
					IF NOT EXISTS (SELECT StudentID FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID)
					BEGIN
						INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID))
					END
					DELETE #TempStudents2 WHERE StudentID = @StudentID
				END
				drop table #TempStudents2
				Delete #Temp Where CourseID = @CourseID
			END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
	IF (@IsDeletingLectures = 1)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('הקורס/ים שאתה מתכוון להסיר מהמגמה רשומ/ים להרצאות. ההרצאות ימחקו', 16, 1)
		RETURN
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	END
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceCoursesOfLecturer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל הקורסים שאתה רוצה שהמרצה ילמד

CREATE PROC [site05].[spReplaceCoursesOfLecturer] -- V -- spReplaceCoursesOfLecturer
@ListOfCourses nvarchar(max),
@LecturerID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempLecturerInCourse FROM tblLecturersInCourse WHERE LecturerID = @LecturerID
			DECLARE @LectureID int
			Declare @CourseID int
			DELETE [tblLecturersInCourse] WHERE LecturerID = @LecturerID
			Select * Into #Temp From tblCourse WHERE @ListOfCourses like '%;'+cast(CourseID as nvarchar(20))+';%'
			SELECT * INTO #TempCoursesRemoved From #TempLecturerInCourse WHERE (CourseID NOT IN
                      (SELECT CourseID FROM #Temp))
			WHILE EXISTS (SELECT CourseID FROM #TempCoursesRemoved)
			BEGIN
				Select Top 1 @CourseID = CourseID From #TempCoursesRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE CourseID = @CourseID AND LecturerID = @LecturerID)
				BEGIN
					Select Top 1 @LectureID = LectureID From tblLecture WHERE CourseID = @CourseID AND LecturerID = @LecturerID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE CourseID = @CourseID AND LecturerID = @LecturerID
				Delete #TempCoursesRemoved Where CourseID = @CourseID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @CourseID = CourseID From #Temp 
				INSERT [tblLecturersInCourse] ([CourseID], [LecturerID]) Values (@CourseID,@LecturerID)
				Delete #Temp Where CourseID = @CourseID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceCoursesOfLecturerTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הוסף קורס למגמה

--CREATE PROC spAddCourseToDepartment
--@CourseID int,
--@DepartmentID int
--AS
--BEGIN
--	BEGIN TRY
--		BEGIN TRANSACTION
--			INSERT [tblCoursesInDepartment] ([CourseID], [DepartmentID]) Values (@CourseID,@DepartmentID)
--		COMMIT TRANSACTION
--	END TRY
--	BEGIN CATCH
--		ROLLBACK TRANSACTION
--	END CATCH
--END
--
--GO
--------------------------------- מחק קורס ממגמה

---CREATE PROC spRemoveCourseOfDepartment
--@CourseID int,
--@DepartmentID int
--AS
--BEGIN
--	BEGIN TRY
--		BEGIN TRANSACTION
--			DELETE [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID AND CourseID = @CourseID
--		COMMIT TRANSACTION
--	END TRY
--	BEGIN CATCH
--		ROLLBACK TRANSACTION
--	END CATCH
--END
--
--GO
--------------------------------- הכנס את כל הקורסים שאתה רוצה שהמרצה ילמד

CREATE PROC [site05].[spReplaceCoursesOfLecturerTry] -- V -- spReplaceCoursesOfLecturerTry
@ListOfCourses nvarchar(max),
@LecturerID int
AS
BEGIN
	declare @IsDeletingLectures bit = 0
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempLecturerInCourse FROM tblLecturersInCourse WHERE LecturerID = @LecturerID
			DECLARE @LectureID int
			Declare @CourseID int
			DELETE [tblLecturersInCourse] WHERE LecturerID = @LecturerID
			Select * Into #Temp From tblCourse WHERE @ListOfCourses like '%;'+cast(CourseID as nvarchar(20))+';%'
			SELECT * INTO #TempCoursesRemoved From #TempLecturerInCourse WHERE (CourseID NOT IN
                      (SELECT CourseID FROM #Temp))
			WHILE EXISTS (SELECT CourseID FROM #TempCoursesRemoved)
			BEGIN
				Select Top 1 @CourseID = CourseID From #TempCoursesRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE CourseID = @CourseID AND LecturerID = @LecturerID)
				BEGIN
					set @IsDeletingLectures = 1
					Select Top 1 @LectureID = LectureID From tblLecture WHERE CourseID = @CourseID AND LecturerID = @LecturerID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE CourseID = @CourseID AND LecturerID = @LecturerID
				Delete #TempCoursesRemoved Where CourseID = @CourseID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @CourseID = CourseID From #Temp 
				INSERT [tblLecturersInCourse] ([CourseID], [LecturerID]) Values (@CourseID,@LecturerID)
				Delete #Temp Where CourseID = @CourseID
			END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
	IF (@IsDeletingLectures = 1)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('הקורס/ים שאתה מתכוון להסיר מהמרצה רשומ/ים להרצאות. ההרצאות ימחקו', 16, 1)
		RETURN
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	END
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceCyclesOfDepartment]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל המחזורים שאתה רוצה שיהיו במגמה

CREATE PROC [site05].[spReplaceCyclesOfDepartment] -- V -- spReplaceCyclesOfDepartment
@ListOfCycles nvarchar(max),
@DepartmentID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempCycleInDepartment FROM tblCyclesInDepartment WHERE DepartmentID = @DepartmentID
			DECLARE @LectureID int
			Declare @CycleID int
			declare @CourseID int
			declare @StudentID int
			DELETE [tblCyclesInDepartment] WHERE DepartmentID = @DepartmentID
			Select * Into #Temp From tblCycle WHERE @ListOfCycles like '%;'+cast(CycleID as nvarchar(20))+';%'
			SELECT * INTO #TempCyclesRemoved From #TempCycleInDepartment WHERE (CycleID NOT IN
                      (SELECT CycleID FROM #Temp))
			WHILE EXISTS (SELECT CycleID FROM #TempCyclesRemoved)
			BEGIN
				Select Top 1 @CycleID = CycleID From #TempCyclesRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID)
				BEGIN
					Select Top 1 @LectureID = LectureID From tblLecture WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID
				SELECT * INTO #TempStudents FROM [tblStudent] WHERE CycleID = @CycleID AND DepartmentID =@DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents)
					DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID
					DELETE #TempStudents WHERE StudentID = @StudentID
				END
				drop table #TempStudents
				Delete #TempCyclesRemoved Where CycleID = @CycleID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @CycleID = CycleID From #Temp
				INSERT [tblCyclesInDepartment] ([CycleID], [DepartmentID]) Values (@CycleID,@DepartmentID)
				SELECT * INTO #TempStudents2 FROM [tblStudent] WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents2)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents2)
					SELECT * INTO #TempCourses FROM [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID
					WHILE EXISTS (SELECT * FROM #TempCourses)
					BEGIN
						SET @CourseID = (Select TOP 1 CourseID From #TempCourses)
						IF NOT EXISTS (SELECT StudentID FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID)
						BEGIN
							INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID)) 
						END
						DELETE #TempCourses WHERE CourseID = @CourseID
					END
					drop table #TempCourses
					DELETE #TempStudents2 WHERE StudentID = @StudentID
				END
				drop table #TempStudents2
				Delete #Temp Where CycleID = @CycleID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceCyclesOfDepartmentTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל המחזורים שאתה רוצה שיהיו במגמה

CREATE PROC [site05].[spReplaceCyclesOfDepartmentTry] -- V -- spReplaceCyclesOfDepartmentTry
@ListOfCycles nvarchar(max),
@DepartmentID int
AS
BEGIN
	declare @IsDeletingLectures bit = 0
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempCycleInDepartment FROM tblCyclesInDepartment WHERE DepartmentID = @DepartmentID
			DECLARE @LectureID int
			Declare @CycleID int
			declare @CourseID int
			declare @StudentID int
			DELETE [tblCyclesInDepartment] WHERE DepartmentID = @DepartmentID
			Select * Into #Temp From tblCycle WHERE @ListOfCycles like '%;'+cast(CycleID as nvarchar(20))+';%'
			SELECT * INTO #TempCyclesRemoved From #TempCycleInDepartment WHERE (CycleID NOT IN
                      (SELECT CycleID FROM #Temp))
			WHILE EXISTS (SELECT CycleID FROM #TempCyclesRemoved)
			BEGIN
				Select Top 1 @CycleID = CycleID From #TempCyclesRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID)
				BEGIN
					set @IsDeletingLectures = 1
					Select Top 1 @LectureID = LectureID From tblLecture WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID
				SELECT * INTO #TempStudents FROM [tblStudent] WHERE CycleID = @CycleID AND DepartmentID =@DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents)
					DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID
					DELETE #TempStudents WHERE StudentID = @StudentID
				END
				drop table #TempStudents
				Delete #TempCyclesRemoved Where CycleID = @CycleID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @CycleID = CycleID From #Temp
				INSERT [tblCyclesInDepartment] ([CycleID], [DepartmentID]) Values (@CycleID,@DepartmentID)
				SELECT * INTO #TempStudents2 FROM [tblStudent] WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents2)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents2)
					SELECT * INTO #TempCourses FROM [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID
					WHILE EXISTS (SELECT * FROM #TempCourses)
					BEGIN
						SET @CourseID = (Select TOP 1 CourseID From #TempCourses)
						IF NOT EXISTS (SELECT StudentID FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID)
						BEGIN
							INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID)) 
						END
						DELETE #TempCourses WHERE CourseID = @CourseID
					END
					drop table #TempCourses
					DELETE #TempStudents2 WHERE StudentID = @StudentID
				END
				drop table #TempStudents2
				Delete #Temp Where CycleID = @CycleID
			END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
	IF (@IsDeletingLectures = 1)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('המחזור/ים שאתה מתכוון להסיר מהמגמה רשומ/ים להרצאות. ההרצאות ימחקו', 16, 1)
		RETURN
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	END
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceDepartmentsOfCourse]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל המגמות שאתה רוצה שיהיו לקורס

CREATE PROC [site05].[spReplaceDepartmentsOfCourse] -- V -- spReplaceDepartmentsOfCourse
@CourseID int,
@ListOfDepartments nvarchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempCourseInDepartment FROM tblCoursesInDepartment WHERE CourseID = @CourseID
			DECLARE @LectureID int
			Declare @DepartmentID int
			declare @StudentID int
			DELETE [tblCoursesInDepartment] WHERE CourseID = @CourseID
			Select * Into #Temp From tblDepartment WHERE @ListOfDepartments like '%;'+cast(DepartmentID as nvarchar(20))+';%'
			SELECT * INTO #TempDepartmentsRemoved From #TempCourseInDepartment WHERE (DepartmentID NOT IN
                      (SELECT DepartmentID FROM #Temp))
			WHILE EXISTS (SELECT DepartmentID FROM #TempDepartmentsRemoved)
			BEGIN
				Select Top 1 @DepartmentID = DepartmentID From #TempDepartmentsRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE DepartmentID = @DepartmentID AND CourseID = @CourseID)
				BEGIN
					Select Top 1 @LectureID = LectureID From tblLecture WHERE DepartmentID = @DepartmentID AND CourseID = @CourseID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE DepartmentID = @DepartmentID AND CourseID = @CourseID
				SELECT * INTO #TempStudents FROM [tblStudent] WHERE DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents)
					DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID
					DELETE #TempStudents WHERE StudentID = @StudentID
				END
				drop table #TempStudents
				Delete #TempDepartmentsRemoved Where DepartmentID = @DepartmentID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @DepartmentID = DepartmentID From #Temp 
				INSERT [tblCoursesInDepartment] ([CourseID], [DepartmentID]) Values (@CourseID,@DepartmentID)
				SELECT * INTO #TempStudents2 FROM [tblStudent] WHERE DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents2)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents2)
					IF NOT EXISTS (SELECT StudentID FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID) -- אם הסטודנט הראשון של הנדסת תוכנה לא משוייך לקורס הזה
					BEGIN
						INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID)) -- אז תוסיף אותו
					END
					DELETE #TempStudents2 WHERE StudentID = @StudentID
				END
				drop table #TempStudents2
				Delete #Temp Where DepartmentID = @DepartmentID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceDepartmentsOfCourseTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל המגמות שאתה רוצה שיהיו לקורס

CREATE PROC [site05].[spReplaceDepartmentsOfCourseTry] -- V -- spReplaceDepartmentsOfCourseTry
@CourseID int = -1,
@ListOfDepartments nvarchar(max)
AS
BEGIN
	declare @IsDeletingLectures bit = 0
	IF (@CourseID <> -1)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				SELECT * INTO #TempCourseInDepartment FROM tblCoursesInDepartment WHERE CourseID = @CourseID
				DECLARE @LectureID int
				Declare @DepartmentID int
				declare @StudentID int
				DELETE [tblCoursesInDepartment] WHERE CourseID = @CourseID
				Select * Into #Temp From tblDepartment WHERE @ListOfDepartments like '%;'+cast(DepartmentID as nvarchar(20))+';%'
				SELECT * INTO #TempDepartmentsRemoved From #TempCourseInDepartment WHERE (DepartmentID NOT IN
						  (SELECT DepartmentID FROM #Temp))
				WHILE EXISTS (SELECT DepartmentID FROM #TempDepartmentsRemoved)
				BEGIN
					Select Top 1 @DepartmentID = DepartmentID From #TempDepartmentsRemoved
					WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE DepartmentID = @DepartmentID AND CourseID = @CourseID)
					BEGIN
						SET @IsDeletingLectures = 1
						Select Top 1 @LectureID = LectureID From tblLecture WHERE DepartmentID = @DepartmentID AND CourseID = @CourseID
						exec spDeleteLecture @LectureID
						Delete tblLecture Where LectureID = @LectureID
					END
					DELETE tblLecturesInSemester WHERE DepartmentID = @DepartmentID AND CourseID = @CourseID
					SELECT * INTO #TempStudents FROM [tblStudent] WHERE DepartmentID = @DepartmentID
					WHILE EXISTS (SELECT * FROM #TempStudents)
					BEGIN
						SET @StudentID = (Select TOP 1 StudentID From #TempStudents)
						DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID
						DELETE #TempStudents WHERE StudentID = @StudentID
					END
					drop table #TempStudents
					Delete #TempDepartmentsRemoved Where DepartmentID = @DepartmentID
				END
				WHILE EXISTS(SELECT * FROM #Temp)
				BEGIN
					Select Top 1 @DepartmentID = DepartmentID From #Temp 
					INSERT [tblCoursesInDepartment] ([CourseID], [DepartmentID]) Values (@CourseID,@DepartmentID)
					SELECT * INTO #TempStudents2 FROM [tblStudent] WHERE DepartmentID = @DepartmentID
					WHILE EXISTS (SELECT * FROM #TempStudents2)
					BEGIN
						SET @StudentID = (Select TOP 1 StudentID From #TempStudents2)
						IF NOT EXISTS (SELECT StudentID FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID) -- אם הסטודנט הראשון של הנדסת תוכנה לא משוייך לקורס הזה
						BEGIN
							INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID)) -- אז תוסיף אותו
						END
						DELETE #TempStudents2 WHERE StudentID = @StudentID
					END
					drop table #TempStudents2
					Delete #Temp Where DepartmentID = @DepartmentID
				END
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
		IF (@IsDeletingLectures = 1)
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('המגמה/ות שאתה מתכוון להסיר מהקורס רשומ/ות להרצאות. ההרצאות ימחקו', 16, 1)
			RETURN
		END
		ELSE
		BEGIN
			COMMIT TRANSACTION
		END
	END
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceDepartmentsOfCycle]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל המגמות שאתה רוצה שיהיו למחזור

CREATE PROC [site05].[spReplaceDepartmentsOfCycle] -- V -- spReplaceDepartmentsOfCycle
@CycleID int,
@ListOfDepartments nvarchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempCycleInDepartment FROM tblCyclesInDepartment WHERE CycleID = @CycleID
			DECLARE @LectureID int
			Declare @DepartmentID int
			declare @CourseID int
			declare @StudentID int
			DELETE [tblCyclesInDepartment] WHERE CycleID = @CycleID
			Select * Into #Temp From tblDepartment WHERE @ListOfDepartments like '%;'+cast(DepartmentID as nvarchar(20))+';%'
			SELECT * INTO #TempDepartmentsRemoved From #TempCycleInDepartment WHERE (DepartmentID NOT IN
                      (SELECT DepartmentID FROM #Temp))
			WHILE EXISTS (SELECT DepartmentID FROM #TempDepartmentsRemoved)
			BEGIN
				Select Top 1 @DepartmentID = DepartmentID From #TempDepartmentsRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID)
				BEGIN
					Select Top 1 @LectureID = LectureID From tblLecture WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID
				SELECT * INTO #TempStudents FROM [tblStudent] WHERE CycleID = @CycleID AND DepartmentID =@DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents)
					DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID
					DELETE #TempStudents WHERE StudentID = @StudentID
				END
				drop table #TempStudents
				Delete #TempDepartmentsRemoved Where DepartmentID = @DepartmentID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @DepartmentID = DepartmentID From #Temp 
				INSERT [tblCyclesInDepartment] ([CycleID], [DepartmentID]) Values (@CycleID,@DepartmentID)
				SELECT * INTO #TempStudents2 FROM [tblStudent] WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents2)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents2)
					SELECT * INTO #TempCourses FROM [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID
					WHILE EXISTS (SELECT * FROM #TempCourses)
					BEGIN
						SET @CourseID = (Select TOP 1 CourseID From #TempCourses)
						IF NOT EXISTS (SELECT StudentID FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID)
						BEGIN
							INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID)) 
						END
						DELETE #TempCourses WHERE CourseID = @CourseID
					END
					drop table #TempCourses
					DELETE #TempStudents2 WHERE StudentID = @StudentID
				END
				drop table #TempStudents2
				Delete #Temp Where DepartmentID = @DepartmentID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceDepartmentsOfCycleTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל המגמות שאתה רוצה שיהיו למחזור

CREATE PROC [site05].[spReplaceDepartmentsOfCycleTry] -- V -- spReplaceDepartmentsOfCycleTry
@CycleID int,
@ListOfDepartments nvarchar(max)
AS
BEGIN
	declare @IsDeletingLectures bit = 0
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempCycleInDepartment FROM tblCyclesInDepartment WHERE CycleID = @CycleID
			DECLARE @LectureID int
			Declare @DepartmentID int
			declare @CourseID int
			declare @StudentID int
			DELETE [tblCyclesInDepartment] WHERE CycleID = @CycleID
			Select * Into #Temp From tblDepartment WHERE @ListOfDepartments like '%;'+cast(DepartmentID as nvarchar(20))+';%'
			SELECT * INTO #TempDepartmentsRemoved From #TempCycleInDepartment WHERE (DepartmentID NOT IN
                      (SELECT DepartmentID FROM #Temp))
			WHILE EXISTS (SELECT DepartmentID FROM #TempDepartmentsRemoved)
			BEGIN
				Select Top 1 @DepartmentID = DepartmentID From #TempDepartmentsRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID)
				BEGIN
					set @IsDeletingLectures = 1
					Select Top 1 @LectureID = LectureID From tblLecture WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID
				SELECT * INTO #TempStudents FROM [tblStudent] WHERE CycleID = @CycleID AND DepartmentID =@DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents)
					DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID
					DELETE #TempStudents WHERE StudentID = @StudentID
				END
				drop table #TempStudents
				Delete #TempDepartmentsRemoved Where DepartmentID = @DepartmentID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @DepartmentID = DepartmentID From #Temp 
				INSERT [tblCyclesInDepartment] ([CycleID], [DepartmentID]) Values (@CycleID,@DepartmentID)
				SELECT * INTO #TempStudents2 FROM [tblStudent] WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID
				WHILE EXISTS (SELECT * FROM #TempStudents2)
				BEGIN
					SET @StudentID = (Select TOP 1 StudentID From #TempStudents2)
					SELECT * INTO #TempCourses FROM [tblCoursesInDepartment] WHERE DepartmentID = @DepartmentID
					WHILE EXISTS (SELECT * FROM #TempCourses)
					BEGIN
						SET @CourseID = (Select TOP 1 CourseID From #TempCourses)
						IF NOT EXISTS (SELECT StudentID FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID)
						BEGIN
							INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID)) 
						END
						DELETE #TempCourses WHERE CourseID = @CourseID
					END
					drop table #TempCourses
					DELETE #TempStudents2 WHERE StudentID = @StudentID
				END
				drop table #TempStudents2
				Delete #Temp Where DepartmentID = @DepartmentID
			END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
	IF (@IsDeletingLectures = 1)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('המגמה/ות שאתה מתכוון להסיר מהמחזור רשומ/ות להרצאות. ההרצאות ימחקו', 16, 1)
		RETURN
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	END
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceLecturersOfCourse]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל המרצים שאתה רוצה שילמדו את הקורס הזה

CREATE PROC [site05].[spReplaceLecturersOfCourse] -- V -- spReplaceLecturersOfCourse
@CourseID int,
@ListOfLecturers nvarchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempLecturerInCourse FROM tblLecturersInCourse WHERE CourseID = @CourseID
			DECLARE @LectureID int
			Declare @LecturerID int
			DELETE [tblLecturersInCourse] WHERE CourseID = @CourseID
			Select * Into #Temp From tblLecturer WHERE @ListOfLecturers like '%;'+cast(LecturerID as nvarchar(20))+';%'
			SELECT * INTO #TempLecturersRemoved From #TempLecturerInCourse WHERE (LecturerID NOT IN
                      (SELECT LecturerID FROM #Temp))
			WHILE EXISTS (SELECT LecturerID FROM #TempLecturersRemoved)
			BEGIN
				Select Top 1 @LecturerID = LecturerID From #TempLecturersRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE LecturerID = @LecturerID AND CourseID = @CourseID)
				BEGIN
					Select Top 1 @LectureID = LectureID From tblLecture WHERE LecturerID = @LecturerID AND CourseID = @CourseID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE LecturerID = @LecturerID AND CourseID = @CourseID
				Delete #TempLecturersRemoved Where LecturerID = @LecturerID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @LecturerID = LecturerID From #Temp 
				INSERT [tblLecturersInCourse] ([CourseID], [LecturerID]) Values (@CourseID,@LecturerID)
				Delete #Temp Where LecturerID = @LecturerID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spReplaceLecturersOfCourseTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- הכנס את כל המרצים שאתה רוצה שילמדו את הקורס הזה

CREATE PROC [site05].[spReplaceLecturersOfCourseTry] -- V -- spReplaceLecturersOfCourseTry
@CourseID int,
@ListOfLecturers nvarchar(max)
AS
BEGIN
	declare @IsDeletingLectures bit = 0
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * INTO #TempLecturerInCourse FROM tblLecturersInCourse WHERE CourseID = @CourseID
			DECLARE @LectureID int
			Declare @LecturerID int
			DELETE [tblLecturersInCourse] WHERE CourseID = @CourseID
			Select * Into #Temp From tblLecturer WHERE @ListOfLecturers like '%;'+cast(LecturerID as nvarchar(20))+';%'
			SELECT * INTO #TempLecturersRemoved From #TempLecturerInCourse WHERE (LecturerID NOT IN
                      (SELECT LecturerID FROM #Temp))
			WHILE EXISTS (SELECT LecturerID FROM #TempLecturersRemoved)
			BEGIN
				Select Top 1 @LecturerID = LecturerID From #TempLecturersRemoved
				WHILE EXISTS (SELECT LectureID FROM tblLecture WHERE LecturerID = @LecturerID AND CourseID = @CourseID)
				BEGIN
					set @IsDeletingLectures = 1
					Select Top 1 @LectureID = LectureID From tblLecture WHERE LecturerID = @LecturerID AND CourseID = @CourseID
					exec spDeleteLecture @LectureID
					Delete tblLecture Where LectureID = @LectureID
				END
				DELETE tblLecturesInSemester WHERE LecturerID = @LecturerID AND CourseID = @CourseID
				Delete #TempLecturersRemoved Where LecturerID = @LecturerID
			END
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @LecturerID = LecturerID From #Temp 
				INSERT [tblLecturersInCourse] ([CourseID], [LecturerID]) Values (@CourseID,@LecturerID)
				Delete #Temp Where LecturerID = @LecturerID
			END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
	IF (@IsDeletingLectures = 1)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('המרצה/ים שאתה מתכוון להסיר מהקורס רשומ/ים להרצאות. ההרצאות ימחקו', 16, 1)
		RETURN
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	END
END

GO
/****** Object:  StoredProcedure [site05].[spUpdateAdministrator]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateAdministrator] -- V
@AdministratorID int,
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email nvarchar(100),
@IsActive bit
AS
BEGIN
	IF EXISTS (SELECT * FROM tblAdministrator WHERE Email = @Email AND AdministratorID <> @AdministratorID)
	BEGIN
		RAISERROR ('אימייל תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblAdministrator SET FirstName = LTRIM(RTRIM(@FirstName)), LastName = LTRIM(RTRIM(@LastName)), Email = LTRIM(RTRIM(LOWER(@Email))), IsActive = @IsActive WHERE AdministratorID = @AdministratorID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateAdministratorPassword]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateAdministratorPassword]
@AdministratorID int,
@Password varchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblAdministrator WHERE AdministratorID = @AdministratorID)
			UPDATE tblUser SET Password = @Password WHERE UserID = @UserID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateAdministratorPasswordFromSettingsPage]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateAdministratorPasswordFromSettingsPage]
@AdministratorID int,
@CurrentPassword varchar(max),
@NewPassword varchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblAdministrator WHERE AdministratorID = @AdministratorID)
			UPDATE tblUser SET Password = @NewPassword WHERE UserID = @UserID AND Password = @CurrentPassword
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateClass]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateClass] -- V
@ClassID int,
@ClassName nvarchar(30),
@IsActive bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE [tblClass] SET ClassName = LTRIM(RTRIM(@ClassName)), IsActive = @IsActive WHERE ClassID = @ClassID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateClassLocation]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateClassLocation]
@ClassID int,
@Longitude decimal(9,6),
@Latitude decimal(9,6)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblClass SET Longitude = @Longitude, Latitude = @Latitude, LastLocationUpdate = GETDATE() WHERE ClassID = @ClassID

			SELECT ClassID, ClassName, Longitude, Latitude, LastLocationUpdate FROM tblClass WHERE ClassID = @ClassID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateCourse]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateCourse] -- V
@CourseID int,
@CourseName nvarchar(50),
@IsActive bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblCourse SET CourseName = LTRIM(RTRIM(@CourseName)), IsActive = @IsActive WHERE CourseID = @CourseID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateCourseOfStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- עדכן קורסים של סטודנט

CREATE PROC [site05].[spUpdateCourseOfStudent] -- V
@StudentID int,
@CourseID int,
@OldCycleID int,
@CycleID int,
@IsActive bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @DepartmentID int = (SELECT DepartmentID FROM [tblStudent] WHERE StudentID = @StudentID)
			declare @LectureID int
			IF EXISTS (SELECT tblLecture.LectureID FROM tblStudentsInLecture INNER JOIN tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID WHERE (tblLecture.CourseID = @CourseID) AND (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.CycleID = @OldCycleID))
			BEGIN
				IF (@IsActive = 0 OR @CycleID <> @OldCycleID)
				BEGIN
					DELETE tblStudentsInLecture FROM tblStudentsInLecture INNER JOIN tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID WHERE (tblLecture.CourseID = @CourseID) AND (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.CycleID = @OldCycleID)
				END
			END
			IF ((@OldCycleID <> @CycleID AND @IsActive = 1) OR (SELECT IsActive FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID) = 0 AND @IsActive = 1)
			BEGIN
				SELECT * INTO #TempLectures FROM [tblLecture] WHERE CycleID = @CycleID AND DepartmentID = @DepartmentID AND CourseID = @CourseID
				WHILE EXISTS (SELECT * FROM #TempLectures)
				BEGIN
					SET @LectureID = (SELECT TOP 1 LectureID FROM #TempLectures)
					INSERT [tblStudentsInLecture] ([LectureID], [StudentID], [StatusID]) Values (@LectureID, @StudentID, 1)
					DELETE #TempLectures WHERE LectureID = @LectureID
				END
				DROP TABLE #TempLectures
			END
			UPDATE [tblCoursesOfStudent] SET IsActive = @IsActive, CycleID = @CycleID WHERE StudentID = @StudentID AND CourseID = @CourseID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spUpdateCourseOfStudentTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- בדיקה לפני עדכון

CREATE PROC [site05].[spUpdateCourseOfStudentTry] -- V -- spUpdateCourseOfStudentTry
@StudentID int,
@CourseID int,
@OldCycleID int,
@CycleID int,
@IsActive int
AS
BEGIN
	IF (@OldCycleID <> @CycleID OR (SELECT IsActive FROM [tblCoursesOfStudent] WHERE StudentID = @StudentID AND CourseID = @CourseID) = 1 AND @IsActive = 0)
	BEGIN
		IF EXISTS (SELECT tblStudentsInLecture.LectureID
					FROM tblLecture INNER JOIN tblStudentsInLecture ON tblLecture.LectureID = tblStudentsInLecture.LectureID
					WHERE (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.CourseID = @CourseID) AND (tblLecture.CycleID = @OldCycleID))
		BEGIN
			RAISERROR ('השינויים שאתה הולך לעשות ימחקו את הסטודנט מההרצאות', 16, 1)
			RETURN
		END
	END
	BEGIN TRY
		BEGIN TRANSACTION
			declare @DepartmentID int = (SELECT DepartmentID FROM tblStudent WHERE StudentID = @StudentID)
			declare @LectureID int
			IF ((@IsActive = 1 AND (SELECT IsActive FROM tblCoursesOfStudent WHERE (StudentID = @StudentID) AND (CourseID = @CourseID)) = 0) OR (@OldCycleID <> @CycleID AND @IsActive = 1))
			BEGIN
				SELECT tblLecture.* Into #Temp FROM tblLecture INNER JOIN tblCycle ON tblLecture.CycleID = tblCycle.CycleID WHERE DepartmentID = @DepartmentID AND CourseID = @CourseID AND tblCycle.CycleID = @CycleID
				WHILE EXISTS (SELECT * FROM #Temp)
				BEGIN
					Select Top 1 @LectureID = LectureID From #Temp
					INSERT tblStudentsInLecture ([LectureID], [StudentID], [StatusID]) Values (@LectureID,@StudentID,1)
					Delete #Temp Where LectureID = @LectureID
				END
			END
			UPDATE [tblCoursesOfStudent] SET IsActive = @IsActive, CycleID = @CycleID WHERE StudentID = @StudentID AND CourseID = @CourseID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spUpdateCycle]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateCycle] -- V
@CycleID int,
@CycleName nvarchar(10),
@Year int,
@IsActive bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblCycle SET CycleName = LTRIM(RTRIM(@CycleName)), Year = @Year, IsActive = @IsActive WHERE CycleID = @CycleID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateDepartment]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateDepartment] -- V
@DepartmentID int,
@DepartmentName nvarchar(50),
@IsActive bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE [tblDepartment] SET DepartmentName = LTRIM(RTRIM(@DepartmentName)), IsActive = @IsActive WHERE DepartmentID = @DepartmentID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLectureCancel]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLectureCancel]
@LectureID int,
@IsCanceled bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

			declare @Now datetime = GETDATE()
			declare @CurrentDate date = CONVERT(DATE, @Now)
			declare @CurrentTime time = CONVERT(TIME, @Now)

			declare @LectureDate date = (SELECT LectureDate FROM tblLecture WHERE LectureID = @LectureID)
			declare @BeginHour time = (SELECT BeginHour FROM tblLecture WHERE LectureID = @LectureID)
			declare @EndHour time = (SELECT EndHour FROM tblLecture WHERE LectureID = @LectureID)

			declare @IsOld bit = (SELECT  cast(  CASE WHEN @LectureDate < @CurrentDate THEN 1 WHEN @LectureDate > @CurrentDate THEN 0 WHEN @LectureDate = @CurrentDate AND @BeginHour <= @CurrentTime AND @EndHour >= @CurrentTime THEN 0 WHEN @LectureDate = @CurrentDate AND @BeginHour >= @CurrentTime THEN 0 WHEN @LectureDate = @CurrentDate AND @EndHour <= @CurrentTime THEN 1 ELSE 0 END as bit ) )
			
			IF (@IsOld = 0)
			BEGIN

				UPDATE tblLecture SET IsCanceled = @IsCanceled WHERE LectureID = @LectureID
				SELECT IsCanceled FROM tblLecture WHERE LectureID = @LectureID
			
				SELECT        site05.tblUser.Token, site05.tblCourse.CourseID, site05.tblCourse.CourseName, site05.tblLecture.LectureDate, site05.tblLecture.BeginHour
				FROM            site05.tblStudentsInLecture INNER JOIN
										 site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID INNER JOIN
										 site05.tblUser ON site05.tblStudent.UserID = site05.tblUser.UserID INNER JOIN
										 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID INNER JOIN
										 site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID
				WHERE        (site05.tblStudentsInLecture.LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1)
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLecturer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLecturer] -- V
@LecturerID int,
@FirstName nvarchar(35),
@LastName nvarchar(35) = '',
@Email nvarchar(100),
@IsActive bit
AS
BEGIN
	IF EXISTS (SELECT * FROM tblLecturer WHERE Email = @Email AND LecturerID <> @LecturerID)
	BEGIN
		RAISERROR ('אימייל תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		IF ((SELECT tblUser.RoleID FROM tblLecturer INNER JOIN tblUser ON tblLecturer.UserID = tblUser.UserID WHERE tblLecturer.LecturerID = @LecturerID) = 2)
		BEGIN
			BEGIN TRANSACTION
				UPDATE tblLecturer SET FirstName = LTRIM(RTRIM(@FirstName)), LastName = LTRIM(RTRIM(@LastName)), Email = LTRIM(RTRIM(LOWER(@Email))), IsActive = @IsActive WHERE LecturerID = @LecturerID
			COMMIT TRANSACTION
		END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLecturerEmail]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLecturerEmail]
@LecturerID int,
@Email nvarchar(100)
AS
BEGIN
	IF NOT EXISTS (SELECT Email FROM tblLecturer WHERE Email = @Email)
	BEGIN
		UPDATE tblLecturer SET Email = @Email WHERE LecturerID = @LecturerID
	END
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLecturerPassword]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLecturerPassword]
@LecturerID int,
@CurrentPassword varchar(max),
@NewPassword varchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblLecturer WHERE LecturerID = @LecturerID)
			UPDATE tblUser SET Password = @NewPassword WHERE UserID = @UserID AND Password = @CurrentPassword
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLecturerPasswordForAdministrator]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLecturerPasswordForAdministrator]
@LecturerID int,
@Password varchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblLecturer WHERE LecturerID = @LecturerID)
			UPDATE tblUser SET Password = @Password, Token = NULL, AfterFirstLogin = 0 WHERE UserID = @UserID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLecturerQRMode]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLecturerQRMode]
@LecturerID int,
@QRMode bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblLecturer SET QRMode = @QRMode WHERE LecturerID = @LecturerID

			declare @Now datetime = GETDATE()
			declare @CurrentDate date = CONVERT(DATE, @Now)
			declare @CurrentTime time = CONVERT(TIME, @Now)
			declare @LectureID int
			IF EXISTS (SELECT LectureID FROM tblLecture WHERE (LecturerID = @LecturerID) AND (LectureDate = @CurrentDate) AND (BeginHour <= @CurrentTime) AND (EndHour >= @CurrentTime))
			BEGIN
				SET @LectureID = (SELECT LectureID FROM tblLecture WHERE (LecturerID = @LecturerID) AND (LectureDate = @CurrentDate) AND (BeginHour <= @CurrentTime) AND (EndHour >= @CurrentTime))
				
				SELECT        tblUser.Token
				FROM            tblStudentsInLecture INNER JOIN
										 tblStudent ON tblStudentsInLecture.StudentID = tblStudent.StudentID INNER JOIN
										 tblUser ON tblStudent.UserID = tblUser.UserID
				WHERE        (tblStudentsInLecture.LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1)

				IF (@QRMode = 1)
				BEGIN
					UPDATE tblStudentsInLecture SET StatusID = 1 WHERE LectureID = @LectureID
				END
				ELSE
				BEGIN
					exec spFireTimer @LectureID
				END
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLectureTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLectureTry] -- V -- spUpdateLectureTry
@LectureID int,
@CourseID int,
@DepartmentID int,
@CycleID int,
@LecturerID int,
@ClassID int,
@LectureDate date,
@BeginHour time,
@EndHour time,
@IsCanceled bit
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM tblCyclesInDepartment WHERE (CycleID = @CycleID) AND (DepartmentID = @DepartmentID))
	BEGIN
		RAISERROR ('המגמה לא משויכת למחזור', 16, 1)
		RETURN
	END
	IF NOT EXISTS (SELECT * FROM tblCoursesInDepartment WHERE (CourseID = @CourseID) AND (DepartmentID = @DepartmentID))
	BEGIN
		RAISERROR ('הקורס לא משויך למגמה', 16, 1)
		RETURN
	END
	IF NOT EXISTS (SELECT * FROM tblLecturersInCourse WHERE (LecturerID = @LecturerID) AND (CourseID = @CourseID))
	BEGIN
		RAISERROR ('המרצה לא משויך לקורס', 16, 1)
		RETURN
	END
	IF (@EndHour <= @BeginHour)
	BEGIN
		RAISERROR ('שעת ההתחלה חייבת להיות קטנה יותר משעת הסיום', 16, 1)
		RETURN
	END
	IF (DATEDIFF(MINUTE, @BeginHour, @EndHour) < 45)
	BEGIN
		RAISERROR ('כל שיעור חייב להמשך לפחות 45 דקות', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT CycleID FROM tblLecture WHERE LectureID <> @LectureID AND CycleID = @CycleID AND DepartmentID = DepartmentID AND LectureDate = @LectureDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
	BEGIN
		RAISERROR ('המחזור והמגמה תפוסים', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT ClassID FROM tblLecture WHERE LectureID <> @LectureID AND ClassID = @ClassID AND LectureDate = @LectureDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
	BEGIN
		RAISERROR ('הכיתה תפוסה', 16, 1)
		RETURN
	END
	IF EXISTS (SELECT LecturerID FROM tblLecture WHERE LectureID <> @LectureID AND LecturerID = @LecturerID AND LectureDate = @LectureDate AND (NOT((@BeginHour < BeginHour AND @EndHour < EndHour) OR (@BeginHour >= EndHour AND @EndHour >= EndHour))))
	BEGIN
		RAISERROR ('המרצה תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		BEGIN TRANSACTION
			
			declare @OldIsCanceled bit = (SELECT IsCanceled FROM tblLecture WHERE LectureID = @LectureID)
			UPDATE [tblLecture] SET CourseID = @CourseID, DepartmentID = @DepartmentID, CycleID = @CycleID, LecturerID = @LecturerID, ClassID = @ClassID, LectureDate = @LectureDate, BeginHour = @BeginHour, EndHour = @EndHour, Iscanceled = @IsCanceled, TimerStarted = CAST(@LectureDate AS datetime) + CAST(@BeginHour AS datetime) WHERE LectureID = @LectureID
			declare @NewIsCanceled bit = (SELECT IsCanceled FROM tblLecture WHERE LectureID = @LectureID)
			IF (@OldIsCanceled <> @NewIsCanceled) -- changed
			BEGIN
				declare @Now datetime = GETDATE()
				declare @CurrentDate date = CONVERT(DATE, @Now)
				declare @CurrentTime time = CONVERT(TIME, @Now)
				declare @IsOld bit
				IF EXISTS (SELECT LectureID FROM tblLecture WHERE (LectureID = @LectureID) AND (LectureDate < @CurrentDate)) -- PAST
				BEGIN
					set @IsOld = 1
				END
				ELSE IF EXISTS (SELECT LectureID FROM tblLecture WHERE (LectureID = @LectureID) AND (LectureDate > @CurrentDate)) -- FUTURE
				BEGIN
					set @IsOld = 0
				END
				ELSE IF EXISTS (SELECT LectureID FROM tblLecture WHERE (LectureID = @LectureID) AND (LectureDate = @CurrentDate) AND (BeginHour <= @CurrentTime) AND (EndHour >= @CurrentTime)) -- CURRENT
				BEGIN
					set @IsOld = 0
				END
				ELSE IF EXISTS (SELECT LectureID FROM tblLecture WHERE (LectureID = @LectureID) AND (LectureDate = @CurrentDate) AND (BeginHour >= @CurrentTime)) -- LATER
				BEGIN
					set @IsOld = 0
				END
				ELSE IF EXISTS (SELECT LectureID FROM tblLecture WHERE (LectureID = @LectureID) AND (LectureDate = @CurrentDate) AND (EndHour <= @CurrentTime)) -- BEFORE
				BEGIN
					set @IsOld = 1
				END
				
				IF (@IsOld = 0) -- NOT OLD
				BEGIN
					SELECT @NewIsCanceled AS IsCanceled

					SELECT        site05.tblUser.Token, site05.tblCourse.CourseID, site05.tblCourse.CourseName, site05.tblLecture.LectureDate, site05.tblLecture.BeginHour
					FROM            site05.tblStudentsInLecture INNER JOIN
											 site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID INNER JOIN
											 site05.tblUser ON site05.tblStudent.UserID = site05.tblUser.UserID INNER JOIN
											 site05.tblLecture ON site05.tblStudentsInLecture.LectureID = site05.tblLecture.LectureID INNER JOIN
											 site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID
					WHERE        (site05.tblStudentsInLecture.LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1)
				
					SELECT        site05.tblUser.Token, site05.tblDepartment.DepartmentID, site05.tblDepartment.DepartmentName, site05.tblCourse.CourseID, site05.tblCourse.CourseName, site05.tblLecture.LectureDate, site05.tblLecture.BeginHour
					FROM            site05.tblLecture INNER JOIN
											 site05.tblLecturer ON site05.tblLecture.LecturerID = site05.tblLecturer.LecturerID INNER JOIN
											 site05.tblUser ON site05.tblLecturer.UserID = site05.tblUser.UserID INNER JOIN
											 site05.tblCourse ON site05.tblLecture.CourseID = site05.tblCourse.CourseID INNER JOIN
											 site05.tblDepartment ON site05.tblLecture.DepartmentID = site05.tblDepartment.DepartmentID
					WHERE        (site05.tblLecturer.IsActive = 1) AND (site05.tblLecture.LectureID = @LectureID)
				END
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLocationManager]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLocationManager]
@LocationManagerID int,
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email nvarchar(100),
@IsActive bit
AS
BEGIN
	IF EXISTS (SELECT * FROM tblLocationManager WHERE Email = @Email AND LocationManagerID <> @LocationManagerID)
	BEGIN
		RAISERROR ('אימייל תפוס', 16, 1)
		RETURN
	END
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblLocationManager SET FirstName = LTRIM(RTRIM(@FirstName)), LastName = LTRIM(RTRIM(@LastName)), Email = LTRIM(RTRIM(LOWER(@Email))), IsActive = @IsActive WHERE LocationManagerID = @LocationManagerID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spUpdateLocationManagerEmail]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLocationManagerEmail]
@LocationManagerID int,
@Email nvarchar(100)
AS
BEGIN
	IF NOT EXISTS (SELECT Email FROM tblLocationManager WHERE Email = @Email)
	BEGIN
		UPDATE tblLocationManager SET Email = @Email WHERE LocationManagerID = @LocationManagerID
	END
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLocationManagerPassword]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLocationManagerPassword]
@LocationManagerID int,
@CurrentPassword varchar(max),
@NewPassword varchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblLocationManager WHERE LocationManagerID = @LocationManagerID)
			UPDATE tblUser SET Password = @NewPassword WHERE UserID = @UserID AND Password = @CurrentPassword
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateLocationManagerPasswordForAdministrator]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateLocationManagerPasswordForAdministrator]
@LocationManagerID int,
@Password varchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblLocationManager WHERE LocationManagerID = @LocationManagerID)
			UPDATE tblUser SET Password = @Password, Token = NULL, AfterFirstLogin = 0 WHERE UserID = @UserID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateStatusOfStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateStatusOfStudent]
@LectureID int,
@StudentID int,
@StatusID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblStudentsInLecture SET StatusID = @StatusID WHERE StudentID = @StudentID AND LectureID = @LectureID
			SELECT StatusID, StatusName FROM tblStatus WHERE StatusID = @StatusID

			declare @MissCount int = (select COUNT(*)
			FROM            site05.tblStudentsInLecture INNER JOIN
							 site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
			WHERE        (StatusID = 1) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

			declare @LateCount int = (select COUNT(*)
			FROM            site05.tblStudentsInLecture INNER JOIN
							 site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
			WHERE        (StatusID = 2) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

			declare @HereCount int = (select COUNT(*)
			FROM            site05.tblStudentsInLecture INNER JOIN
							 site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
			WHERE        (StatusID = 3) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

			declare @JustifyCount int = (select COUNT(*)
			FROM            site05.tblStudentsInLecture INNER JOIN
							 site05.tblStudent ON site05.tblStudentsInLecture.StudentID = site05.tblStudent.StudentID
			WHERE        (StatusID = 4) AND (LectureID = @LectureID) AND (site05.tblStudent.IsActive = 1))

			SELECT @MissCount as MissCount, @LateCount as LateCount, @HereCount as HereCount, @JustifyCount as JustifyCount

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateStatusOfStudentByTimer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateStatusOfStudentByTimer]
@LectureID int,
@StudentID int
AS
BEGIN
	declare @Now datetime = GETDATE()
	declare @CurrentDate date = CONVERT(DATE, @Now)
	declare @CurrentTime time = CONVERT(TIME, @Now)
	IF EXISTS (SELECT tblLecture.LectureID -- IS LIVE
				FROM tblStudentsInLecture INNER JOIN tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID
				WHERE (tblStudentsInLecture.StudentID = @StudentID) AND (tblLecture.LectureDate = @CurrentDate) AND (tblLecture.BeginHour <= @CurrentTime) AND (tblLecture.EndHour >= @CurrentTime))
	BEGIN
		declare @TimerStarted datetime = (SELECT TimerStarted FROM tblLecture WHERE LectureID = @LectureID)
		declare @TimerLong int = (SELECT TimerLong FROM tblLecture WHERE LectureID = @LectureID)
		declare @TimerElapsed int = Datediff(s, @TimerStarted, @Now)
		declare @TimerRemaining int = @TimerLong - @TimerElapsed
		declare @StatusID int
		BEGIN TRY
			BEGIN TRANSACTION
				IF (@TimerRemaining >= 0) -- IS HERE
				BEGIN
					UPDATE tblStudentsInLecture SET StatusID = 3 WHERE StudentID = @StudentID AND LectureID = @LectureID
					SELECT StatusID, StatusName FROM tblStatus WHERE StatusID = 3
				END
				ELSE IF (@TimerRemaining < 0) -- IS LATE
				BEGIN
					UPDATE tblStudentsInLecture SET StatusID = 2 WHERE StudentID = @StudentID AND LectureID = @LectureID
					SELECT StatusID, StatusName FROM tblStatus WHERE StatusID = 2
				END
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
	END
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateStudent] -- V -- spUpdateStudent
@StudentID int,
@DepartmentID int,
@CycleID int,
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email nvarchar(100),
@IsActive bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @LectureID int
			declare @CourseID int
			IF EXISTS (SELECT * FROM tblStudent WHERE Email = @Email AND StudentID <> @StudentID)
			BEGIN
				RAISERROR ('אימייל תפוס', 16, 1)
				RETURN
			END
			DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID
			SELECT * INTO #Temp2 FROM tblCoursesInDepartment WHERE DepartmentID = @DepartmentID
			WHILE EXISTS (SELECT * FROM #Temp2)
			BEGIN
				SET @CourseID = (SELECT TOP 1 CourseID FROM #Temp2)
				INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, @CycleID)
				DELETE #Temp2 WHERE CourseID = @CourseID
			END
			DROP TABLE #Temp2
			DELETE tblStudentsInLecture WHERE StudentID = @StudentID
			UPDATE tblStudent SET FirstName = LTRIM(RTRIM(@FirstName)), LastName = LTRIM(RTRIM(@LastName)), Email = LTRIM(RTRIM(LOWER(@Email))), DepartmentID = @DepartmentID, CycleID = @CycleID, IsActive = @IsActive WHERE StudentID = @StudentID
			SELECT * INTO #Temp FROM tblLecture WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID
			WHILE EXISTS(SELECT * FROM #Temp)
			BEGIN
				Select Top 1 @LectureID = LectureID From #Temp
				INSERT tblStudentsInLecture ([LectureID], [StudentID], [StatusID]) Values (@LectureID,@StudentID,1)
				Delete #Temp Where LectureID = @LectureID
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateStudentEmail]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateStudentEmail]
@StudentID int,
@Email nvarchar(100)
AS
BEGIN
	IF NOT EXISTS (SELECT Email FROM tblStudent WHERE Email = @Email)
	BEGIN
		UPDATE tblStudent SET Email = @Email WHERE StudentID = @StudentID
	END
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateStudentInLecture]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- עדכן סטטוס של סטודנט בהרצאה

CREATE PROC [site05].[spUpdateStudentInLecture] -- V
@LectureID int,
@StudentID int,
@StatusID int
AS
BEGIN
	BEGIN TRY
			BEGIN TRANSACTION
				UPDATE [tblStudentsInLecture] SET StatusID = @StatusID WHERE LectureID = @LectureID AND StudentID = @StudentID
			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [site05].[spUpdateStudentPassword]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateStudentPassword]
@StudentID int,
@CurrentPassword varchar(max),
@NewPassword varchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblStudent WHERE StudentID = @StudentID)
			UPDATE tblUser SET Password = @NewPassword WHERE UserID = @UserID AND Password = @CurrentPassword
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateStudentPasswordForAdministrator]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateStudentPasswordForAdministrator]
@StudentID int,
@Password varchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			declare @UserID int = (SELECT UserID FROM tblStudent WHERE StudentID = @StudentID)
			UPDATE tblUser SET Password = @Password, Token = NULL, AfterFirstLogin = 0 WHERE UserID = @UserID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spUpdateStudentTry]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spUpdateStudentTry] -- V -- spUpdateStudentTry
@StudentID int,
@DepartmentID int,
@CycleID int,
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email nvarchar(100),
@IsActive bit
AS
BEGIN
	declare @CycleIDCurrent int = (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID)
	declare @DepartmentIDCurrent int = (SELECT DepartmentID FROM tblStudent WHERE StudentID = @StudentID)
	IF ((SELECT tblUser.RoleID FROM tblStudent INNER JOIN tblUser ON tblStudent.UserID = tblUser.UserID WHERE tblStudent.StudentID = @StudentID) = 3)
	BEGIN
		IF EXISTS (SELECT * FROM tblStudentsInLecture INNER JOIN tblLecture ON tblStudentsInLecture.LectureID = tblLecture.LectureID WHERE StudentID = @StudentID AND (tblLecture.CycleID = @CycleIDCurrent OR tblLecture.DepartmentID = @DepartmentIDCurrent))
		BEGIN
			IF (@DepartmentID <> (SELECT DepartmentID FROM tblStudent WHERE StudentID = @StudentID))
			BEGIN
				RAISERROR ('הסטודנט רשום להרצאות במגמה הנוכחית. הסטודנט ימחק מההרצאות', 16, 1)
				RETURN
			END
			ELSE IF (@CycleID <> (SELECT CycleID FROM tblStudent WHERE StudentID = @StudentID))
			BEGIN
				RAISERROR ('הסטודנט רשום להרצאות במחזור הנוכחי. הסטודנט ימחק מההרצאות', 16, 1)
				RETURN
			END
		END
		BEGIN TRY
			BEGIN TRANSACTION
				declare @LectureID int
				declare @CourseID int
				UPDATE tblStudent SET FirstName = LTRIM(RTRIM(@FirstName)), LastName = LTRIM(RTRIM(@LastName)), Email = LTRIM(RTRIM(LOWER(@Email))), DepartmentID = @DepartmentID, CycleID = @CycleID, IsActive = @IsActive WHERE StudentID = @StudentID
				IF EXISTS (SELECT * FROM tblStudent WHERE Email = @Email AND StudentID <> @StudentID)
				BEGIN
					RAISERROR ('אימייל תפוס', 16, 1)
					RETURN
				END
				IF (@CycleIDCurrent IS NULL OR @CycleID <> @CycleIDCurrent OR @DepartmentID <> @DepartmentIDCurrent)
				BEGIN
					SELECT * INTO #Temp FROM tblLecture WHERE DepartmentID = @DepartmentID AND CycleID = @CycleID
					WHILE EXISTS(SELECT * FROM #Temp)
					BEGIN
						Select Top 1 @LectureID = LectureID From #Temp
						INSERT tblStudentsInLecture ([LectureID], [StudentID], [StatusID]) Values (@LectureID,@StudentID,1)
						Delete #Temp Where LectureID = @LectureID
					END
					DELETE [tblCoursesOfStudent] WHERE StudentID = @StudentID
					SELECT CourseID Into #TempCourses FROM tblCoursesInDepartment WHERE DepartmentID = @DepartmentID
					WHILE EXISTS (SELECT * FROM #TempCourses)
					BEGIN
						SET @CourseID = (Select TOP 1 * From #TempCourses)
						INSERT [tblCoursesOfStudent] ([StudentID], [CourseID], [CycleID]) Values (@StudentID, @CourseID, @CycleID)
						DELETE #TempCourses WHERE CourseID = @CourseID
					END
					DROP TABLE #TempCourses
				END
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
	END
END
GO
/****** Object:  StoredProcedure [site05].[spValidateAdministrator]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spValidateAdministrator] -- V -- spValidateAdministrator
@AdministratorID int,
@Password nvarchar(max)
AS
BEGIN
	SELECT        TOP (100) PERCENT tblAdministrator.AdministratorID, tblAdministrator.UserID, tblUser.Password, tblAdministrator.FirstName, tblAdministrator.LastName, tblAdministrator.Email, tblRole.RoleID, 
							 tblRole.RoleName
	FROM            tblAdministrator INNER JOIN
							 tblUser ON tblAdministrator.UserID = tblUser.UserID INNER JOIN
							 tblRole ON tblUser.RoleID = tblRole.RoleID
	WHERE        (tblAdministrator.AdministratorID = @AdministratorID ) AND (tblUser.Password = @Password COLLATE SQL_Latin1_General_CP1_CS_AS) AND tblAdministrator.IsActive = 1
END
GO
/****** Object:  StoredProcedure [site05].[spValidateLecturer]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spValidateLecturer]
@LecturerID int,
@Password nvarchar(max),
@Token nvarchar(100)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT tblLecturer.LecturerID FROM tblLecturer INNER JOIN tblUser ON tblLecturer.UserID = tblUser.UserID WHERE (tblLecturer.LecturerID = @LecturerID) AND (tblUser.Password = @Password) AND (tblLecturer.IsActive = 1))
			BEGIN
				UPDATE tblUser
				SET Token = @Token, AfterFirstLogin = 1
				FROM tblLecturer INNER JOIN
				tblUser ON tblLecturer.UserID = tblUser.UserID INNER JOIN
				tblRole ON tblUser.RoleID = tblRole.RoleID
				WHERE (tblLecturer.LecturerID = @LecturerID)

				SELECT        tblLecturer.LecturerID, tblLecturer.FirstName, tblLecturer.LastName, tblLecturer.Email, tblLecturer.Picture, tblUser.UserID, tblUser.Password, tblRole.RoleID, tblRole.RoleName, tblUser.Token, tblLecturer.QRMode
				FROM            tblLecturer INNER JOIN
								 tblUser ON tblLecturer.UserID = tblUser.UserID INNER JOIN
								 tblRole ON tblUser.RoleID = tblRole.RoleID
				WHERE        (tblLecturer.LecturerID = @LecturerID)
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spValidateLocationManager]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spValidateLocationManager]
@LocationManagerID int,
@Password nvarchar(max),
@Token nvarchar(100)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT tblLocationManager.LocationManagerID FROM tblLocationManager INNER JOIN tblUser ON tblLocationManager.UserID = tblUser.UserID WHERE (tblLocationManager.LocationManagerID = @LocationManagerID) AND (tblUser.Password = @Password) AND (tblLocationManager.IsActive = 1))
			BEGIN
				UPDATE tblUser
				SET Token = @Token, AfterFirstLogin = 1
				FROM site05.tblLocationManager INNER JOIN site05.tblUser ON site05.tblLocationManager.UserID = site05.tblUser.UserID INNER JOIN site05.tblRole ON site05.tblUser.RoleID = site05.tblRole.RoleID
				WHERE (tblLocationManager.LocationManagerID = @LocationManagerID)

				SELECT        site05.tblUser.UserID, site05.tblUser.Password, site05.tblUser.Token, site05.tblRole.RoleID, site05.tblRole.RoleName, site05.tblLocationManager.LocationManagerID, site05.tblLocationManager.FirstName, 
									site05.tblLocationManager.LastName, site05.tblLocationManager.Email
				FROM            site05.tblLocationManager INNER JOIN site05.tblUser ON site05.tblLocationManager.UserID = site05.tblUser.UserID INNER JOIN site05.tblRole ON site05.tblUser.RoleID = site05.tblRole.RoleID
				WHERE		(tblLocationManager.LocationManagerID = @LocationManagerID)
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [site05].[spValidateStudent]    Script Date: 27/01/2019 22:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[spValidateStudent]
@StudentID int,
@Password nvarchar(max),
@Token nvarchar(100)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT tblStudent.StudentID FROM tblStudent INNER JOIN tblUser ON tblStudent.UserID = tblUser.UserID WHERE (tblStudent.StudentID = @StudentID) AND (tblUser.Password = @Password) AND (tblStudent.IsActive = 1) AND (tblUser.AfterFirstLogin = 0 OR tblUser.Token = @Token))
			BEGIN
				UPDATE tblUser
				SET Token = @Token, AfterFirstLogin = 1
				FROM tblStudent INNER JOIN
				tblUser ON tblStudent.UserID = tblUser.UserID INNER JOIN
				tblDepartment ON tblStudent.DepartmentID = tblDepartment.DepartmentID INNER JOIN
				tblCycle ON tblStudent.CycleID = tblCycle.CycleID INNER JOIN
				tblRole ON tblUser.RoleID = tblRole.RoleID
				WHERE (tblStudent.StudentID = @StudentID)

				SELECT        tblStudent.StudentID, tblStudent.FirstName, tblStudent.LastName, tblStudent.Email, tblStudent.Picture, tblUser.UserID, tblUser.Password, tblRole.RoleID, tblRole.RoleName, tblDepartment.DepartmentID, 
								 tblDepartment.DepartmentName, tblCycle.CycleID, tblCycle.CycleName, tblCycle.Year, tblUser.Token
				FROM            tblStudent INNER JOIN
								 tblUser ON tblStudent.UserID = tblUser.UserID INNER JOIN
								 tblDepartment ON tblStudent.DepartmentID = tblDepartment.DepartmentID INNER JOIN
								 tblCycle ON tblStudent.CycleID = tblCycle.CycleID INNER JOIN
								 tblRole ON tblUser.RoleID = tblRole.RoleID
				WHERE        (tblStudent.StudentID = @StudentID)
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [site05] SET  READ_WRITE 
GO
