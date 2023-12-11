-- The UNION operator is used to combine the result-set of two or more SELECT statements.
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

-- The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;

-- Selects all Germany's cities
SELECT City, Country FROM Customers
WHERE Country='Germany'
UNION
SELECT City, Country FROM Suppliers
WHERE Country='Germany'
ORDER BY City;

-- Rename one column for both tables
SELECT 'Customer' AS Type, ContactName, City, Country
FROM Customers
UNION
SELECT 'Supplier', ContactName, City, Country
FROM Suppliers
