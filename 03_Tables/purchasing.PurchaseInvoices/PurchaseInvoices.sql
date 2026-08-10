USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'PurchaseInvoices' AND schema_id = SCHEMA_ID('purchasing')
)
BEGIN
	CREATE TABLE [purchasing].PurchaseInvoices
	(
		PurchaseID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		SupplierID INT NOT NULL,
		InvoiceNumber NVARCHAR(50) UNIQUE NOT NULL, -- ÿ»ﬁ ŒÊ«” Â ‘„« UNIQUE «÷«›Â ‘œ
		PurchaseDate DATETIME2 NOT NULL,
		TotalAmount DECIMAL(18,2) NOT NULL,
		[Status] TINYINT NOT NULL
	)
END
GO

