USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [purchasing].PurchaseItems)
BEGIN
    -- دریافت ID فاکتورها و محصولات برای اتصال دقیق
    DECLARE @Pur1 INT = (SELECT PurchaseID FROM [purchasing].PurchaseInvoices WHERE InvoiceNumber = 'INV-2023-001');
    DECLARE @Pur2 INT = (SELECT PurchaseID FROM [purchasing].PurchaseInvoices WHERE InvoiceNumber = 'INV-2023-002');

    DECLARE @VarIPhone INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'APP-IP14-BLK');
    DECLARE @VarMacBook INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'APP-MBM2-MID-13');
    DECLARE @VarNike INT = (SELECT VariantID FROM [catalog].ProductVariants WHERE SKU = 'NIK-PEG-BLK-43');

    INSERT INTO [purchasing].PurchaseItems (PurchaseID, VariantID, Quantity, UnitPrice, Discount, Tax)
    VALUES
    -- اقلام فاکتور اول (خرید عمده آیفون و مک‌بوک)
    (@Pur1, @VarIPhone, 50, 750.00, 500.00, 3700.00),
    (@Pur1, @VarMacBook, 20, 950.00, 200.00, 1900.00),

    -- اقلام فاکتور دوم (خرید کفش نایک)
    (@Pur2, @VarNike, 100, 70.00, 0.00, 700.00);

    PRINT 'Purchase Items seeded successfully.';
END
GO