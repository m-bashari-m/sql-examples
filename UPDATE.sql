-- Update one record
UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;

-- Update multiple record
UPDATE Customers
SET ContactName='Juan'
WHERE Country='Mexico';

-- Update all recoreds
UPDATE Customers
SET ContactName='Juan';

-- Delete multiple records
DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';

-- Delete all records
DELETE FROM Customers;

-- Delete a table
DROP TABLE Customers;
