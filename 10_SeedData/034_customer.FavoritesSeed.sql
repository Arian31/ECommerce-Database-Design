USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [customer].Favorites)
BEGIN
    DECLARE @ProductID INT = (SELECT TOP 1 ProductID FROM [Catalog].Products WHERE Slug = 'nike-pegasus-39');
    
    INSERT INTO [customer].Favorites (UserID, ProductID, CreatedAt)
    VALUES 
    (1, @ProductID, GETDATE()),
    (2, @ProductID, GETDATE()),
    (3, (SELECT TOP 1 ProductID FROM [Catalog].Products WHERE Slug = 'macbook-air-m2'), GETDATE());

    PRINT 'Favorites seeded successfully.';
END
GO