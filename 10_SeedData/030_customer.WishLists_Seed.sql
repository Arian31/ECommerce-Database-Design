USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [customer].WishLists)
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= 10
    BEGIN
        INSERT INTO [customer].WishLists (UserID, CreatedAt)
        VALUES (@i, GETDATE());
        SET @i = @i + 1;
    END

    PRINT '10 WishLists created for the first 10 users.';
END
GO