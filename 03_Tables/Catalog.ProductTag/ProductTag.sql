USE ECommerceDB
GO

IF NOT EXISTS
(
    SELECT *
    FROM sys.tables
    WHERE name = 'ProductTag'
)
BEGIN
    CREATE TABLE [Catalog].ProductTag
    (
        ProductID INT NOT NULL,
        TagID INT NOT NULL,

        CONSTRAINT PK_ProductTag
            PRIMARY KEY (ProductID, TagID)
    )
END
GO

