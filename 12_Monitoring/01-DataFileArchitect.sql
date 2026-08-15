USE ECommerceDB
GO

-- Check if the database exists
IF DB_ID('ECommerceDB') > 0
    PRINT 'The Database Exists'
-- DROP DATABASE ECommerceDB

-- View database files and metadata
EXEC SP_HELPFILE
GO

-- System Dynamic Management View (DMV) - Advanced View
-- DMVs were introduced in SQL Server 2005
SELECT *
FROM sys.database_files
GO

-- Check if the table exists
IF OBJECT_ID('sales.Orders') > 0
    PRINT 'The Table Exists'

-- Check if the table is a Heap (no clustered index)
EXEC SP_HELPINDEX 'sales.Orders'

SELECT *
FROM sys.indexes
WHERE OBJECT_ID = OBJECT_ID('sales.Orders')

-- Identify all Heap tables in the database
SELECT OBJECT_NAME(OBJECT_ID) AS TableName, *
FROM sys.indexes
WHERE type_desc = 'Heap'
GO

-- Check table size and storage usage
EXEC SP_SPACEUSED '[security].Users'
GO

-- View table records
SELECT *
FROM security.Users
GO

/*
   DBCC IND: Retrieves page allocation information for a table
   - Parameter 1: Database Name
   - Parameter 2: Table Name
   - Parameter 3: -1 (Display status for all pages)
   - IAM Page (Index Allocation Map): Contains addresses of pages belonging to the table.
*/
DBCC IND('ECommerceDB', '[security].Users', -1) WITH NO_INFOMSGS
GO

-- This function was introduced in SQL Server 2012+
-- %%physloc%% returns the physical location of each row
SELECT 
    -- Format: FileID:PageID:SlotID
    sys.fn_PhysLocFormatter (%%physloc%%) AS [Physical RID],
    *
FROM [security].Users
GO

-- Enable trace flag 3604 to redirect DBCC output to the console
DBCC TRACEON(3604);
GO

-- View the raw content of a specific page
-- Parameters: Database Name, FileID, PageID, Output Style (0-3)
-- Note: Check the data output at the end of this result set
DBCC PAGE('ECommerceDB', 1, 696, 0) WITH NO_INFOMSGS;
GO