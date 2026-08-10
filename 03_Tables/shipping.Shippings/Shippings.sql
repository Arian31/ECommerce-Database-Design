--  جدول اصلی مرسولات
IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Shippings' AND schema_id = SCHEMA_ID('shipping')
)
BEGIN
	CREATE TABLE [shipping].Shippings
	(
		ShippingID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		OrderID INT NOT NULL,
		ShippingCompanyID INT NOT NULL,
		TrackingNumber NVARCHAR(50) NULL,
		ShipDate DATETIME2 NULL,
		DeliveryDate DATETIME2 NULL,
		ShippingStatus TINYINT NOT NULL -- 1: Preparing, 2: Shipped, 3: Delivered, 4: Returned
	)
END
GO
