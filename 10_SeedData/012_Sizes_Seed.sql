USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [catalog].Sizes)
BEGIN
    INSERT INTO [catalog].Sizes (SizeValue, [Description], CreatedAt)
    VALUES
    -- Clothing Sizes
    (N'S', N'Small size for clothing', GETDATE()),
    (N'M', N'Medium size for clothing', GETDATE()),
    (N'L', N'Large size for clothing', GETDATE()),
    (N'XL', N'Extra Large size for clothing', GETDATE()),

    -- Shoe Sizes (EU Standard)
    (N'40', N'EU Shoe size 40', GETDATE()),
    (N'41', N'EU Shoe size 41', GETDATE()),
    (N'42', N'EU Shoe size 42', GETDATE()),
    (N'43', N'EU Shoe size 43', GETDATE()),
    (N'44', N'EU Shoe size 44', GETDATE()),

    -- Laptop Screen Sizes
    (N'13-inch', N'Laptop screen diagonal size', GETDATE()),
    (N'14-inch', N'Laptop screen diagonal size', GETDATE()),
    (N'16-inch', N'Laptop screen diagonal size', GETDATE());

    PRINT 'Global Sizes seeded successfully.';
END
GO