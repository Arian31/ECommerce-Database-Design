USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [sales].CartItems)
BEGIN
    -- دریافت چند نمونه از تنوع محصولات
    DECLARE @VarIPhone INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'APP-IP14-BLK');
    DECLARE @VarNike INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'NIK-PEG-BLK-43');

    DECLARE @CartID INT = 1;
    DECLARE @MaxCartID INT = (SELECT MAX(CartID) FROM [sales].ShoppingCarts);

    WHILE @CartID <= @MaxCartID
    BEGIN
        -- آیتم اول برای هر سبد
        INSERT INTO [sales].CartItems (CartID, VariantID, Quantity, Price)
        VALUES (@CartID, @VarIPhone, 1, 999.00);

        -- برای سبدهای زوج، یک آیتم دوم هم اضافه می‌کنیم
        IF @CartID % 2 = 0
        BEGIN
            INSERT INTO [sales].CartItems (CartID, VariantID, Quantity, Price)
            VALUES (@CartID, @VarNike, 2, 120.00);
        END

        SET @CartID = @CartID + 1;
    END

    PRINT 'Items added to shopping carts successfully.';
END
GO