USE master
GO

--Data files (.mdf/.ndf) utilize Random I/O for page-level operations,
--while Log files (.ldf) rely on Sequential I/O for transaction recording.
--To optimize performance, these files should be placed on separate physical drives to avoid I/O contention.

--Recommendation: Use fixed size values (e.g., 512MB, 1024MB) for FILEGROWTH 
--   instead of percentages (e.g., 10%). 
--   Percentage growth can cause unpredictable performance spikes and "freezing" 
--   when the database becomes large.

IF NOT EXISTS 
(
	SELECT *
	FROM SYS.databases
	WHERE name = 'ECommerceDB'
)
BEGIN 
    -- Creating the database with multiple data files and custom growth settings
	CREATE DATABASE ECommerceDB
	ON PRIMARY
	(
		NAME = ECommerceDB,
		FILENAME = 'C:\SQLServer\ECommerceDB.mdf',
		SIZE = 10MB,
		MAXSIZE = 200MB,
		FILEGROWTH = 10%
	),
	(
		NAME = DataFile2,
		FILENAME = 'C:\SQLServer\ECommerceDB2.ndf',
		SIZE = 20MB,
		MAXSIZE = 300MB,
		FILEGROWTH = 10%
	),
	(
		NAME = DataFile3,
		FILENAME = 'C:\SQLServer\ECommerceDB3.ndf',
		SIZE = 30MB,
		MAXSIZE = 400MB,
		FILEGROWTH = 10%
	)
	LOG ON
	(
		NAME = LogFile1,
		FILENAME = 'C:\SQLServer\LogFile1.ldf',
		SIZE = 100MB,
		MAXSIZE = 5GB,
		FILEGROWTH = 1024MB -- Fixed growth to keep VLF counts healthy
	)
END
GO