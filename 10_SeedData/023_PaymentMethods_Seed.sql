USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [payment].PaymentMethods)
BEGIN
    INSERT INTO [payment].PaymentMethods (MethodName, IsActive)
    VALUES 
    (N'Credit Card', 1),
    (N'PayPal', 1),
    (N'Wire Transfer', 1),
    (N'Cryptocurrency', 1),
    (N'Cash on Delivery', 1);

    PRINT 'Global Payment Methods seeded successfully.';
END
GO