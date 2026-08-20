USE ECommerceDB
GO

CREATE FUNCTION catalog.fn_GetProductStatusName
(
    @Status TINYINT
)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @StatusName NVARCHAR(20);

    SET @StatusName = CASE @Status
        WHEN 1 THEN N'Active'
        WHEN 2 THEN N'Out of Stock'
        WHEN 3 THEN N'Draft'
        WHEN 4 THEN N'Discontinued'
        ELSE N'Unknown'
    END;

    RETURN @StatusName;
END
GO