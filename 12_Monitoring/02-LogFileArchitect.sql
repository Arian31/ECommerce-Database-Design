-- One of the factors that increases performance is separating physical disks for Data files and Log files.
-- Log file architecture has two states:
-- 1. Logical Architecture
-- 2. Physical Architecture
-- Log files are divided into Virtual Log Files, commonly known as VLFs.
-- Your log records are recorded within each VLF.

-- An Insert operation writes three records in the log:
-- Begin Transaction - Insert - Commit Transaction
-- Until the Commit is written, the operation is technically considered a "Rollback" candidate.
-- Log file size increases constantly because even a small change adds many records.

USE ECommerceDB
GO

EXEC SP_HELPFILE
GO

-- Log file behavior is controlled by one of the database options.
-- Recovery models: Full, Bulk-Logged, Simple
-- Check the current Recovery Model:
SELECT 
	database_id,
	name,
	recovery_model_desc
FROM SYS.databases
GO

-- Recommendation:
-- Production/Operational Databases => Full Recovery Model (Requires Log Backups)
-- Development Environments => Simple Recovery Model

-- View VLFs (Virtual Log Files)
DBCC LOGINFO
GO

-- View the content of Log Records
-- LSN => Log Sequence Number
-- Logs with the same Transaction ID belong to the same operation.
SELECT *
FROM SYS.fn_dblog(NULL,NULL)
GO

-- Switching to Simple Recovery Model
ALTER DATABASE ECommerceDB 
SET RECOVERY SIMPLE
GO

-- The number of records will decrease after setting to Simple.
SELECT *
FROM SYS.fn_dblog(NULL,NULL)
GO

-- Creating a table generates many records, even if it is a Heap.
-- During the initial insert of a table, we will have more records compared to subsequent inserts.
-- In an Update command, data is not overwritten on previous pages. It is written to a new page, the old flag is removed, and a new flag is placed on the new page.
-- The log records: "Old log was this, new log is this."
-- Recommendation: Try not to use the Update command for fun!!! It leads to performance degradation.
GO