-- drop table if it exists
IF OBJECT_ID('toronto10k', 'U') IS NOT NULL
BEGIN
	DROP TABLE toronto10k
END

-- creating table
CREATE TABLE toronto10k(
	racerID INT PRIMARY KEY NOT NULL,
	name NVARCHAR(250) NOT NULL,
	overall_place NVARCHAR(50) NOT NULL,
	chip_time TIME NOT NULL,
	gun_time TIME NOT NULL,
	division NVARCHAR(10)
);

-- iterate through csv files and insert into table
DECLARE @NumFiles INT =  5;
DECLARE @Counter INT = 1;

DECLARE @Path NVARCHAR(255) = 'C:\\Users\\tammy\\Desktop\\Webscraping\\race stats\\data_csv\\';
DECLARE @FileName NVARCHAR(255) = 'toronto10k_pg';
DECLARE @FullPath NVARCHAR(255);

WHILE @Counter <= @NumFiles
BEGIN
	SET @FullPath = @Path + @FileName + CAST(@Counter AS NVARCHAR(10))+ '.csv';

	BEGIN TRY
		EXEC('
			BULK INSERT dbo.toronto10k
			FROM ''' + @FullPath + '''
			WITH (
				FIELDTERMINATOR = '','',
				ROWTERMINATOR = ''\n'',
				FIRSTROW = 2
			);
		');
	END TRY
	BEGIN CATCH
		PRINT 'Error importing ' + @FullPath;
	END CATCH;

	SET @Counter = @Counter + 1
END;