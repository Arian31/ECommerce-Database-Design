--  ÃœÊ· Å«”Œ ”Ê«·« 
IF NOT EXISTS
(
	SELECT *
	FROM sys.tables
	WHERE name = 'ProductAnswers' AND schema_id = SCHEMA_ID('review')
)
BEGIN
	CREATE TABLE [review].ProductAnswers
	(
		AnswerID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
		QuestionID INT NOT NULL,
		UserID INT NOT NULL,
		Answer NVARCHAR(MAX) NOT NULL,
		CreatedAt DATETIME2 NOT NULL
	)
END
GO
