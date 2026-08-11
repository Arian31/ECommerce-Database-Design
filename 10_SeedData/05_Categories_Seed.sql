USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [Catalog].Categories)
BEGIN
    -- لایه ۱: دسته‌بندی‌های اصلی (Root)
    INSERT INTO [Catalog].Categories (CategoryName, ParentCategoryID, [Description], IsActive)
    VALUES (N'Electronics', NULL, N'Gadgets and digital devices', 1), -- ID: 1
           (N'Fashion', NULL, N'Clothing and accessories', 1),     -- ID: 2
           (N'Home & Garden', NULL, N'Furniture and appliances', 1); -- ID: 3

    -- لایه ۲: زیرمجموعه‌های لایه ۱
    -- برای Electronics (ID 1)
    DECLARE @ElectronicsID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = N'Electronics');
    INSERT INTO [Catalog].Categories (CategoryName, ParentCategoryID, IsActive)
    VALUES (N'Computers', @ElectronicsID, 1),    -- ID: 4
           (N'Mobile Phones', @ElectronicsID, 1); -- ID: 5

    -- برای Fashion (ID 2)
    DECLARE @FashionID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = N'Fashion');
    INSERT INTO [Catalog].Categories (CategoryName, ParentCategoryID, IsActive)
    VALUES (N'Mens Clothing', @FashionID, 1);   -- ID: 6 (این شاخه ۲ لایه باقی می‌ماند)

    -- برای Home & Garden (ID 3)
    DECLARE @HomeID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = N'Home & Garden');
    INSERT INTO [Catalog].Categories (CategoryName, ParentCategoryID, IsActive)
    VALUES (N'Furniture', @HomeID, 1);          -- ID: 7

    -- لایه ۳: زیرمجموعه‌های لایه ۲
    -- برای Computers (ID 4)
    DECLARE @ComputersID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = N'Computers');
    INSERT INTO [Catalog].Categories (CategoryName, ParentCategoryID, IsActive)
    VALUES (N'Laptops', @ComputersID, 1),       -- ID: 8
           (N'Desktops', @ComputersID, 1);      -- ID: 9 (این شاخه ۳ لایه باقی می‌ماند)

    -- برای Mobile Phones (ID 5)
    DECLARE @MobilesID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = N'Mobile Phones');
    INSERT INTO [Catalog].Categories (CategoryName, ParentCategoryID, IsActive)
    VALUES (N'Smartphones', @MobilesID, 1);     -- ID: 10 (این شاخه ۳ لایه باقی می‌ماند)

    -- لایه ۴: عمیق‌ترین سطح
    -- برای Laptops (ID 8)
    DECLARE @LaptopsID INT = (SELECT CategoryID FROM [Catalog].Categories WHERE CategoryName = N'Laptops');
    INSERT INTO [Catalog].Categories (CategoryName, ParentCategoryID, IsActive)
    VALUES (N'Gaming Laptops', @LaptopsID, 1),  -- ID: 11
           (N'Ultrabooks', @LaptopsID, 1);      -- ID: 12

    PRINT 'Hierarchical Categories seeded successfully (up to 4 layers).';
END
GO