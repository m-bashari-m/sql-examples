-- Min and Max
SELECT MIN(Price) AS SmallestPrice
FROM Products;

SELECT MAX(Price)
FROM Products; 

-- Count all products. Returned column will be unnamed
SELECT COUNT(*)
FROM Products;

-- Count specific column
SELECT COUNT(ProductID)
FROM Products
WHERE Price > 20;

-- Count with ignoring duplicates
SELECT COUNT(DISTINCT Price)
FROM Products;

-- Name returned column, it's name will be "number of records"
SELECT COUNT(*) AS [number of records]
FROM Products;

-- Sum over Quantity and rename to total
SELECT SUM(Quantity) AS total
FROM OrderDetails
WHERE Product_id = 11;

-- Sum with expression
SELECT SUM(Quantity * 10)
FROM OrderDetails

-- Sum with left join and expression
SELECT SUM(Price * Quantity)
FROM OrderDetails
LEFT JOIN Products ON OrderDetails.ProductID = Products.ProductID; 

-- Simple average over price
SELECT AVG(Price)
FROM Products
WHERE CategoryID = 1;

-- Select prices higher than average
SELECT * FROM Products
WHERE price > (SELECT AVG(price) FROM Products); 
