USE ECommerceDB
GO

IF (SELECT COUNT(*) FROM [customer].Addresses) < 100
BEGIN
    DECLARE @i INT = 1;
    DECLARE @City NVARCHAR(25);
    DECLARE @Province NVARCHAR(25);
    DECLARE @PostalCode NVARCHAR(20);
    DECLARE @AddressLine NVARCHAR(200);

    WHILE @i <= 100
    BEGIN
        -- تولید داده‌های بین‌المللی بر اساس باقیمانده تقسیم i
        IF @i % 5 = 0 BEGIN SET @City = N'New York'; SET @Province = N'NY'; SET @PostalCode = '10001'; SET @AddressLine = CAST(@i AS VARCHAR) + ' 5th Ave'; END
        ELSE IF @i % 5 = 1 BEGIN SET @City = N'London'; SET @Province = N'Greater London'; SET @PostalCode = 'SW1A 1AA'; SET @AddressLine = CAST(@i AS VARCHAR) + ' Baker St'; END
        ELSE IF @i % 5 = 2 BEGIN SET @City = N'Tokyo'; SET @Province = N'Tokyo'; SET @PostalCode = '100-0001'; SET @AddressLine = CAST(@i AS VARCHAR) + ' Chiyoda City'; END
        ELSE IF @i % 5 = 3 BEGIN SET @City = N'Berlin'; SET @Province = N'Berlin'; SET @PostalCode = '10115'; SET @AddressLine = CAST(@i AS VARCHAR) + ' Friedrichstraße'; END
        ELSE BEGIN SET @City = N'Paris'; SET @Province = N'Île-de-France'; SET @PostalCode = '75001'; SET @AddressLine = CAST(@i AS VARCHAR) + ' Rue de Rivoli'; END

        -- درج آدرس اول برای هر کاربر (آدرس پیش‌فرض)
        INSERT INTO [customer].Addresses 
        (
            UserID, Province, City, PostalCode, AddressLine, 
            ReceiverName, ReceiverPhone, IsDefault, CreatedAt
        )
        SELECT 
            UserID, @Province, @City, @PostalCode, @AddressLine, 
            FirstName + ' ' + LastName, PhoneNumber, 1, GETDATE()
        FROM [Security].Users 
        WHERE UserID = @i;

        -- برای هر ۱۰ کاربر، یک آدرس دوم (غیر پیش‌فرض) هم اضافه می‌کنیم تا تنوع ایجاد شود
        IF @i % 10 = 0
        BEGIN
            INSERT INTO [customer].Addresses 
            (
                UserID, Province, City, PostalCode, AddressLine, 
                ReceiverName, ReceiverPhone, IsDefault, CreatedAt
            )
            SELECT 
                UserID, N'California', N'Los Angeles', '90001', 'Sunset Blvd ' + CAST(@i AS VARCHAR), 
                FirstName + ' ' + LastName, PhoneNumber, 0, GETDATE()
            FROM [Security].Users 
            WHERE UserID = @i;
        END

        SET @i = @i + 1;
    END

    PRINT 'Global Addresses Seeded Successfully.';
END
ELSE
BEGIN
    PRINT 'Addresses table already has data.';
END
GO