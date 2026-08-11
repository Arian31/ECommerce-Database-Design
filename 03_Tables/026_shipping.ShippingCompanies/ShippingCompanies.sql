USE ECommerceDB
GO

--  جدول شرکت‌های حمل و نقل (Prerequisite)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ShippingCompanies' AND schema_id = SCHEMA_ID('shipping'))
BEGIN
    CREATE TABLE [shipping].ShippingCompanies
    (
        ShippingCompanyID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        CompanyName NVARCHAR(50) NOT NULL,
        ContactNumber NVARCHAR(20) NULL,
        IsActive BIT DEFAULT 1 NOT NULL
    )
END
GO