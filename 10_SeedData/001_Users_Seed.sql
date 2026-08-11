USE ECommerceDB
GO

-- جلوگیری از اجرای مجدد اگر داده از قبل وجود دارد
IF (SELECT COUNT(*) FROM [Security].Users) < 100
BEGIN
    DECLARE @i INT = 1;
    DECLARE @FirstName NVARCHAR(50);
    DECLARE @LastName NVARCHAR(50);
    DECLARE @Email NVARCHAR(50);
    DECLARE @Phone CHAR(20);
    DECLARE @NationalCode CHAR(10);
    DECLARE @Gender CHAR(1);

    WHILE @i <= 100
    BEGIN
        SET @FirstName = N'User' + CAST(@i AS NVARCHAR);
        SET @LastName = N'Family' + CAST(@i AS NVARCHAR);
        SET @Email = 'user' + CAST(@i AS VARCHAR) + '@test.com';
        SET @Phone = '0912' + RIGHT('0000000' + CAST(@i AS VARCHAR), 7);
        SET @NationalCode = RIGHT('0000000000' + CAST(@i AS VARCHAR), 10);
        
        -- چرخش بین جنسیت‌ها برای تنوع داده
        SET @Gender = CASE WHEN @i % 3 = 0 THEN 'M' 
                           WHEN @i % 3 = 1 THEN 'F' 
                           ELSE 'U' END;

        INSERT INTO [Security].Users 
        (
            FirstName, LastName, NationalCode, Email, 
            PhoneNumber, PasswordHash, BirthDate, Gender, 
            IsActive, CreatedAt
        )
        VALUES 
        (
            @FirstName, 
            @LastName, 
            @NationalCode, 
            @Email, 
            @Phone, 
            'e10adc3949ba59abbe56e057f20f883e', -- معادل هش شده 123456
            DATEADD(YEAR, - (20 + (@i % 30)), GETDATE()), -- سن بین 20 تا 50 سال
            @Gender, 
            1, -- همه تستی‌ها فعال باشند
            GETDATE()
        );

        SET @i = @i + 1;
    END

    PRINT '100 Test Users Inserted Successfully.';
END
ELSE
BEGIN
    PRINT 'Users table already has enough data.';
END
GO