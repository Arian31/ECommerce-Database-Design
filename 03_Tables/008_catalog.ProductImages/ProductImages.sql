USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'ProductImages' AND schema_id = SCHEMA_ID('catalog')
)
BEGIN
	CREATE TABLE [catalog].ProductImages
	(
		ImageID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		ProductID INT NOT NULL,
		ImageUrl NVARCHAR(MAX) NOT NULL,
		DisplayOrder INT DEFAULT 0 NOT NULL, -- ترتیب نمایش در گالری
		IsMain BIT DEFAULT 0 NOT NULL,       -- عکس اصلی محصول (کاور)
		CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE()
	)
END
GO