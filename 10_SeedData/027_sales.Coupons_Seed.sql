USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [sales].Coupons)
BEGIN
    INSERT INTO [sales].Coupons 
    (CouponCode, DiscountType, DiscountValue, StartDate, EndDate, MaximumUsage, UsedCount, MinimumOrderAmount, IsActive)
    VALUES 
    (N'WELCOME10', 1, 10.00, '2023-01-01', '2025-12-31', 1000, 50, 50.00, 1),   -- 10% درصد تخفیف
    (N'BLACKFRIDAY', 1, 50.00, '2023-11-20', '2023-11-30', 500, 500, 100.00, 1), -- منقضی شده از لحاظ تعداد
    (N'GIFT50', 2, 50.00, '2023-01-01', '2025-12-31', 100, 5, 200.00, 1),      -- 50 دلار تخفیف ثابت
    (N'FREESHIP', 2, 15.00, '2023-01-01', '2025-12-31', 2000, 10, 0.00, 1);

    PRINT 'Global Coupons seeded successfully.';
END
GO