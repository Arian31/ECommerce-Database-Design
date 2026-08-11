
-- ۲. انتساب نقش‌ها به ۱۰۰ کاربر تستی (UserRoles)
IF NOT EXISTS (SELECT 1 FROM [Security].UserRoles)
BEGIN
    DECLARE @TotalUsers INT = (SELECT COUNT(*) FROM [Security].Users);
    DECLARE @RoleID INT;
    DECLARE @UserID INT = 1;

    WHILE @UserID <= @TotalUsers
    BEGIN
        -- منطق انتساب:
        -- کاربر ۱: SuperAdmin
        -- کاربران ۲ تا ۱۰: ترکیبی از ادمین و مدیران
        -- کاربران ۱۱ تا ۱۰۰: همگی Customer
        
        SET @RoleID = 
            CASE 
                WHEN @UserID = 1 THEN (SELECT RoleID FROM [Security].Roles WHERE RoleName = 'SuperAdmin')
                WHEN @UserID BETWEEN 2 AND 4 THEN (SELECT RoleID FROM [Security].Roles WHERE RoleName = 'Admin')
                WHEN @UserID BETWEEN 5 AND 7 THEN (SELECT RoleID FROM [Security].Roles WHERE RoleName = 'SalesManager')
                WHEN @UserID BETWEEN 8 AND 10 THEN (SELECT RoleID FROM [Security].Roles WHERE RoleName = 'InventoryManager')
                ELSE (SELECT RoleID FROM [Security].Roles WHERE RoleName = 'Customer')
            END;

        INSERT INTO [Security].UserRoles (UserID, RoleID, AssignedDate)
        VALUES (@UserID, @RoleID, GETDATE());

        SET @UserID = @UserID + 1;
    END

    PRINT 'Roles assigned to users successfully.';
END
GO