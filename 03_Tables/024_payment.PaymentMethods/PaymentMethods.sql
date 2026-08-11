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

