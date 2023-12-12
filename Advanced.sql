-- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.

-- Countries with more than 5 customers
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;

-- Order previous example
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY COUNT(CustomerID) DESC;

-- lists the employees that have registered more than 10 orders
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM (Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID)
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 10;

-- A complete example
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 25;

-- The EXISTS operator is used to test for the existence of any record in a subquery.
-- The EXISTS operator returns TRUE if the subquery returns one or more records.

-- Returns TRUE and lists the suppliers with a product price less than 20
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);

-- Returns a boolean value as a result
-- Returns TRUE if ANY of the subquery values meet the condition

-- Lists the ProductName if it finds ANY records in the OrderDetails table has Quantity equal to 10
SELECT ProductName
FROM Products
WHERE ProductID = ANY
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);

-- Returns a boolean value as a result
-- Returns TRUE if ALL of the subquery values meet the condition

-- lists the ProductName if ALL the records in the OrderDetails table has Quantity equal to 10
SELECT ProductName
FROM Products
WHERE ProductID = ALL
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);

-- The SELECT INTO statement copies data from one table into a new table.

-- Creates a backup copy of Customers
SELECT * INTO CustomersBackup2017
FROM Customers;

-- Uses the IN clause to copy the table into a new table in another database
SELECT * INTO CustomersBackup2017 IN 'Backup.mdb'
FROM Customers;

-- Copies only a few columns into a new table
SELECT CustomerName, ContactName INTO CustomersBackup2017
FROM Customers;

-- Copies data from more than one table into a new table
SELECT Customers.CustomerName, Orders.OrderID
INTO CustomersOrderBackup2017
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Create a new, empty table using the schema of another
SELECT * INTO newtable
FROM oldtable
WHERE 1 = 0;
