USE ECommerceDB
GO

CREATE PROCEDURE sales.usp_PlaceOrder
    @UserID INT,
    @AddressID INT,
    @ShippingCost DECIMAL(18,2),
    @DiscountAmount DECIMAL(18,2),
    @TaxAmount DECIMAL(18,2),
    @FinalAmount DECIMAL(18,2),
    @Description NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON; -- برای افزایش سرعت و جلوگیری از ارسال پیام‌های اضافی به کلاینت

    -- ۱. شروع تراکنش برای تضمین اینکه یا همه کارهای زیر انجام شود یا هیچ‌کدام
    BEGIN TRANSACTION;

    BEGIN TRY
        -- الف) پیدا کردن سبد خرید فعال کاربر
        DECLARE @CartID INT;
        SELECT @CartID = CartID 
        FROM [sales].ShoppingCarts 
        WHERE UserID = @UserID AND [Status] = 1; -- 1: Active

        IF @CartID IS NULL
        BEGIN
            THROW 50001, 'No active shopping cart found for this user.', 1;
        END

        -- ب) بررسی موجودی انبار قبل از ثبت سفارش
        -- چک می‌کنیم آیا محصولی در سبد هست که موجودی انبارش (مجموع تمام انبارها) کمتر از درخواست کاربر باشد
        IF EXISTS (
            SELECT 1
            FROM [sales].CartItems ci
            LEFT JOIN (
                SELECT VariantID, SUM(Quantity) as TotalStock 
                FROM [inventory].Inventory 
                GROUP BY VariantID
            ) inv ON ci.VariantID = inv.VariantID
            WHERE ci.CartID = @CartID AND ci.Quantity > ISNULL(inv.TotalStock, 0)
        )
        BEGIN
            THROW 50002, 'Insufficient stock for one or more items in the cart.', 1;
        END

        -- ج) ثبت اطلاعات کلی در جدول Orders
        DECLARE @NewOrderID INT;
        INSERT INTO [sales].Orders 
        (UserID, AddressID, OrderDate, OrderStatus, PaymentStatus, ShippingCost, DiscountAmount, TaxAmount, FinalAmount, [Description])
        VALUES 
        (@UserID, @AddressID, GETDATE(), 1, 1, @ShippingCost, @DiscountAmount, @TaxAmount, @FinalAmount, @Description);

        SET @NewOrderID = SCOPE_IDENTITY(); -- دریافت آیدی سفارش ثبت شده

        -- د) انتقال آیتم‌ها از سبد خرید به جزئیات سفارش
        INSERT INTO [sales].OrderItems (OrderID, VariantID, Quantity, UnitPrice, Discount, Tax, TotalPrice)
        SELECT 
            @NewOrderID, 
            VariantID, 
            Quantity, 
            Price, 
            0, -- تخفیف در سطح آیتم (فعلاً صفر)
            0, -- مالیات در سطح آیتم (فعلاً صفر)
            (Quantity * Price)
        FROM [sales].CartItems
        WHERE CartID = @CartID;

        -- هـ) کسر موجودی از انبار
        -- در اینجا برای سادگی از اولین انباری که موجودی دارد کسر می‌کنیم
        -- (در سیستم‌های پیشرفته‌تر، منطق انتخاب انبار بر اساس نزدیکی به مشتری است)
        UPDATE inv
        SET inv.Quantity = inv.Quantity - ci.Quantity
        FROM [inventory].Inventory inv
        INNER JOIN [sales].CartItems ci ON inv.VariantID = ci.VariantID
        WHERE ci.CartID = @CartID 
          AND inv.WarehouseID = (SELECT TOP 1 WarehouseID FROM [inventory].Inventory WHERE VariantID = ci.VariantID AND Quantity >= ci.Quantity);

        -- و) تغییر وضعیت سبد خرید به "تبدیل شده به سفارش"
        UPDATE [sales].ShoppingCarts
        SET [Status] = 3 -- 3: ConvertedToOrder
        WHERE CartID = @CartID;

        -- اگر همه مراحل با موفقیت انجام شد، تغییرات ذخیره شوند
        COMMIT TRANSACTION;

        SELECT @NewOrderID AS CreatedOrderID; -- بازگرداندن آیدی سفارش برای نمایش در اپلیکیشن

    END TRY
    BEGIN CATCH
        -- اگر هر خطایی رخ داد، تمام تغییرات به حالت اول برگردند
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- پرتاب خطا به سمت اپلیکیشن برای اطلاع‌رسانی
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO