USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Inventory' AND schema_id = SCHEMA_ID('inventory')
)
BEGIN
	CREATE TABLE [inventory].Inventory
	(
		InventoryID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		WarehouseID INT NOT NULL,
		VariantID INT NOT NULL,
		Quantity INT NOT NULL
	)
END
GO

