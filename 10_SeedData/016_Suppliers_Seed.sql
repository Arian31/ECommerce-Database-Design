USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [purchasing].Suppliers)
BEGIN
    INSERT INTO [purchasing].Suppliers (CompanyName, ContactName, Phone, Email, [Address])
    VALUES
    (N'Global Tech Distribution', N'Robert Chen', N'+1-415-555-0120', N'orders@globaltech.com', N'Building A, Silicon Valley, CA, USA'),
    (N'EuroFashion Wholesalers', N'Marco Rossi', N'+39-02-1234567', N'sales@eurofashion.it', N'Via della Moda, Milan, Italy'),
    (N'AsiaConnect Electronics', N'Li Wei', N'+86-755-12345678', N'b2b@asiaconnect.cn', N'Shenzhen Tech Park, Guangdong, China'),
    (N'Arabian Trade Partners', N'Omar Al-Fayed', N'+971-4-8888888', N'info@arabtrade.ae', N'JBR Business Center, Dubai, UAE'),
    (N'Pacific Logistics Group', N'Emily Watson', N'+61-2-98765432', N'contact@pacificlog.au', N'Harbour View St, Sydney, Australia');

    PRINT 'Global Suppliers seeded successfully.';
END
GO