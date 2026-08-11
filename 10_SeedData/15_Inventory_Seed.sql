USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [inventory].Inventory)
BEGIN
    -- دریافت ID انبارها
    DECLARE @WH_NY INT = (SELECT WarehouseID FROM [inventory].Warehouses WHERE WarehouseName LIKE 'New York%');
    DECLARE @WH_LDN INT = (SELECT WarehouseID FROM [inventory].Warehouses WHERE WarehouseName LIKE 'London%');
    DECLARE @WH_TKY INT = (SELECT WarehouseID FROM [inventory].Warehouses WHERE WarehouseName LIKE 'Tokyo%');
    DECLARE @WH_BER INT = (SELECT WarehouseID FROM [inventory].Warehouses WHERE WarehouseName LIKE 'Berlin%');
    DECLARE @WH_DXB INT = (SELECT WarehouseID FROM [inventory].Warehouses WHERE WarehouseName LIKE 'Dubai%');

    -- دریافت ID تنوع محصولات (Variants)
    DECLARE @V_IPhoneBlack INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'APP-IP14-BLK');
    DECLARE @V_MacBookMid INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'APP-MBM2-MID-13');
    DECLARE @V_Alienware INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'DEL-ALW-GRY-16');
    DECLARE @V_NikeBlack INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'NIK-PEG-BLK-43');
    DECLARE @V_IkeaBed INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'IKE-MALM-WHT');

    INSERT INTO [inventory].Inventory (WarehouseID, VariantID, Quantity)
    VALUES
    -- توزیع آیفون مشکی در دنیا
    (@WH_NY, @V_IPhoneBlack, 100),
    (@WH_LDN, @V_IPhoneBlack, 50),
    (@WH_DXB, @V_IPhoneBlack, 30),

    -- توزیع مک‌بوک (فقط در انبارهای تکنولوژی)
    (@WH_NY, @V_MacBookMid, 25),
    (@WH_TKY, @V_MacBookMid, 40),
    (@WH_BER, @V_MacBookMid, 15),

    -- توزیع لپ‌تاپ Alienware (موجودی محدود)
    (@WH_NY, @V_Alienware, 5),
    (@WH_DXB, @V_Alienware, 2),

    -- توزیع کفش نایک (در همه انبارها)
    (@WH_NY, @V_NikeBlack, 200),
    (@WH_LDN, @V_NikeBlack, 150),
    (@WH_TKY, @V_NikeBlack, 100),
    (@WH_BER, @V_NikeBlack, 120),
    (@WH_DXB, @V_NikeBlack, 80),

    -- توزیع تخت‌خواب ایکیا (فقط در انبارهای دارای بخش خانگی)
    (@WH_NY, @V_IkeaBed, 10),
    (@WH_BER, @V_IkeaBed, 25);

    PRINT 'Global Inventory (Stock distribution) seeded successfully.';
END
GO