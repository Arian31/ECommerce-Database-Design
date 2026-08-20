USE ECommerceDB
GO

CREATE VIEW sales.vw_OrderDetails
AS
SELECT 
    O.OrderID,
    O.OrderDate,
    -- ترکیب نام و نام خانوادگی مشتری
    U.FirstName + ' ' + U.LastName AS CustomerName,
    
    -- اطلاعات محصول
    P.ProductName,
    PV.SKU,
    
    -- جزئیات مالی هر ردیف
    OI.Quantity,
    OI.UnitPrice,
    OI.TotalPrice AS ItemTotal,
    
    -- وضعیت سفارش به صورت متنی (بسیار مهم برای نمایش در سایت)
    CASE O.OrderStatus
        WHEN 1 THEN N'Pending'
        WHEN 2 THEN N'Processing'
        WHEN 3 THEN N'Shipped'
        WHEN 4 THEN N'Delivered'
        WHEN 5 THEN N'Canceled'
        ELSE N'Unknown'
    END AS OrderStatusText,
    
    -- مبلغ نهایی کل فاکتور
    O.FinalAmount AS OrderGrandTotal

FROM [sales].Orders O
INNER JOIN [Security].Users U ON O.UserID = U.UserID
INNER JOIN [sales].OrderItems OI ON O.OrderID = OI.OrderID
INNER JOIN [catalog].ProductVariants PV ON OI.VariantID = PV.VariantID
INNER JOIN [catalog].Products P ON PV.ProductID = P.ProductID
GO