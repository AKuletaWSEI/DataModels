USE [ContosoRetailDW]
GO

DROP VIEW IF EXISTS [olap].[vFactITSLA]
DROP VIEW IF EXISTS [olap].[vDimDate]
DROP VIEW IF EXISTS [olap].[vDimStore]
DROP VIEW IF EXISTS [olap].[vDimMachine]
DROP VIEW IF EXISTS [olap].[vDimOutage]
DROP VIEW IF EXISTS [olap].[vDimEntity]
DROP VIEW IF EXISTS [olap].[vDimGeography]
DROP VIEW IF EXISTS [olap].[vFactITMachine]
GO

DROP SCHEMA IF EXISTS [olap]
GO

---------------------------------------------------------------------

CREATE SCHEMA [olap]
GO

---------------------------------------------------------------------

CREATE VIEW [olap].[vFactITSLA]
AS
SELECT 
	[ITSLAkey]
,	[DateKey]
,	[StoreKey]
,	[MachineKey]
,	[OutageKey]
,	[OutageStartTime]
,	[OutageEndTime]
,	[DownTime]
,	[DownTimeHrs] = [DownTime] / 60.0
FROM [dbo].[FactITSLA]
GO

CREATE VIEW [olap].[vDimDate]
AS	
SELECT
    [Datekey]
,   [FullDateLabel]
,   [DateDescription]
,   [CalendarYearLabel]
,   [CalendarYear]
,   [CalendarHalfYearLabel]
,   [CalendarHalfYear]
,   [CalendarQuarterLabel]
,   [CalendarQuarter]
,   [CalendarMonthLabel]
,   [CalendarMonth]
,   [IsWorkDay]
FROM [dbo].[DimDate]
GO


CREATE VIEW [olap].[vDimStore]
AS
SELECT
    [StoreKey]
,   [StoreType]
,   [StoreName]
,   [StoreDescription]
,   [Status]
,   [GeographyKey]
,   [EntityKey]
FROM [dbo].[DimStore]
GO

CREATE VIEW [olap].[vDimMachine]
AS	
SELECT 
	[MachineKey]
,	[MachineLabel]
,	[MachineType]
,	[MachineName]
,	[MachineDescription]
,	[VendorName]
,	[MachineOS]
,	[MachineSource]
,	[MachineHardware]
,	[MachineSoftware]
,	[Status]
FROM [dbo].[DimMachine]
GO

CREATE VIEW [olap].[vDimOutage]
AS	
SELECT 
	[OutageKey]
,	[OutageLabel]
,	[OutageName]
,	[OutageDescription]
,	[OutageType]
,	[OutageTypeDescription]
,	[OutageSubType]
,	[OutageSubTypeDescription] 
FROM [dbo].[DimOutage]
GO

CREATE VIEW [olap].[vDimEntity]
AS
SELECT
    [EntityKey]
,   [EntityLabel]
,   [ParentEntityKey]
,   [EntityName]
,   [EntityDescription]
,   [EntityType]
,   [Status]
FROM
    [dbo].[DimEntity]
GO

CREATE VIEW [olap].[vDimGeography]
AS
SELECT
    [GeographyKey]
,	[GeographyName]	=	CASE [GeographyType]
							WHEN	'City'				THEN [CityName]
							WHEN	'Continent'			THEN [ContinentName]
							WHEN	'Country/Region'	THEN [RegionCountryName]
							WHEN	'State/Province'	THEN [StateProvinceName]
							END
,   [GeographyType]
,   [ContinentName]
,   [CityName]
,   [StateProvinceName]
,   [RegionCountryName]
FROM
    [dbo].[DimGeography]
GO

CREATE VIEW [olap].[vFactITMachine]
AS
SELECT
    [ITMachinekey]
,   [MachineKey]
,   [Datekey]
,   [CostAmount]
,   [CostType]
FROM
    [dbo].[FactITMachine]
GO