USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [shipping].Shippings)
BEGIN
    DECLARE @OrderID INT;
    DECLARE @CompanyID INT = (SELECT TOP 1 ShippingCompanyID FROM [shipping].ShippingCompanies WHERE CompanyName = 'DHL Express');
    
    -- پیدا کردن سفارشاتی که وضعیت آن‌ها در جریان (2) یا تحویل شده (4) است
    DECLARE Ship_Cursor CURSOR FOR 
    SELECT OrderID FROM [sales].Orders WHERE OrderStatus IN (2, 4);

    OPEN Ship_Cursor;
    FETCH NEXT FROM Ship_Cursor INTO @OrderID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO [shipping].Shippings 
        (OrderID, ShippingCompanyID, TrackingNumber, ShipDate, DeliveryDate, ShippingStatus)
        VALUES 
        (
            @OrderID, 
            @CompanyID, 
            N'DHL-' + CAST(ABS(CHECKSUM(NEWID())) % 1000000 AS NVARCHAR(20)), -- تولید شماره پیگیری تصادفی
            DATEADD(DAY, 1, GETDATE()), -- تاریخ ارسال (فردا)
            CASE WHEN @OrderID % 5 = 0 THEN DATEADD(DAY, 3, GETDATE()) ELSE NULL END, -- تاریخ تحویل (۳ روز بعد برای برخی)
            CASE WHEN @OrderID % 5 = 0 THEN 3 ELSE 2 END -- 3: Delivered, 2: Shipped
        );
        
        FETCH NEXT FROM Ship_Cursor INTO @OrderID;
    END

    CLOSE Ship_Cursor;
    DEALLOCATE Ship_Cursor;

    PRINT 'Shipping records created successfully.';
END
GO