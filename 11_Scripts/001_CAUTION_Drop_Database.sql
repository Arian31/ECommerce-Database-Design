/*
===============================================================================
 CAUTION: DESTRUCTIVE DATABASE OPERATION
===============================================================================
 This script is intentionally disabled to prevent accidental execution.

 When enabled, it can:
   1. Disconnect active sessions from ECommerceDB.
   2. Roll back uncommitted transactions.
   3. Permanently drop the ECommerceDB database.

 Review the script carefully before use.
 To execute it, remove the block comment markers around ONLY the desired option.
===============================================================================
*/


/*
-- OPTION 1: Force immediate rollback and prepare the database for removal.

USE master;
GO

ALTER DATABASE ECommerceDB
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE IF EXISTS ECommerceDB;
GO
*/


/*
-- OPTION 2: Allow active transactions up to 5 seconds to complete before
-- forcing rollback and removing the database.

USE master;
GO

ALTER DATABASE ECommerceDB
SET SINGLE_USER
WITH ROLLBACK AFTER 5;
GO

DROP DATABASE IF EXISTS ECommerceDB;
GO
*/