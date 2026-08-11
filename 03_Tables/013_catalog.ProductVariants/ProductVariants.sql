USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'ProductVariants' AND schema_id = SCHEMA_ID('catalog')
)
BEGIN
	CREATE TABLE [catalog].ProductVariants
	(
		VariantID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		ProductID INT NOT NULL,
		ColorID INT NULL,
		SizeID INT NULL,
		SKU NVARCHAR(50) UNIQUE NULL,         -- کد انبارداری واحد
		Barcode NVARCHAR(50) UNIQUE NULL,     -- بارکد محصول برای اسکنر
		Price DECIMAL(18,2) NOT NULL,         -- قیمت فروش این تنوع
		CostPrice DECIMAL(18,2) NULL,         -- قیمت خرید (برای محاسبه سود)
		--StockQuantity INT DEFAULT 0 NOT NULL,
		MinimumStock INT DEFAULT 0 NOT NULL,  -- حد هشدار برای شارژ مجدد انبار
		IsActive BIT DEFAULT 1 NOT NULL,
		CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
		UpdatedAt DATETIME2 NULL
	)
END
GO