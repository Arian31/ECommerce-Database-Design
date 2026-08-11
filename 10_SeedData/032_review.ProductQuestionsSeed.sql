USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [review].ProductQuestions)
BEGIN
    DECLARE @ProductID INT = (SELECT TOP 1 ProductID FROM [Catalog].Products WHERE Slug = 'iphone-14-pro');
    DECLARE @UserID INT = 10; -- کاربر دهم دیتابیس

    INSERT INTO [review].ProductQuestions (ProductID, UserID, Question, CreatedAt)
    VALUES 
    (@ProductID, @UserID, N'Does this iPhone come with an international warranty?', GETDATE()),
    (@ProductID, @UserID + 1, N'Is the charging brick included in the global version?', GETDATE());

    PRINT 'Product questions seeded successfully.';
END
GO