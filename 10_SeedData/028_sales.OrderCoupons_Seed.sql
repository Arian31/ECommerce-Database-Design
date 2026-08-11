USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [sales].OrderCoupons)
BEGIN
    -- اتصال چند سفارش اول به کد تخفیف WELCOME10
    DECLARE @CouponID INT = (SELECT CouponID FROM [sales].Coupons WHERE CouponCode = 'WELCOME10');
    
    INSERT INTO [sales].OrderCoupons (OrderID, CouponID)
    SELECT TOP 5 OrderID, @CouponID FROM [sales].Orders;

    PRINT 'Coupons linked to orders successfully.';
END
GO