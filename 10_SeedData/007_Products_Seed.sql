USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [Catalog].Products)
BEGIN
    -- متغیرهایی برای نگهداری IDها جهت حفظ دقت روابط
    DECLARE @AppleID INT = (SELECT BrandID FROM [Catalog].Brands WHERE BrandName = 'Apple');
    DECLARE @SamsungID INT = (SELECT BrandID FROM [Catalog].Brands WHERE BrandName = 'Samsung');
    DECLARE @DellID INT = (SELECT BrandID FROM [Catalog].Brands WHERE BrandName = 'Dell');
    DECLARE @NikeID INT = (SELECT BrandID FROM [Catalog].Brands WHERE BrandName = 'Nike');
    DECLARE @IkeaID INT = (SELECT BrandID FROM [Catalog].Brands WHERE BrandName = 'IKEA');

    DECLARE @SmartphonesID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = 'Smartphones');
    DECLARE @UltrabooksID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = 'Ultrabooks');
    DECLARE @GamingLaptopsID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = 'Gaming Laptops');
    DECLARE @MensClothingID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = 'Mens Clothing');
    DECLARE @FurnitureID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = 'Furniture');

    INSERT INTO [Catalog].Products 
    (CategoryID, BrandID, ProductName, Slug, [Description], [Weight], [Length], [Width], [Height], WarrantyMonths, [Status], CreatedAt)
    VALUES
    -- محصولات اپل
    (@SmartphonesID, @AppleID, N'iPhone 14 Pro', 'iphone-14-pro', N'The latest iPhone with Pro camera system.', 0.206, 14.75, 7.15, 0.78, 12, 1, GETDATE()),
    (@UltrabooksID, @AppleID, N'MacBook Air M2', 'macbook-air-m2', N'Supercharged by M2 chip, thin and light.', 1.24, 30.41, 21.50, 1.13, 18, 1, GETDATE()),

    -- محصولات سامسونگ
    (@SmartphonesID, @SamsungID, N'Galaxy S23 Ultra', 'galaxy-s23-ultra', N'Epic camera, built-in S Pen.', 0.234, 16.34, 7.81, 0.89, 24, 1, GETDATE()),

    -- محصولات دل
    (@UltrabooksID, @DellID, N'Dell XPS 13', 'dell-xps-13', N'Compact 13-inch laptop with stunning display.', 1.17, 29.50, 19.90, 1.39, 12, 1, GETDATE()),
    (@GamingLaptopsID, @DellID, N'Alienware x17', 'alienware-x17', N'High-performance gaming laptop.', 3.02, 39.90, 29.90, 2.09, 24, 1, GETDATE()),

    -- محصولات نایک
    (@MensClothingID, @NikeID, N'Nike Pegasus 39', 'nike-pegasus-39', N'Comfortable running shoes for daily use.', 0.260, 30.00, 11.00, 12.00, 0, 1, GETDATE()),

    -- محصولات ایکیا
    (@FurnitureID, @IkeaID, N'MALM Bed Frame', 'ikea-malm-bed', N'Simple and clean design for your bedroom.', 45.50, 209.00, 176.00, 100.00, 60, 1, GETDATE());

    PRINT 'Global Products seeded successfully.';
END
GO