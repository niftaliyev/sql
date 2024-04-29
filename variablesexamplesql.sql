DECLARE @number INT
SET @number = 54

select @number
--PRINT('number is ' + CAST(@number AS VARCHAR(50)))

DECLARE @year INT
SET @year = 1998

SELECT Name,Price,Date,Themes
FROM books
where YEAR(Date) = @year

declare @minYear1 INT = (SELECT MIN(YearPress) FROM Books)

SELECT *
FROM Books
where YearPress = @minYear1


declare @minYear INT
declare @maxYear INT

SELECT @minYear = MIN(Books.YearPress), @maxYear=MAX(Books.YearPress) 
FROM Books

print(@minYear)
print(@maxYear)

DECLARE @testTable TABLE(Number INT , [Text] NVARCHAR(100))

insert into @testTable VALUES(1,'ONE')
insert into @testTable VALUES(2,'TWO')

SELECT * FROM @testTable

SELECT *
FROM Books

SELECT Press.Name,COUNT(*) 
FROM Books
JOIN Press ON Id_Press = Press.Id
GROUP BY Press.Name
HAVING COUNT(*)  = (SELECT MAX(bookmaxcount) as maxcountofbook 
					FROM (SELECT COUNT(*) AS bookmaxcount
						  FROM Books 
						  GROUP BY Id_Press)as maxpress)



DECLARE @pressAndCount TABLE (Id_Press INT , BoksCount INT)
INSERT INTO @pressAndCount

SELECT Id_Press ,COUNT(*) AS BookCount
FROM Books
GROUP BY Id_Press

DECLARE @maxBooks INT = (SELECT MAX(BoksCount) FROM @pressAndCount)

SELECT Press.Name,BoksCount
FROM @pressAndCount
JOIN Press ON Id_Press = Press.Id
where BoksCount = @maxBooks