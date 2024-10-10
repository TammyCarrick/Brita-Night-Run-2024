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
-- format gender and age
SELECT 
	racerID,
	name,
	gender,
	CASE
		WHEN age = '-OPEN' THEN 'Open'
		WHEN age LIKE '%U%' THEN 'U20'
		WHEN age LIKE '____' THEN LEFT(age, 2) + '-' + RIGHT(age, 2)
		WHEN age LIKE '___' THEN RIGHT(age,3)
	END AS ageBracket
INTO racers
FROM gender_age;
