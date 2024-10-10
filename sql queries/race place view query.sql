CREATE VIEW race_place AS
SElECT
	CAST(LEFT(overall_place, LEN(overall_place) - 5) AS INT) AS overall_place,
	name,
	gun_time,
	chip_time,
	division
FROM toronto10k;