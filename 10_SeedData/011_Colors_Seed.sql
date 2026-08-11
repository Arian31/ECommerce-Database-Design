USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [catalog].Colors)
BEGIN
    INSERT INTO [catalog].Colors (ColorName, ColorCode, CreatedAt)
    VALUES
	(N'Black', N'#000000', GETDATE()),
	(N'White', N'#FFFFFF', GETDATE()),
	(N'Silver', N'#C0C0C0', GETDATE()),
	(N'Space Gray', N'#535150', GETDATE()),
	(N'Gold', N'#FFD700', GETDATE()),
	(N'Navy Blue', N'#000080', GETDATE()),
	(N'Red', N'#FF0000', GETDATE()),
	(N'Midnight', N'#2E3641', GETDATE());

    PRINT 'Global Colors seeded successfully.';
END
GO