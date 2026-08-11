--  ÌÏזב WishListItems
IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'WishListItems' AND schema_id = SCHEMA_ID('customer')
)
BEGIN
	CREATE TABLE [customer].WishListItems
	(
		WishListID INT NOT NULL,
		VariantID INT NOT NULL,

		CONSTRAINT PK_WishListItems PRIMARY KEY (WishListID, VariantID)
	)
END
GO