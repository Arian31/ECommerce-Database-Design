USE ECommerceDB
GO

CREATE FUNCTION sales.fn_CalculateTax
(
    @Amount DECIMAL(18,2),
    @TaxRate DECIMAL(5,2) -- مثلاً 9.00 برای 9 درصد
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TaxAmount DECIMAL(18,2);
    
    -- محاسبه مبلغ مالیات
    SET @TaxAmount = @Amount * (@TaxRate / 100.0);
    
    RETURN @TaxAmount;
END
GO