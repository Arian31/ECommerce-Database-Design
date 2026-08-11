USE ECommerceDB
GO

-- ÌÏזב WishLists
IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'WishLists' AND schema_id = SCHEMA_ID('customer')
)
BEGIN
	CREATE TABLE [customer].WishLists
	(
		WishListID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		UserID INT NOT NULL,
		CreatedAt DATETIME2 NOT NULL
	)
END
GO