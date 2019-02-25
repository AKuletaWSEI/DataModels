USE [WideWorldImportersDW]
GO

DROP VIEW IF EXISTS [olap].[vFactOrder]
DROP VIEW IF EXISTS [olap].[vFactSale]
DROP VIEW IF EXISTS [olap].[vFactPurchase]
DROP VIEW IF EXISTS [olap].[vDimDate]
DROP VIEW IF EXISTS [olap].[vDimCity]
DROP VIEW IF EXISTS [olap].[vDimCustomer]
DROP VIEW IF EXISTS [olap].[vDimStockItem]
DROP VIEW IF EXISTS [olap].[vDimSupplier]
GO

DROP SCHEMA IF EXISTS [olap]
GO

---------------------------------------------------------------------

CREATE SCHEMA [olap]
GO

---------------------------------------------------------------------

CREATE VIEW [olap].[vFactOrder]
AS
SELECT 
	[Order Key]				AS	[OrderKey]
,	[City Key]				AS	[CityKey]
,	[Customer Key]			AS	[CustomerKey]
,	[Stock Item Key]		AS	[StockItemKey]
,	[Order Date Key]		AS	[OrderDateKey]  
,	[Description]			AS	[Description]
,	[Package]				AS	[Package]
,	[Quantity]				AS	[Quantity]
,	[Total Excluding Tax]	AS	[TotalExcludingTax]
,	[Tax Amount]			AS	[TaxAmount]
,	[Total Including Tax]	AS	[TotalIncludingTax]
FROM [Fact].[Order]
GO

CREATE VIEW [olap].[vFactSale]
AS
SELECT 
	[Sale Key]				AS	[SaleKey]				
,	[City Key]				AS	[CityKey]				
,	[Customer Key]			AS	[CustomerKey]			
,	[Stock Item Key]		AS	[StockItemKey]		
,	[Invoice Date Key]		AS	[InvoiceDateKey]		
,	[Delivery Date Key]		AS	[DeliveryDateKey]			
,	[Quantity]				AS	[Quantity]				
,	[Unit Price]			AS	[UnitPrice]			
,	[Tax Rate]				AS	[TaxRate]				
,	[Total Excluding Tax]	AS	[TotalExcludingTax]	
,	[Tax Amount]			AS	[TaxAmount]			
,	[Profit]				AS	[Profit]				
,	[Total Including Tax]	AS	[TotalIncludingTax]		
FROM [Fact].[Sale]
GO

CREATE VIEW [olap].[vFactPurchase]
AS
SELECT 
	[Purchase Key]					AS	[PurchaseKey]		
,	[Date Key]						AS	[DateKey]			
,	[Supplier Key]					AS	[SupplierKey]		
,	p.[Stock Item Key]				AS	[StockItemKey]
,	i.[Tax Rate]					AS	[TaxRate]
,	i.[Unit Price]					AS	[UnitPrice]
,	i.[Recommended Retail Price]	AS	[RecommendedRetailPrice]
,	i.[Typical Weight Per Unit]		AS	[TypicalWeightPerUnit]	
,	[Ordered Outers]				AS	[OrderedOuters]	
,	[Ordered Quantity]				AS	[OrderedQuantity]	
,	[Received Outers]				AS	[ReceivedOuters]	
,	[Package]						AS	[Package]			
,	[Is Order Finalized]			AS	[IsOrderFinalized]
FROM [Fact].[Purchase] p
LEFT JOIN [Dimension].[Stock Item] i ON p.[Stock Item Key] = i.[Stock Item Key]
GO

CREATE VIEW [olap].[vDimDate]
AS
SELECT 
	[Date]					AS [Day]
,	[Month]	= DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 1)
,	[Year]	= DATEFROMPARTS(YEAR([Date]), 1, 1)
,	[Day Number]			AS	[DayNumber]
,	[Short Month]			AS	[ShortMonth]
,	[Calendar Year Label]	AS	[CalendarYearLabel]
,	[ISO Week Number]		AS	[ISOWeekNumber]
FROM [Dimension].[Date]
GO

CREATE VIEW [olap].[vDimCity]
AS
SELECT 
	[City Key]						AS	[CityKey]	
,	[City]							AS	[CityName]		
,	[City] + ', '+[State Province]	AS	[City]			
,	[State Province]				AS	[StateProvince]	
,	[Country]						AS	[Country]			
,	[Continent]						AS	[Continent]			
,	[Sales Territory]				AS	[SalesTerritory]	
,	[Region]						AS	[Region]			
,	[Subregion]						AS	[Subregion]			
FROM [Dimension].[City]
GO



CREATE VIEW [olap].[vDimCustomer]
AS
SELECT 
	[Customer Key]			AS	[CustomerKey]
,	[Customer]				AS	[Customer]
,	[Bill To Customer]		AS	[BillToCustomer]
,	[Category]				AS	[Category]
,	[Buying Group]			AS	[BuyingGroup]
,	[Primary Contact]		AS	[PrimaryContact]
,	[Postal Code]			AS	[PostalCode]
FROM [Dimension].[Customer]
GO

CREATE VIEW [olap].[vDimStockItem]
AS
SELECT 
	[Stock Item Key]			AS	[StockItemKey]
,	[Stock Item]				AS	[StockItem]
,	[Color]						AS	[Color]
,	[Selling Package]			AS	[SellingPackage]
,	[Buying Package]			AS	[BuyingPackage]
,	[Brand]						AS	[Brand]
,	[Size]						AS	[Size]
,	[Lead Time Days]			AS	[LeadTimeDays]
,	[Quantity Per Outer]		AS	[QuantityPerOuter]
,	[Is Chiller Stock]			AS	[IsChillerStock]
FROM [Dimension].[Stock Item]
GO

CREATE VIEW [olap].[vDimSupplier]
AS
SELECT 
	[Supplier Key]			AS	[SupplierKey]
,	[Supplier]				AS	[Supplier]
,	[Category]				AS	[Category]
,	[Primary Contact]		AS	[PrimaryContact]
,	[Supplier Reference]	AS	[SupplierReference]
,	[Payment Days]			AS	[PaymentDays]
,	[Postal Code]			AS	[PostalCode]
FROM [WideWorldImportersDW].[Dimension].[Supplier]