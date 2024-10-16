-- this file creates a table for race results
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
