USE ECommerceDB
GO

-- *** UserRoles FKs ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_UserRoles_Users'
)
BEGIN
    ALTER TABLE UserRoles
    ADD CONSTRAINT FK_UserRoles_Users
    FOREIGN KEY(UserID)
    REFERENCES Users(UserID)
END
GO

IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_UserRoles_Roles'
)
BEGIN
    ALTER TABLE UserRoles
    ADD CONSTRAINT FK_UserRoles_Roles
    FOREIGN KEY(RoleID)
    REFERENCES Roles(RoleID)
END
GO

-- *** Addresses FK ***
IF NOT EXISTS 
(
	SELECT *
	FROM sys.foreign_keys 
	WHERE name = 'FK_Addresses_Users'
)
BEGIN
    ALTER TABLE Addresses 
    ADD CONSTRAINT FK_Addresses_Users
    FOREIGN KEY(UserId)
    REFERENCES Users(UserId)
END
GO

-- *** Categories Self-Reference FK ***
IF NOT EXISTS 
(
	SELECT * 
	FROM sys.foreign_keys 
	WHERE name = 'FK_Categories_Parent'
)
BEGIN
    ALTER TABLE Categories
    ADD CONSTRAINT FK_Categories_Parent
    FOREIGN KEY(ParentCategoryID)
    REFERENCES Categories(CategoryID)
END
GO