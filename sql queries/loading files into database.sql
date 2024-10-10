
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