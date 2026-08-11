USE ECommerceDB
GO

IF NOT EXISTS (SELECT 1 FROM [shipping].ShippingCompanies)
BEGIN
    INSERT INTO [shipping].ShippingCompanies (CompanyName, ContactNumber, IsActive)
    VALUES 
    (N'DHL Express', N'+49-228-1820', 1),
    (N'FedEx', N'+1-800-463-3339', 1),
    (N'UPS', N'+1-800-742-5877', 1),
    (N'Maersk Logistics', N'+45-3363-3363', 1),
    (N'Royal Mail', N'+44-3457-740-740', 1);

    PRINT 'Global Shipping Companies seeded successfully.';
END
GO