-- The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

-- There are wildcards used in conjunction with the LIKE operator:
    -- % 	Represents zero or more characters
    -- _ 	Represents a single character
    -- [] 	Represents any single character within the brackets *
    -- ^ 	Represents any character not in the brackets *
    -- - 	Represents any single character within the specified range *
    -- {} 	Represents any escaped character **

-- Select all customers with name starting with a
SELECT * FROM Customers
WHERE CustomerName LIKE 'a%'; 

-- Selects all customers with name including mer
SELECT * FROM Customers
WHERE CustomerName LIKE '%mer%';

-- Selects something like London or Lander
SELECT * FROM Customers
WHERE city LIKE 'L_nd__';

-- Selects CustomerNames starting with b or s or p
SELECT * FROM Customers
WHERE CustomerName LIKE '[bsp]%';

-- Selects CustomerName starting with "a", "b", "c", "d", "e" or "f"
SELECT * FROM Customers
WHERE CustomerName LIKE '[a-f]%';

-- CustomerNames starting with a and atleast has 3 character length
SELECT * FROM Customers
WHERE CustomerName LIKE 'a__%'; 

