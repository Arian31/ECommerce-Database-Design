USE ECommerceDB
GO

-- 1. Security 
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'security')
BEGIN
    EXEC('CREATE SCHEMA [security]')
END
GO

-- 2. Catalog 
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'catalog')
BEGIN
    EXEC('CREATE SCHEMA [catalog]')
END
GO

-- 3. Customer 
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'customer')
BEGIN
    EXEC('CREATE SCHEMA [customer]')
END
GO

-- 4. Sales 
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'sales')
BEGIN
    EXEC('CREATE SCHEMA [sales]')
END
GO

-- 5. Payment 
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'payment')
BEGIN
    EXEC('CREATE SCHEMA [payment]')
END
GO

-- 6. Inventory 
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'inventory')
BEGIN
    EXEC('CREATE SCHEMA [inventory]')
END
GO

-- 7. Purchasing
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'purchasing')
BEGIN
    EXEC('CREATE SCHEMA [purchasing]')
END
GO

-- 8. Shipping 
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'shipping')
BEGIN
    EXEC('CREATE SCHEMA [shipping]')
END
GO

-- 9. Review
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'review')
BEGIN
    EXEC('CREATE SCHEMA [review]')
END
GO

-- 10. System
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'system')
BEGIN
    EXEC('CREATE SCHEMA [system]')
END
GO