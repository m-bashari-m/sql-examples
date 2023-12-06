-- Check for NULL value
SELECT name FROM Customer
WHERE referee_id IS NULL OR referee_id != 2 

-- Multiple column selection
SELECT name, population, area FROM World
WHERE area > 3000000 OR population > 25000000;

-- Remove duplicate rows | Rename column result | Order
SELECT DISTINCT author_id as id FROM Views 
WHERE author_id = viewer_id
ORDER BY id;

-- Select Distinct Count
SELECT COUNT(DISTINCT Country) FROM Customers;

-- VARCHAR length
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;

-- Cities equal to "Paris" or "London"
SELECT * FROM Customers
WHERE City IN ('Paris','London');

-- Price between range
SELECT * FROM Products
WHERE Price BETWEEN 50 AND 60;

-- Search for pattern | s% -> Cities start with s
-- %s% -> Cities include s
SELECT * FROM Customers
WHERE City LIKE 's%';
