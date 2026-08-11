USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'OrderItems' AND schema_id = SCHEMA_ID('sales')
)
BEGIN
	CREATE TABLE [sales].OrderItems
	(
		OrderItemID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		OrderID INT NOT NULL,
		VariantID INT NOT NULL,
		Quantity INT NOT NULL,
		UnitPrice DECIMAL(18,2) NOT NULL,
		Discount DECIMAL(18,2) NOT NULL,
		Tax DECIMAL(18,2) NOT NULL,
		TotalPrice DECIMAL(18,2) NOT NULL
	)
END
GO

-- *** OrderItems FK: Order ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_OrderItems_Orders'
)
BEGIN
    ALTER TABLE [sales].OrderItems
    ADD CONSTRAINT FK_OrderItems_Orders
    FOREIGN KEY(OrderID)
    REFERENCES [sales].Orders(OrderID)
END
GO

