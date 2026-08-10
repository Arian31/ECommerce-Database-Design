USE ECommerceDB
GO

-- *** UserRoles FKs ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_UserRoles_Users'
)
BEGIN
    ALTER TABLE [security].UserRoles
    ADD CONSTRAINT FK_UserRoles_Users
    FOREIGN KEY(UserID)
    REFERENCES [security].Users(UserID)
END
GO

IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_UserRoles_Roles'
)
BEGIN
    ALTER TABLE [security].UserRoles
    ADD CONSTRAINT FK_UserRoles_Roles
    FOREIGN KEY(RoleID)
    REFERENCES [security].Roles(RoleID)
END
GO

-- *** Addresses FK ***
IF NOT EXISTS 
(
	SELECT *
	FROM sys.foreign_keys 
	WHERE name = 'FK_Addresses_Users'
)
BEGIN
    ALTER TABLE customer.Addresses 
    ADD CONSTRAINT FK_Addresses_Users
    FOREIGN KEY(UserId)
    REFERENCES [security].Users(UserId)
END
GO

-- *** Categories Self-Reference FK ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_Categories_Parent'
)
BEGIN
    ALTER TABLE [Catalog].Categories
    ADD CONSTRAINT FK_Categories_Parent
    FOREIGN KEY(ParentCategoryID)
    REFERENCES [Catalog].Categories(CategoryID)
END
GO

-- *** Products FK: Category ***
IF NOT EXISTS 
(
	SELECT *
	FROM sys.foreign_keys 
	WHERE name = 'FK_Products_Categories'
)
BEGIN
    ALTER TABLE [Catalog].Products
    ADD CONSTRAINT FK_Products_Categories
    FOREIGN KEY(CategoryID)
    REFERENCES [Catalog].Categories(CategoryID)
END
GO

-- *** Products FK: Brand ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_Products_Brands'
)
BEGIN
    ALTER TABLE [Catalog].Products
    ADD CONSTRAINT FK_Products_Brands
    FOREIGN KEY(BrandID)
    REFERENCES [Catalog].Brands(BrandID)
END
GO

-- *** ProductTag FK: Product ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductTag_Products')
BEGIN
    ALTER TABLE [Catalog].ProductTag
    ADD CONSTRAINT FK_ProductTag_Products
    FOREIGN KEY(ProductID)
    REFERENCES [Catalog].Products(ProductID)
END
GO

-- *** ProductTag FK: Tag ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductTag_Tags')
BEGIN
    ALTER TABLE [Catalog].ProductTag
    ADD CONSTRAINT FK_ProductTag_Tags
    FOREIGN KEY(TagID)
    REFERENCES [Catalog].ProductTags(TagID)
END
GO

-- *** ProductImages FK: Product ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_ProductImages_Products'
)
BEGIN
    ALTER TABLE [catalog].ProductImages
    ADD CONSTRAINT FK_ProductImages_Products
    FOREIGN KEY(ProductID)
    REFERENCES [catalog].Products(ProductID)
END
GO

-- *** ProductVariants Foreign Keys ***

-- « ’«· »Â Product
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductVariants_Products')
BEGIN
    ALTER TABLE [catalog].ProductVariants
    ADD CONSTRAINT FK_ProductVariants_Products
    FOREIGN KEY(ProductID) REFERENCES [catalog].Products(ProductID)
END
GO

-- « ’«· »Â Color
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductVariants_Colors')
BEGIN
    ALTER TABLE [catalog].ProductVariants
    ADD CONSTRAINT FK_ProductVariants_Colors
    FOREIGN KEY(ColorID) REFERENCES [catalog].Colors(ColorID)
END
GO

-- « ’«· »Â Size
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductVariants_Sizes')
BEGIN
    ALTER TABLE [catalog].ProductVariants
    ADD CONSTRAINT FK_ProductVariants_Sizes
    FOREIGN KEY(SizeID) REFERENCES [catalog].Sizes(SizeID)
END
GO

-- *** Inventory ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Inventory_Warehouses')
BEGIN
    ALTER TABLE [inventory].Inventory
    ADD CONSTRAINT FK_Inventory_Warehouses
    FOREIGN KEY(WarehouseID) REFERENCES [inventory].Warehouses(WarehouseID)
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Inventory_ProductVariants')
BEGIN
    ALTER TABLE [inventory].Inventory
    ADD CONSTRAINT FK_Inventory_ProductVariants
    FOREIGN KEY(VariantID) REFERENCES [catalog].ProductVariants(VariantID)
END
GO