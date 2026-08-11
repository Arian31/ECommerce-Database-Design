USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'OrderCoupons' AND schema_id = SCHEMA_ID('sales')
)
BEGIN
	CREATE TABLE [sales].OrderCoupons
	(
		OrderID INT NOT NULL,
		CouponID INT NOT NULL,

		CONSTRAINT PK_OrderCoupons PRIMARY KEY (OrderID, CouponID)
	)
END
GO

