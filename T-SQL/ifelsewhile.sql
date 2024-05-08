--DECLARE @minYear INT; 
--SET @minYear = (SELECT MAX(YearPress) FROM Books);

----PRINT @minYear

--IF @minYear = 1990
--BEGIN
--	print('yes @minYear IS 1990')
--	SELECT * FROM Books WHERE YearPress = @minYear
--END
--ELSE IF @minYear = 2001
--BEGIN
--	print('yes @minYear IS 2001')
--	SELECT * FROM Books WHERE YearPress = @minYear
--END
--ELSE
--BEGIN
--	PRINT('NO')
--END

--SELECT *
--FROM Books
--order by YearPress

--			WHILE
-- MONEY = 1000
-- MONTH = 6
-- PERCENT = 1.5
-- START DATE = 2024-04-29
-- START DATE = 2024-10-29

DECLARE @result TABLE ([Date] Date , Amount MONEY)
DECLARE @startDate DATE = GETDATE()
DECLARE @startMoney MONEY = 1000
DECLARE @month INT = 6
DECLARE @percent FLOAT = 1.5

WHILE @month > 0
BEGIN 
	SET @month = @month-1
	SET @startDate = DATEADD(MONTH,1,@startDate)
	SET @startMoney = @startMoney +((@startMoney / 100) * @percent)
	INSERT INTO @result VALUES(@startDate, ROUND(@startMoney,2))
END

SELECT * FROM @result


--TRY
--CATCH
DECLARE @testtrycatch TABLE ([Text] NVARCHAR(5))
DECLARE @Text NVARCHAR(50) = N'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...'

BEGIN TRY
	insert into @testtrycatch VALUES(@Text)
END TRY

BEGIN CATCH
	print('error')
END CATCH

