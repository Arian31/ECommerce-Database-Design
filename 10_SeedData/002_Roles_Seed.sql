USE ECommerceDB
GO

-- وارد کردن نقش‌های اصلی
IF NOT EXISTS (SELECT 1 FROM [Security].Roles)
BEGIN
    INSERT INTO [Security].Roles (RoleName, [Description])
    VALUES 
    (N'SuperAdmin', N'Full access to all system settings and security.'),
    (N'Admin', N'Daily operational management of the store.'),
    (N'SalesManager', N'Management of orders, coupons, and sales reports.'),
    (N'InventoryManager', N'Management of warehouses, stock, and suppliers.'),
    (N'CustomerService', N'Managing product reviews, questions, and support tickets.'),
    (N'Customer', N'Standard buyer with access to profile and order history.');

    PRINT 'Global Roles inserted successfully.';
END
GO