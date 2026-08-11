USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [catalog].Brands)
BEGIN
    INSERT INTO [catalog].Brands (BrandName, [Description], Website, LogoUrl, IsActive, CreatedAt)
    VALUES
    (N'Apple', N'Premium electronics, smartphones, and software.', N'https://www.apple.com', NULL, 1, GETDATE()),
    (N'Samsung', N'Global leader in technology and home appliances.', N'https://www.samsung.com', NULL, 1, GETDATE()),
    (N'Sony', N'Japanese multinational conglomerate known for electronics and gaming.', N'https://www.sony.com', NULL, 1, GETDATE()),
    (N'Dell', N'American technology company that develops laptops and PCs.', N'https://www.dell.com', NULL, 1, GETDATE()),
    (N'Nike', N'World leading brand in sportswear and athletic equipment.', N'https://www.nike.com', NULL, 1, GETDATE()),
    (N'Adidas', N'Global sports brand specializing in shoes and clothing.', N'https://www.adidas.com', NULL, 1, GETDATE()),
    (N'IKEA', N'Global furniture retailer known for modern and affordable designs.', N'https://www.ikea.com', NULL, 1, GETDATE()),
    (N'Philips', N'Health technology and home products leader.', N'https://www.philips.com', NULL, 1, GETDATE());

    PRINT 'Famous Global Brands seeded successfully.';
END
GO