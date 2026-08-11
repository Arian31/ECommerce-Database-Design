USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'AuditLogs' AND schema_id = SCHEMA_ID('system')
)
BEGIN
	CREATE TABLE [system].AuditLogs
	(
		LogID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		UserID INT NULL,               -- می‌تواند NULL باشد (مثلاً لاگ‌های سیستمی یا خطای ورود)
		[Action] NVARCHAR(50) NOT NULL, -- Insert, Update, Delete, Login, etc.
		TableName NVARCHAR(50) NOT NULL,
		RecordID INT NULL,
		LogDate DATETIME2 NOT NULL,
		IPAddress VARCHAR(45) NULL     -- فضای کافی برای IPv6
	)
END
GO

