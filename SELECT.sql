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

-- VARCHAR length
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;
