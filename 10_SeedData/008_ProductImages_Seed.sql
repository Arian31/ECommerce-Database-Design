USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [catalog].ProductImages)
BEGIN
    -- دریافت ID محصولات برای درج دقیق تصاویر
    DECLARE @IPhoneID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'iphone-14-pro');
    DECLARE @MacBookID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'macbook-air-m2');
    DECLARE @NikeShoesID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'nike-pegasus-39');
    DECLARE @IkeaBedID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'ikea-malm-bed');

    INSERT INTO [catalog].ProductImages (ProductID, ImageUrl, DisplayOrder, IsMain, CreatedAt)
    VALUES
    -- تصاویر آیفون
    (@IPhoneID, N'https://cdn.example.com/products/iphone14-main.jpg', 1, 1, GETDATE()),
    (@IPhoneID, N'https://cdn.example.com/products/iphone14-side.jpg', 2, 0, GETDATE()),

    -- تصاویر مک‌بوک
    (@MacBookID, N'https://cdn.example.com/products/macbook-main.jpg', 1, 1, GETDATE()),
    (@MacBookID, N'https://cdn.example.com/products/macbook-open.jpg', 2, 0, GETDATE()),

    -- تصاویر نایک
    (@NikeShoesID, N'https://cdn.example.com/products/nike-main.jpg', 1, 1, GETDATE()),
    (@NikeShoesID, N'https://cdn.example.com/products/nike-sole.jpg', 2, 0, GETDATE()),

    -- تصاویر ایکیا
    (@IkeaBedID, N'https://cdn.example.com/products/ikea-bed-main.jpg', 1, 1, GETDATE());

    PRINT 'Global Product Images seeded successfully.';
END
GO