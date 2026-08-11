USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [sales].OrderItems)
BEGIN
    DECLARE @OrderID INT = 1;
    DECLARE @MaxOrderID INT = (SELECT MAX(OrderID) FROM [sales].Orders);
    
    -- دریافت ID چند محصول
    DECLARE @VarIPhone INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'APP-IP14-BLK');
    DECLARE @VarNike INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'NIK-PEG-BLK-43');

    WHILE @OrderID <= @MaxOrderID
    BEGIN
        -- آیتم اول: آیفون
        INSERT INTO [sales].OrderItems (OrderID, VariantID, Quantity, UnitPrice, Discount, Tax, TotalPrice)
        VALUES (@OrderID, @VarIPhone, 1, 999.00, 0.00, 10.00, 1009.00);

        -- برای سفارشات زوج، کفش نایک هم اضافه می‌کنیم
        IF @OrderID % 2 = 0
        BEGIN
            INSERT INTO [sales].OrderItems (OrderID, VariantID, Quantity, UnitPrice, Discount, Tax, TotalPrice)
            VALUES (@OrderID, @VarNike, 1, 120.00, 5.00, 2.00, 117.00);
        END

        SET @OrderID = @OrderID + 1;
    END

    PRINT 'Items added to orders successfully.';
END
GO