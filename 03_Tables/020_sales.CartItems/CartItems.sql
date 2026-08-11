USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'CartItems' AND schema_id = SCHEMA_ID('sales')
)
BEGIN
	CREATE TABLE [sales].CartItems
	(
		CartItemID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		CartID INT NOT NULL,
		VariantID INT NOT NULL,
		Quantity INT NOT NULL,
		Price DECIMAL(18,2) NOT NULL
	)
END
GO



