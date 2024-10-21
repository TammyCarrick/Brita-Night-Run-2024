-- query to calculate the average chip time for men and women
WITH unformatted AS(
	SELECT DISTINCT
		gender,
		ageBracket,
		AVG(CAST(CAST(chip_time AS DATETIME) AS FLOAT))
			OVER(
				PARTITION BY gender
			) AS avg_time
	FROM racers
		INNER JOIN race_results	
			ON race_results.racerID = racers.racerID
)
SELECT DISTINCT
	gender,
	CAST(CAST(avg_time AS DATETIME) AS TIME) AS avg_time
FROM unformatted
ORDER BY gender;
