IF NOT EXISTS
(
    SELECT *
    FROM sys.tables
    WHERE name = 'UserRoles'
)
BEGIN
    CREATE TABLE UserRoles
    (
        UserID INT NOT NULL,
        RoleID INT NOT NULL,
        AssignedDate DATETIME2 NOT NULL DEFAULT GETDATE(),

        CONSTRAINT PK_UserRoles
            PRIMARY KEY (UserID, RoleID)
    )
END

GO

