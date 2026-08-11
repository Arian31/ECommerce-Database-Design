USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [purchasing].PurchaseInvoices)
BEGIN
    -- دریافت ID چند تأمین‌کننده برای تست
    DECLARE @SupTech INT = (SELECT SupplierID FROM [purchasing].Suppliers WHERE CompanyName LIKE 'Global Tech%');
    DECLARE @SupEuro INT = (SELECT SupplierID FROM [purchasing].Suppliers WHERE CompanyName LIKE 'EuroFashion%');

    INSERT INTO [purchasing].PurchaseInvoices (SupplierID, InvoiceNumber, PurchaseDate, TotalAmount, [Status])
    VALUES
    (@SupTech, N'INV-2023-001', '2023-01-10 10:00:00', 50000.00, 2), -- 2: Completed
    (@SupTech, N'INV-2023-002', '2023-05-15 14:30:00', 12000.00, 2),
    (@SupEuro, N'INV-2023-003', '2023-08-20 09:15:00', 8500.00, 2),
    (@SupEuro, N'INV-2023-004', GETDATE(), 0.00, 1); -- 1: Pending

    PRINT 'Purchase Invoices seeded successfully.';
END
GO