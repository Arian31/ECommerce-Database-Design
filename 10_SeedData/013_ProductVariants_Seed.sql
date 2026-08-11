USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [catalog].ProductVariants)
BEGIN
    -- دریافت ID محصولات
    DECLARE @IPhoneID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'iphone-14-pro');
    DECLARE @MacBookID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'macbook-air-m2');
    DECLARE @AlienwareID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'alienware-x17');
    DECLARE @NikeID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'nike-pegasus-39');
    DECLARE @IkeaID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'ikea-malm-bed');

    -- دریافت ID رنگ‌ها
    DECLARE @ColorBlack INT = (SELECT ColorID FROM [catalog].Colors WHERE ColorName = 'Black');
    DECLARE @ColorSilver INT = (SELECT ColorID FROM [catalog].Colors WHERE ColorName = 'Silver');
    DECLARE @ColorGold INT = (SELECT ColorID FROM [catalog].Colors WHERE ColorName = 'Gold');
    DECLARE @ColorMidnight INT = (SELECT ColorID FROM [catalog].Colors WHERE ColorName = 'Midnight');
    DECLARE @ColorSpaceGray INT = (SELECT ColorID FROM [catalog].Colors WHERE ColorName = 'Space Gray');
    DECLARE @ColorWhite INT = (SELECT ColorID FROM [catalog].Colors WHERE ColorName = 'White');
    DECLARE @ColorRed INT = (SELECT ColorID FROM [catalog].Colors WHERE ColorName = 'Red');

    -- دریافت ID سایزها
    DECLARE @Size13 INT = (SELECT SizeID FROM [catalog].Sizes WHERE SizeValue = '13-inch');
    DECLARE @Size16 INT = (SELECT SizeID FROM [catalog].Sizes WHERE SizeValue = '16-inch');
    DECLARE @Size42 INT = (SELECT SizeID FROM [catalog].Sizes WHERE SizeValue = '42');
    DECLARE @Size43 INT = (SELECT SizeID FROM [catalog].Sizes WHERE SizeValue = '43');

    INSERT INTO [catalog].ProductVariants 
    (ProductID, ColorID, SizeID, SKU, Barcode, Price, CostPrice, MinimumStock, IsActive, CreatedAt)
    VALUES
    -- iPhone 14 Pro Variants
    (@IPhoneID, @ColorBlack, NULL, N'APP-IP14-BLK', N'1942534011', 999.00, 750.00, 5, 1, GETDATE()),
    (@IPhoneID, @ColorGold, NULL, N'APP-IP14-GLD', N'1942534012', 1099.00, 800.00, 5, 1, GETDATE()),

    -- MacBook Air M2 Variants
    (@MacBookID, @ColorMidnight, @Size13, N'APP-MBM2-MID-13', N'1942534020', 1199.00, 950.00, 3, 1, GETDATE()),
    (@MacBookID, @ColorSilver, @Size13, N'APP-MBM2-SIL-13', N'1942534021', 1199.00, 950.00, 3, 1, GETDATE()),

    -- Alienware x17 Variant
    (@AlienwareID, @ColorSpaceGray, @Size16, N'DEL-ALW-GRY-16', N'1942534030', 2599.00, 2100.00, 2, 1, GETDATE()),

    -- Nike Pegasus Variants (رنگ و سایزهای مختلف)
    (@NikeID, @ColorRed, @Size42, N'NIK-PEG-RED-42', N'1942534040', 120.00, 70.00, 10, 1, GETDATE()),
    (@NikeID, @ColorBlack, @Size43, N'NIK-PEG-BLK-43', N'1942534041', 120.00, 70.00, 10, 1, GETDATE()),

    -- IKEA Bed Variant
    (@IkeaID, @ColorWhite, NULL, N'IKE-MALM-WHT', N'1942534050', 249.00, 150.00, 5, 1, GETDATE());

    PRINT 'Product Variants seeded successfully.';
END
GO