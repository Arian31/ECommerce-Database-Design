USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [Catalog].ProductTags)
BEGIN
    INSERT INTO [Catalog].ProductTags (TagName, CreatedAt)
    VALUES
    (N'New Arrival', GETDATE()),    -- برای کالاهای جدید
    (N'Bestseller', GETDATE()),     -- پرفروش‌ترین‌ها
    (N'Sale', GETDATE()),           -- کالاهای دارای تخفیف ویژه
    (N'Premium', GETDATE()),        -- محصولات لوکس و خاص
    (N'Eco-friendly', GETDATE()),   -- محصولات دوست‌دار محیط زیست (مناسب برای IKEA)
    (N'Wireless', GETDATE()),       -- تکنولوژی‌های بدون سیم
    (N'5G', GETDATE()),             -- مناسب برای گوشی‌های جدید
    (N'Waterproof', GETDATE()),     -- ضد آب (مناسب برای اپل و نایک)
    (N'Gaming', GETDATE()),          -- مخصوص گیمرها (مناسب برای Alienware)
    (N'Smart Home', GETDATE()),     -- خانه هوشمند
    (N'Limited Edition', GETDATE()),-- تولید محدود
    (N'Best Value', GETDATE());     -- ارزش خرید بالا نسبت به قیمت

    PRINT 'Global Product Tags seeded successfully.';
END
GO