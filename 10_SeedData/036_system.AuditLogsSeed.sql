USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [system].AuditLogs)
BEGIN
    DECLARE @AdminID INT = 1;

    INSERT INTO [system].AuditLogs (UserID, [Action], TableName, RecordID, LogDate, IPAddress)
    VALUES 
    (@AdminID, N'LOGIN', N'Users', @AdminID, GETDATE(), N'192.168.1.10'),
    (@AdminID, N'UPDATE', N'Products', 1, GETDATE(), N'192.168.1.10'),
    (NULL, N'FAILED_LOGIN', N'Users', NULL, GETDATE(), N'45.12.34.89'), -- ·«ê  ·«‘ ‰«„Ê›ﬁ
    (@AdminID, N'INSERT', N'Categories', 12, GETDATE(), N'192.168.1.10');

    PRINT 'System audit logs seeded successfully.';
END
GO