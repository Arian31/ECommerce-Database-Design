USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [system].Notifications)
BEGIN
    DECLARE @UserID1 INT = 1;
    DECLARE @UserID2 INT = 2;

    INSERT INTO [system].Notifications (UserID, Title, [Message], IsRead, CreatedAt)
    VALUES 
    (@UserID1, N'Welcome to Global Store!', N'Thank you for joining us. Enjoy your shopping!', 1, GETDATE()),
    (@UserID1, N'Order Shipped', N'Your order #1 has been shipped via DHL.', 0, GETDATE()),
    (@UserID2, N'Price Drop Alert', N'An item in your wishlist is now on sale!', 0, GETDATE());

    PRINT 'System notifications seeded successfully.';
END
GO