USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Addresses'
)
BEGIN 
	CREATE TABLE [Catalog].Addresses
	(
		AddressID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		UserID INT NOT NULL,
		Province NVARCHAR(25) NULL,
		City NVARCHAR(25) NULL,
		PostalCode NVARCHAR(20) NULL,
		AddressLine NVARCHAR(200) NULL,
		ReceiverName NVARCHAR(50) NULL,
		ReceiverPhone NVARCHAR(20) NULL,
		IsDefault BIT DEFAULT 0 NOT NULL,
		CreatedAt DATE NOT NULL
	)
END
GO

