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



-- ۱. ابتدا نوع ستون را به NOT NULL تغییر می‌دهیم
ALTER TABLE [payment].Payments
ALTER COLUMN TransactionCode NVARCHAR(100) NOT NULL;
GO

-- ۲. حالا قید UNIQUE را به آن اضافه می‌کنیم
IF NOT EXISTS (SELECT * FROM sys.objects WHERE name = 'UQ_Payments_TransactionCode')
BEGIN
    ALTER TABLE [payment].Payments
    ADD CONSTRAINT UQ_Payments_TransactionCode UNIQUE (TransactionCode);
END
GO