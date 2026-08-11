USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [sales].ShoppingCarts)
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= 30
    BEGIN
        INSERT INTO [sales].ShoppingCarts (UserID, CreatedAt, [Status])
        VALUES 
        (
            @i, 
            DATEADD(DAY, -@i, GETDATE()), -- تاریخ‌های مختلف در روزهای گذشته
            CASE 
                WHEN @i <= 10 THEN 1 -- Active (در حال استفاده)
                WHEN @i <= 20 THEN 2 -- Abandoned (رها شده)
                ELSE 3               -- ConvertedToOrder (تبدیل به سفارش شده)
            END
        );
        SET @i = @i + 1;
    END

    PRINT '30 Shopping Carts seeded successfully.';
END
GO