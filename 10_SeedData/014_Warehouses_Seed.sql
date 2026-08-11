USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [inventory].Warehouses)
BEGIN
    INSERT INTO [inventory].Warehouses (WarehouseName, [Location], ManagerName, ContactNumber, IsActive, CreatedAt)
    VALUES
    (N'New York Central Hub', N'123 Industrial Way, Bronx, NY 10451, USA', N'John Smith', N'+1-212-555-0198', 1, GETDATE()),
    (N'London Gateway Logistics', N'Unit 5, Royal Docks, London E16 1FR, UK', N'Sarah Williams', N'+44-20-7946-0958', 1, GETDATE()),
    (N'Tokyo Bay Fulfillment', N'6-chōme-1-1 Toyosu, Koto City, Tokyo 135-0061, Japan', N'Kenji Tanaka', N'+81-3-1234-5678', 1, GETDATE()),
    (N'Berlin Euro-Depot', N'Westhafenstraße 1, 13353 Berlin, Germany', N'Hans Weber', N'+49-30-1234567', 1, GETDATE()),
    (N'Dubai Desert Depot', N'Jebel Ali Free Zone, Dubai, UAE', N'Ahmed Mansoor', N'+971-4-123-4567', 1, GETDATE());

    PRINT 'International Warehouses seeded successfully.';
END
GO