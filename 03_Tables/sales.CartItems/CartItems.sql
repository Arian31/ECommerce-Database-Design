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

-- *** CartItems FK: ShoppingCart ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_CartItems_ShoppingCarts'
)
BEGIN
    ALTER TABLE [sales].CartItems
    ADD CONSTRAINT FK_CartItems_ShoppingCarts
    FOREIGN KEY(CartID)
    REFERENCES [sales].ShoppingCarts(CartID)
END
GO

