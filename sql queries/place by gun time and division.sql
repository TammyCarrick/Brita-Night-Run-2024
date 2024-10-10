WITH rerank AS(
SELECT * ,
	RANK()
		OVER(
			PARTITION BY division
			ORDER BY chip_time
	) AS placeByGunTime,
	-- COUNT(CASE WHEN division = 'F2029' THEN 1 ELSE 0 END) AS numInDivision
	COUNT(*)
		OVER(
			PARTITION BY division
		) AS numInDivision
FROM toronto10k

)

SELECT 
	name,
	overall_place,
	chip_time,
	gun_time,
	division,
	CAST(placeByGunTime AS NVARCHAR(10)) + '/' + CAST(numInDivision AS NVARCHAR(10)) AS placeByDivisionByGunTime
FROM rerank
