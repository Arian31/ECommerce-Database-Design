USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'ShoppingCarts' AND schema_id = SCHEMA_ID('sales')
)
BEGIN
	CREATE TABLE [sales].ShoppingCarts
	(
		CartID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		UserID INT NOT NULL,
		CreatedAt DATETIME2 NOT NULL,
		[Status] TINYINT NOT NULL -- 1: Active, 2: Abandoned, 3: ConvertedToOrder
	)
END
GO

