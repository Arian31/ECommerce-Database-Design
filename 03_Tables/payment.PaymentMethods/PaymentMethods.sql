USE ECommerceDB
GO

-- جدول پایه برای روش‌های پرداخت (آنلاین، نقدی و ...)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'PaymentMethods' AND schema_id = SCHEMA_ID('payment'))
BEGIN
    CREATE TABLE [payment].PaymentMethods
    (
        PaymentMethodID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        MethodName NVARCHAR(50) NOT NULL,
        IsActive BIT DEFAULT 1 NOT NULL
    )
END
GO

-- جدول اصلی پرداخت‌ها
IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Payments' AND schema_id = SCHEMA_ID('payment')
)
BEGIN
	CREATE TABLE [payment].Payments
	(
		PaymentID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		OrderID INT NOT NULL,
		PaymentMethodID INT NOT NULL,
		TransactionCode NVARCHAR(100) NULL,
		Amount DECIMAL(18,2) NOT NULL CHECK (Amount >= 0), -- شرط مبلغ مثبت
		PaymentDate DATETIME2 NOT NULL,
		[Status] TINYINT NOT NULL, -- 1: Pending, 2: Success, 3: Failed, 4: Refunded
		GatewayResponse NVARCHAR(MAX) NULL -- برای ذخیره پاسخ جیسون درگاه
	)
END
GO

