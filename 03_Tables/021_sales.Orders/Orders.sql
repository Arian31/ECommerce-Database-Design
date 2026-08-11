USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Orders' AND schema_id = SCHEMA_ID('sales')
)
BEGIN
	CREATE TABLE [sales].Orders
	(
		OrderID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		UserID INT NOT NULL,
		AddressID INT NOT NULL,
		OrderDate DATETIME2 NOT NULL,
		OrderStatus TINYINT NOT NULL,   -- 1: Pending, 2: Processing, 3: Shipped, 4: Delivered, 5: Canceled
		PaymentStatus TINYINT NOT NULL, -- 1: Unpaid, 2: Paid, 3: Refunded
		ShippingCost DECIMAL(18,2) NOT NULL,
		DiscountAmount DECIMAL(18,2) NOT NULL,
		TaxAmount DECIMAL(18,2) NOT NULL,
		FinalAmount DECIMAL(18,2) NOT NULL,
		TrackingCode NVARCHAR(50) NULL,
		[Description] NVARCHAR(500) NULL
	)
END
GO

