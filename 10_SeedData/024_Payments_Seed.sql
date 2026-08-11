USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [payment].Payments)
BEGIN
    DECLARE @OrderID INT = 1;
    DECLARE @MaxOrderID INT = (SELECT MAX(OrderID) FROM [sales].Orders);
    DECLARE @MethodID INT = (SELECT TOP 1 PaymentMethodID FROM [payment].PaymentMethods WHERE MethodName = 'Credit Card');

    WHILE @OrderID <= @MaxOrderID
    BEGIN
        -- برای هر سفارش یک تراکنش ثبت می‌کنیم
        INSERT INTO [payment].Payments 
        (OrderID, PaymentMethodID, TransactionCode, Amount, PaymentDate, [Status], GatewayResponse)
        VALUES 
        (
            @OrderID, 
            @MethodID, 
            N'TXN-' + CAST(NEWID() AS NVARCHAR(50)), -- تولید کد تراکنش یونیک و تصادفی
            1020.00, -- مبلغ هماهنگ با سفارش تستی
            GETDATE(), 
            2, -- 2: Success
            N'{"status": "approved", "auth_code": "123456"}' -- شبیه‌سازی پاسخ JSON درگاه
        );
        SET @OrderID = @OrderID + 1;
    END

    PRINT 'Payments for orders seeded successfully.';
END
GO