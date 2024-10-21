-- this file normalizes the toronto10k table by seperating the race info from the racers info

-- creating a table for the race results
IF OBJECT_ID('race_results', 'U')IS NOT NULL
BEGIN
	DROP TABLE race_results
END

SELECT
	CAST(LEFT(overall_place, LEN(overall_place) - 5) AS INT) AS overall_place,
	racerID,
	gun_time,
	chip_time
INTO race_results
FROM toronto10k;

-- making overall_place as the primary key
ALTER TABLE race_results
ALTER COLUMN overall_place INT NOT NULL;

ALTER TABLE race_results
ADD CONSTRAINT PK_overall_place PRIMARY KEY (overall_place);

-- creating a table for racers

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





