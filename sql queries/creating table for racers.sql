-- splitting division column into gender and age
WITH gender_age AS(
SELECT
	racerID,
	name,
	division,
	(LEFT(division, 1)) AS gender,
	(RIGHT(division, LEN(division) - 1)) AS age 
FROM toronto10k
)
-- creating racer table from query
SELECT 
	racerID,
	name,
	gender,
	CASE
		WHEN age = '-OPEN' THEN 'Open'
		-- combine U20 with 20-29 group
		WHEN age LIKE '%U%' OR age = '2029' THEN '19-29'
		-- combine 90+ with 60-69 age group
		WHEN age = '90+' OR age = '6069' THEN '60+'
		WHEN age LIKE '[345]___' THEN LEFT(age, 2) + '-' + RIGHT(age, 2)
	END AS ageBracket
INTO racers
FROM gender_age;

-- make racerID the primary key
ALTER TABLE racers
ADD CONSTRAINT PK_racerID PRIMARY KEY(racerID)

-- adding a foregin key constraint 
ALTER TABLE race_results
ADD CONSTRAINT FK_racerID
FOREIGN KEY (racerID)
REFERENCES racers (racerID)
ON DELETE CASCADE;

-- delete racers in the open category
DELETE FROM racers
WHERE ageBracket = 'Open'



