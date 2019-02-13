USE [ContosoRetailDW]
GO

DROP VIEW IF EXISTS [olap].[vFactInventory]
DROP VIEW IF EXISTS [olap].[vDimProduct]
DROP VIEW IF EXISTS [olap].[vDimCurrency]
GO

---------------------------------------------------------------------

CREATE VIEW [olap].[vFactInventory]
AS
SELECT	
	[InventoryKey]
,	[DateKey]
,	[StoreKey]
,	[ProductKey]
,	[CurrencyKey]
,	[OnHandQuantity]
,	[OnOrderQuantity]
,	[SafetyStockQuantity]
,	[UnitCost]
,	[DaysInStock]
,	[MinDayInStock]
,	[MaxDayInStock]
FROM [dbo].[FactInventory]
GO

CREATE VIEW [olap].[vDimProduct]
AS
SELECT	
	[ProductKey]
,	p.[ProductLabel]
,	p.[ProductName]
,	p.[ProductDescription]
,	p.[Manufacturer]
,	p.[BrandName]
,	p.[ClassID]
,	p.[ClassName]
,	p.[StyleID]
,	p.[StyleName]
,	p.[ColorID]
,	p.[ColorName]

,	s.[ProductSubcategoryKey]
,	s.[ProductSubcategoryLabel]
,	s.[ProductSubcategoryName]
,	s.[ProductSubcategoryDescription]

,	c. [ProductCategoryKey]
,	c.[ProductCategoryLabel]
,	c.[ProductCategoryName]
,	c.[ProductCategoryDescription]
FROM	
			[dbo].[DimProduct] AS p
INNER JOIN	[dbo].[DimProductSubcategory]	AS s ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
INNER JOIN	[dbo].[DimProductCategory]		AS c ON s.ProductCategoryKey = c.ProductCategoryKey
GO

CREATE VIEW [olap].[vDimCurrency]
AS
SELECT 
	[CurrencyKey]
,	[CurrencyLabel]
,	[CurrencyName]
,	[CurrencyDescription]
FROM [dbo].[DimCurrency]
GO

---------------------------------------------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [olap].[vDimDate]
AS	
SELECT 
	[Datekey]
,	[FullDateLabel]
,	[DateDescription]
			
,	[IsWorkDay]

,	[CalendarYearLabel]
,	[CalendarHalfYearLabel]
,	[CalendarQuarterLabel]
,	[CalendarMonthLabel]

,	[CalendarYear]
,	[CalendarHalfYear]
,	[CalendarQuarter]
,	[CalendarMonth]

,	[FiscalYearLabel]
,	[FiscalHalfYearLabel]
,	[FiscalQuarterLabel]
,	[FiscalMonthLabel]

,	[FiscalYear]
,	[FiscalHalfYear]
,	[FiscalQuarter]
,	[FiscalMonth]

FROM [dbo].[DimDate]
GO