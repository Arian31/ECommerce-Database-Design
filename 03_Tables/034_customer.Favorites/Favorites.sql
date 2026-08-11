USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Favorites' AND schema_id = SCHEMA_ID('customer')
)
BEGIN
	CREATE TABLE [customer].Favorites
	(
		FavoriteID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		UserID INT NOT NULL,
		ProductID INT NOT NULL,
		CreatedAt DATETIME2 NOT NULL,

		-- جلوگیری از لایک تکراری یک محصول توسط یک کاربر
		CONSTRAINT UQ_User_Product_Favorite UNIQUE (UserID, ProductID)
	)
END
GO