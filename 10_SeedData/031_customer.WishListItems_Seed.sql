USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [customer].WishListItems)
BEGIN
    -- دریافت چند نمونه از تنوع محصولات
    DECLARE @VarIPhone INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'APP-IP14-BLK');
    DECLARE @VarNike INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'NIK-PEG-BLK-43');
    DECLARE @VarMacBook INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'APP-MBM2-MID-13');

    -- اضافه کردن آیتم به لیست کاربر اول
    DECLARE @WL1 INT = (SELECT WishListID FROM [customer].WishLists WHERE UserID = 1);
    INSERT INTO [customer].WishListItems (WishListID, VariantID)
    VALUES (@WL1, @VarIPhone), (@WL1, @VarNike);

    -- اضافه کردن آیتم به لیست کاربر دوم
    DECLARE @WL2 INT = (SELECT WishListID FROM [customer].WishLists WHERE UserID = 2);
    INSERT INTO [customer].WishListItems (WishListID, VariantID)
    VALUES (@WL2, @VarMacBook);

    PRINT 'Items added to WishLists successfully.';
END
GO