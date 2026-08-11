USE ECommerceDB
GO

-- ÃœÊ· ”Ê«·«  „Õ’Ê·« 
IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'ProductQuestions' AND schema_id = SCHEMA_ID('review')
)
BEGIN
	CREATE TABLE [review].ProductQuestions
	(
		QuestionID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		ProductID INT NOT NULL,
		UserID INT NOT NULL,
		Question NVARCHAR(MAX) NOT NULL,
		CreatedAt DATETIME2 NOT NULL
	)
END
GO