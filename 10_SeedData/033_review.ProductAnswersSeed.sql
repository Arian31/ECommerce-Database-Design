USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [review].ProductAnswers)
BEGIN
    DECLARE @Question1 INT = (SELECT TOP 1 QuestionID FROM [review].ProductQuestions WHERE Question LIKE '%warranty%');
    DECLARE @AdminID INT = 1; -- سوپر ادمین سیستم

    INSERT INTO [review].ProductAnswers (QuestionID, UserID, Answer, CreatedAt)
    VALUES 
    (@Question1, @AdminID, N'Yes, it includes a 1-year global limited warranty from Apple.', GETDATE());

    PRINT 'Product answers seeded successfully.';
END
GO