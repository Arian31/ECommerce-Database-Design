USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Suppliers' AND schema_id = SCHEMA_ID('purchasing')
)
BEGIN
	CREATE TABLE [purchasing].Suppliers
	(
		SupplierID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		CompanyName NVARCHAR(100) NOT NULL,
		ContactName NVARCHAR(50) NULL,
		Phone NVARCHAR(20) NULL,
		Email NVARCHAR(50) NULL,
		[Address] NVARCHAR(500) NULL
	)
END
GO