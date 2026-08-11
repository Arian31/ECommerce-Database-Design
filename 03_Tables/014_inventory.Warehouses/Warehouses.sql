USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Warehouses' AND schema_id = SCHEMA_ID('inventory')
)
BEGIN
	CREATE TABLE [inventory].Warehouses
	(
		WarehouseID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		WarehouseName NVARCHAR(50) NOT NULL,
		[Location] NVARCHAR(250) NULL,      -- آدرس فیزیکی انبار
		ManagerName NVARCHAR(50) NULL,       -- نام مدیر انبار
		ContactNumber NVARCHAR(20) NULL,     -- شماره تماس انبار
		IsActive BIT DEFAULT 1 NOT NULL,
		CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
		UpdatedAt DATETIME2 NULL
	)
END
GO