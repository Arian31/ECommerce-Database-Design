USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [review].Reviews)
BEGIN
    DECLARE @ProductID INT = (SELECT TOP 1 ProductID FROM [Catalog].Products WHERE Slug = 'iphone-14-pro');
    DECLARE @UserID INT = 1;

    INSERT INTO [review].Reviews (ProductID, UserID, Rate, Comment, CreatedAt, IsApproved)
    VALUES 
    (@ProductID, @UserID, 5, N'Amazing build quality and the camera is outstanding!', GETDATE(), 1),
    (@ProductID, @UserID + 1, 4, N'Great phone, but the battery life could be better.', GETDATE(), 1),
    (@ProductID, @UserID + 2, 2, N'Too expensive for what it offers.', GETDATE(), 0), -- تایید نشده
    (@ProductID, @UserID + 3, 5, N'Switching from Android was the best decision.', GETDATE(), 1);

    PRINT 'Product reviews seeded successfully.';
END
GO