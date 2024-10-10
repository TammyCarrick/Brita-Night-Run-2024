--SELECT DISTINCT(division)
--FROM toronto10k
--ORDER BY division;

--CREATE TABLE racers (
--	name NVARCHAR(50) NOT NULL,
--	gender CHAR(1) NOT NULL,
--	ageBracket NVARCHAR(25) NOT NULL
--);

--GO

DROP TABLE racers;

-- splitting division column into gender and age

WITH gender_age AS(
SELECT
	name,
	division,
	(LEFT(division, 1)) AS gender,
	(RIGHT(division, LEN(division) - 1)) AS age 
FROM toronto10k
)
SELECT 
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

GO