USE ECommerceDB
GO

IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'Reviews' AND schema_id = SCHEMA_ID('review')
)
BEGIN
	CREATE TABLE [review].Reviews
	(
		ReviewID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		ProductID INT NOT NULL,
		UserID INT NOT NULL,
		Rate TINYINT NOT NULL CHECK (Rate BETWEEN 1 AND 5), -- امتیاز بین 1 تا 5
		Comment NVARCHAR(1000) NULL,
		CreatedAt DATETIME2 NOT NULL,
		IsApproved BIT DEFAULT 0 NOT NULL -- وضعیت تایید توسط مدیر
	)
END
GO
