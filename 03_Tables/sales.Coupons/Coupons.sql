USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Coupons' AND schema_id = SCHEMA_ID('sales')
)
BEGIN
	CREATE TABLE [sales].Coupons
	(
		CouponID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		CouponCode NVARCHAR(50) UNIQUE NOT NULL, -- کد تخفیف باید یکتا باشد
		DiscountType TINYINT NOT NULL,           -- مثلاً 1 برای درصد، 2 برای مبلغ ثابت
		DiscountValue DECIMAL(18,2) NOT NULL,
		StartDate DATETIME2 NOT NULL,
		EndDate DATETIME2 NOT NULL,
		MaximumUsage INT NOT NULL,
		UsedCount INT DEFAULT 0 NOT NULL,
		MinimumOrderAmount DECIMAL(18,2) NOT NULL,
		IsActive BIT DEFAULT 1 NOT NULL
	)
END
GO