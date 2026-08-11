USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Colors' AND schema_id = SCHEMA_ID('catalog')
)
BEGIN
	CREATE TABLE [catalog].Colors
	(
		ColorID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		ColorName NVARCHAR(30) NOT NULL,
		ColorCode NVARCHAR(10) NULL, -- ذخیره کد هگزا مثل #FFFFFF
		CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE()
	)
END
GO