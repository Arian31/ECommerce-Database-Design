USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'PurchaseItems' AND schema_id = SCHEMA_ID('purchasing')
)
BEGIN
	CREATE TABLE [purchasing].PurchaseItems
	(
		PurchaseItemID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		PurchaseID INT NOT NULL,
		VariantID INT NOT NULL,
		Quantity INT NOT NULL,
		UnitPrice DECIMAL(18,2) NOT NULL,
		Discount DECIMAL(18,2) NOT NULL,
		Tax DECIMAL(18,2) NOT NULL
	)
END
GO

