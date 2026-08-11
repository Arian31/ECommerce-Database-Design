USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [sales].Orders)
BEGIN
    DECLARE @i INT = 1;
    DECLARE @AddrID INT;

    WHILE @i <= 20
    BEGIN
        -- پیدا کردن یکی از آدرس‌های کاربر
        SET @AddrID = (SELECT TOP 1 AddressID FROM [customer].Addresses WHERE UserID = @i);

        INSERT INTO [sales].Orders 
        (
            UserID, AddressID, OrderDate, OrderStatus, PaymentStatus, 
            ShippingCost, DiscountAmount, TaxAmount, FinalAmount, TrackingCode, [Description]
        )
        VALUES 
        (
            @i, 
            @AddrID, 
            DATEADD(DAY, -@i, GETDATE()), 
            CASE WHEN @i % 5 = 0 THEN 4 ELSE 2 END, -- 4: Delivered, 2: Processing
            CASE WHEN @i % 5 = 0 THEN 2 ELSE 1 END, -- 2: Paid, 1: Unpaid
            15.00,  -- هزینه ارسال ثابت
            0.00,   -- تخفیف فعلا صفر
            5.00,   -- مالیات تستی
            1020.00, -- مبلغ نهایی تستی
            CASE WHEN @i % 5 = 0 THEN 'TRK' + CAST(@i AS VARCHAR) ELSE NULL END,
            N'Test order for global delivery'
        );
        SET @i = @i + 1;
    END

    PRINT '20 Orders seeded successfully.';
END
GO