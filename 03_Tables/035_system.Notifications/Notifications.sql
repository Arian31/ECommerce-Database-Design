USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Notifications' AND schema_id = SCHEMA_ID('system')
)
BEGIN
	CREATE TABLE [system].Notifications
	(
		NotificationID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		UserID INT NOT NULL,
		Title NVARCHAR(150) NOT NULL,
		[Message] NVARCHAR(MAX) NOT NULL,
		IsRead BIT DEFAULT 0 NOT NULL,
		CreatedAt DATETIME2 NOT NULL
	)
END
GO