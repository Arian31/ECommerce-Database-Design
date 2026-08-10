USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Sizes' AND schema_id = SCHEMA_ID('catalog')
)
BEGIN
	CREATE TABLE [catalog].Sizes
	(
		SizeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		SizeValue NVARCHAR(20) NOT NULL, -- „À· XL, 42, 10-inch
		[Description] NVARCHAR(100) NULL,
		CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE()
	)
END
GO

