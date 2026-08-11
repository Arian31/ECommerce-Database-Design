USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Products'
)
BEGIN
	CREATE TABLE [Catalog].Products
	(
		ProductID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		CategoryID INT NOT NULL,
		BrandID INT NOT NULL,
		ProductName NVARCHAR(200) NOT NULL,
		Slug NVARCHAR(250) UNIQUE NOT NULL,
		[Description] NVARCHAR(MAX) NULL,
		[Weight] DECIMAL(10,2) NULL,
		[Length] DECIMAL(10,2) NULL,
		[Width] DECIMAL(10,2) NULL,
		[Height] DECIMAL(10,2) NULL,
		WarrantyMonths INT DEFAULT 0 NOT NULL,
		[Status] TINYINT DEFAULT 1 NOT NULL, -- 1: Active, 2: Out of Stock, 3: Draft
		CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
		UpdatedAt DATETIME2 NULL
	)
END
GO

