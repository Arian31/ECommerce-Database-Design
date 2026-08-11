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

-- FK to Supplier
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_PurchaseInvoices_Suppliers')
BEGIN
    ALTER TABLE [purchasing].PurchaseInvoices
    ADD CONSTRAINT FK_PurchaseInvoices_Suppliers
    FOREIGN KEY(SupplierID) REFERENCES [purchasing].Suppliers(SupplierID)
END
GO

-- FK to PurchaseInvoices
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_PurchaseItems_PurchaseInvoices')
BEGIN
    ALTER TABLE [purchasing].PurchaseItems
    ADD CONSTRAINT FK_PurchaseItems_PurchaseInvoices
    FOREIGN KEY(PurchaseID) REFERENCES [purchasing].PurchaseInvoices(PurchaseID)
END
GO

-- FK to ProductVariants
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_PurchaseItems_ProductVariants')
BEGIN
    ALTER TABLE [purchasing].PurchaseItems
    ADD CONSTRAINT FK_PurchaseItems_ProductVariants
    FOREIGN KEY(VariantID) REFERENCES [catalog].ProductVariants(VariantID)
END
GO

-- *** ShoppingCarts FK: User ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_ShoppingCarts_Users'
)
BEGIN
    ALTER TABLE [sales].ShoppingCarts
    ADD CONSTRAINT FK_ShoppingCarts_Users
    FOREIGN KEY(UserID)
    REFERENCES [security].Users(UserID)
END
GO

-- *** CartItems FK: ProductVariant ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_CartItems_ProductVariants'
)
BEGIN
    ALTER TABLE [sales].CartItems
    ADD CONSTRAINT FK_CartItems_ProductVariants
    FOREIGN KEY(VariantID)
    REFERENCES [catalog].ProductVariants(VariantID)
END
GO


-- *** Orders FK: User ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Orders_Users')
BEGIN
    ALTER TABLE [sales].Orders
    ADD CONSTRAINT FK_Orders_Users
    FOREIGN KEY(UserID) REFERENCES [security].Users(UserID)
END
GO

-- *** Orders FK: Address ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Orders_Addresses')
BEGIN
    ALTER TABLE [sales].Orders
    ADD CONSTRAINT FK_Orders_Addresses
    FOREIGN KEY(AddressID) REFERENCES [customer].Addresses(AddressID)
END
GO



-- *** OrderItems FK: ProductVariant ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_OrderItems_ProductVariants'
)
BEGIN
    ALTER TABLE [sales].OrderItems
    ADD CONSTRAINT FK_OrderItems_ProductVariants
    FOREIGN KEY(VariantID)
    REFERENCES [catalog].ProductVariants(VariantID)
END
GO

-- *** Payments FK: Orders ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Payments_Orders')
BEGIN
    ALTER TABLE [payment].Payments
    ADD CONSTRAINT FK_Payments_Orders
    FOREIGN KEY(OrderID) REFERENCES [sales].Orders(OrderID)
END
GO

-- *** Payments FK: PaymentMethods ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Payments_Methods')
BEGIN
    ALTER TABLE [payment].Payments
    ADD CONSTRAINT FK_Payments_Methods
    FOREIGN KEY(PaymentMethodID) REFERENCES [payment].PaymentMethods(PaymentMethodID)
END
GO

-- *** Shippings FK: Orders ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Shippings_Orders')
BEGIN
    ALTER TABLE [shipping].Shippings
    ADD CONSTRAINT FK_Shippings_Orders
    FOREIGN KEY(OrderID) REFERENCES [sales].Orders(OrderID)
END
GO

-- *** Shippings FK: ShippingCompanies ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Shippings_Companies')
BEGIN
    ALTER TABLE [shipping].Shippings
    ADD CONSTRAINT FK_Shippings_Companies
    FOREIGN KEY(ShippingCompanyID) REFERENCES [shipping].ShippingCompanies(ShippingCompanyID)
END
GO


-- *** OrderCoupons FK: Coupons ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_OrderCoupons_Coupons'
)
BEGIN
    ALTER TABLE [sales].OrderCoupons
    ADD CONSTRAINT FK_OrderCoupons_Coupons
    FOREIGN KEY(CouponID)
    REFERENCES [sales].Coupons(CouponID)
END
GO

-- *** OrderCoupons FK: Orders ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_OrderCoupons_Orders'
)
BEGIN
    ALTER TABLE [sales].OrderCoupons
    ADD CONSTRAINT FK_OrderCoupons_Orders
    FOREIGN KEY(OrderID)
    REFERENCES [sales].Orders(OrderID)
END
GO


-- *** Reviews FK: Products ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_Reviews_Products'
)
BEGIN
    ALTER TABLE [review].Reviews
    ADD CONSTRAINT FK_Reviews_Products
    FOREIGN KEY(ProductID)
    REFERENCES [catalog].Products(ProductID)
END
GO

-- *** Reviews FK: Users ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_Reviews_Users'
)
BEGIN
    ALTER TABLE [review].Reviews
    ADD CONSTRAINT FK_Reviews_Users
    FOREIGN KEY(UserID)
    REFERENCES [security].Users(UserID)
END
GO

-- *** WishLists FK: User ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_WishLists_Users'
)
BEGIN
    ALTER TABLE [customer].WishLists
    ADD CONSTRAINT FK_WishLists_Users
    FOREIGN KEY(UserID)
    REFERENCES [security].Users(UserID)
END
GO

-- *** WishListItems FK: WishList ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_WishListItems_WishLists'
)
BEGIN
    ALTER TABLE [customer].WishListItems
    ADD CONSTRAINT FK_WishListItems_WishLists
    FOREIGN KEY(WishListID)
    REFERENCES [customer].WishLists(WishListID)
END
GO

-- *** WishListItems FK: Variant ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_WishListItems_ProductVariants'
)
BEGIN
    ALTER TABLE [customer].WishListItems
    ADD CONSTRAINT FK_WishListItems_ProductVariants
    FOREIGN KEY(VariantID)
    REFERENCES [catalog].ProductVariants(VariantID)
END
GO

-- *** ProductQuestions Foreign Keys ***

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductQuestions_Products')
BEGIN
    ALTER TABLE [review].ProductQuestions
    ADD CONSTRAINT FK_ProductQuestions_Products
    FOREIGN KEY(ProductID) REFERENCES [catalog].Products(ProductID)
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductQuestions_Users')
BEGIN
    ALTER TABLE [review].ProductQuestions
    ADD CONSTRAINT FK_ProductQuestions_Users
    FOREIGN KEY(UserID) REFERENCES [security].Users(UserID)
END
GO

-- *** ProductAnswers Foreign Keys ***

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductAnswers_Questions')
BEGIN
    ALTER TABLE [review].ProductAnswers
    ADD CONSTRAINT FK_ProductAnswers_Questions
    FOREIGN KEY(QuestionID) REFERENCES [review].ProductQuestions(QuestionID)
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_ProductAnswers_Users')
BEGIN
    ALTER TABLE [review].ProductAnswers
    ADD CONSTRAINT FK_ProductAnswers_Users
    FOREIGN KEY(UserID) REFERENCES [security].Users(UserID)
END
GO


-- *** Favorites FK: Users ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Favorites_Users')
BEGIN
    ALTER TABLE [customer].Favorites
    ADD CONSTRAINT FK_Favorites_Users
    FOREIGN KEY(UserID) REFERENCES [security].Users(UserID)
END
GO

-- *** Favorites FK: Products ***
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Favorites_Products')
BEGIN
    ALTER TABLE [customer].Favorites
    ADD CONSTRAINT FK_Favorites_Products
    FOREIGN KEY(ProductID) REFERENCES [catalog].Products(ProductID)
END
GO

-- *** Notifications FK: User ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_Notifications_Users'
)
BEGIN
    ALTER TABLE [system].Notifications
    ADD CONSTRAINT FK_Notifications_Users
    FOREIGN KEY(UserID)
    REFERENCES [security].Users(UserID)
END
GO

-- *** AuditLogs FK: User ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_AuditLogs_Users'
)
BEGIN
    ALTER TABLE [system].AuditLogs
    ADD CONSTRAINT FK_AuditLogs_Users
    FOREIGN KEY(UserID)
    REFERENCES [security].Users(UserID)
END
GO

-- *** CartItems FK: ShoppingCart ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_CartItems_ShoppingCarts'
)
BEGIN
    ALTER TABLE [sales].CartItems
    ADD CONSTRAINT FK_CartItems_ShoppingCarts
    FOREIGN KEY(CartID)
    REFERENCES [sales].ShoppingCarts(CartID)
END
GO

-- *** OrderItems FK: Order ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_OrderItems_Orders'
)
BEGIN
    ALTER TABLE [sales].OrderItems
    ADD CONSTRAINT FK_OrderItems_Orders
    FOREIGN KEY(OrderID)
    REFERENCES [sales].Orders(OrderID)
END
GO
