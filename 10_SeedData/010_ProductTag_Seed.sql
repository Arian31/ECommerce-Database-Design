USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [Catalog].ProductTag)
BEGIN
    -- دریافت ID محصولات
    DECLARE @IPhoneID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'iphone-14-pro');
    DECLARE @MacBookID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'macbook-air-m2');
    DECLARE @AlienwareID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'alienware-x17');
    DECLARE @NikeID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'nike-pegasus-39');
    DECLARE @IkeaID INT = (SELECT ProductID FROM [Catalog].Products WHERE Slug = 'ikea-malm-bed');

    -- دریافت ID تگ‌ها
    DECLARE @TagNew INT = (SELECT TagID FROM [Catalog].ProductTags WHERE TagName = 'New Arrival');
    DECLARE @TagPremium INT = (SELECT TagID FROM [Catalog].ProductTags WHERE TagName = 'Premium');
    DECLARE @Tag5G INT = (SELECT TagID FROM [Catalog].ProductTags WHERE TagName = '5G');
    DECLARE @TagGaming INT = (SELECT TagID FROM [Catalog].ProductTags WHERE TagName = 'Gaming');
    DECLARE @TagEco INT = (SELECT TagID FROM [Catalog].ProductTags WHERE TagName = 'Eco-friendly');
    DECLARE @TagWaterproof INT = (SELECT TagID FROM [Catalog].ProductTags WHERE TagName = 'Waterproof');

    INSERT INTO [Catalog].ProductTag (ProductID, TagID)
    VALUES
    -- تگ‌های آیفون
    (@IPhoneID, @Tag5G),
    (@IPhoneID, @TagPremium),
    (@IPhoneID, @TagWaterproof),

    -- تگ‌های مک‌بوک
    (@MacBookID, @TagPremium),
    (@MacBookID, @TagNew),

    -- تگ‌های لپ‌تاپ گیمینگ دل
    (@AlienwareID, @TagGaming),
    (@AlienwareID, @TagPremium),

    -- تگ‌های نایک
    (@NikeID, @TagWaterproof),
    (@NikeID, @TagNew),

    -- تگ‌های ایکیا
    (@IkeaID, @TagEco);

    PRINT 'Product-Tag relationships seeded successfully.';
END
GO