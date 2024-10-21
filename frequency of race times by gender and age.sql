CREATE VIEW freqOfRaceTimes AS
WITH joined AS (
SELECT 
	race_results.*,
	racers.name,
	racers.gender,
	racers.ageBracket
FROM race_results
	INNER JOIN racers	
		ON race_results.racerID = racers.racerID
)
SELECT
	gender,
	ageBracket,
	COUNT(CASE WHEN gun_time >'00:30:00.0000000' AND chip_time < '00:40:00.0000000' THEN 1 ELSE NULL END) AS timeSub40,
	COUNT(CASE WHEN gun_time>= '00:40:00.0000000' AND chip_time <'00:50:00.0000000' THEN 1 ELSE NULL END) AS time40to50min,
	COUNT(CASE WHEN gun_time>= '00:50:00.0000000' AND chip_time <'01:00:00.0000000' THEN 1 ELSE NULL END) AS time50to60min,
	COUNT(CASE WHEN gun_time>= '01:00:00.0000000' AND chip_time <'01:10:00.0000000' THEN 1 ELSE NULL END) AS time60to70min,
	COUNT(CASE WHEN gun_time>= '01:10:00.0000000' THEN 1 ELSE NULL END) AS time70plusMin,
	COUNT(*) AS totalNum
FROM joined
GROUP BY gender, ageBracket
