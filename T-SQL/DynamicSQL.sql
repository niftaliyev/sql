EXEC BooksWithAutorAndPress

-- Dynamic SQL
EXEC sp_executesql N'SELECT * FROM Books'
--SELECT * FROM Books

ALTER PROCEDURE GetAllRows
	@tableName NVARCHAR(100)
AS
BEGIN
	DECLARE @query NVARCHAR(250) = N'SELECT * FROM ' + @tableName
	--PRINT @query
	EXEC sp_executesql @query
END

EXEC GetAllRows 'Books'

--MAX YEARPRESS
SELECT *
FROM Books
ORDER BY YearPress DESC

--SELECT TOP 1 *
--FROM Books
--ORDER BY YearPress DESC
----2001  ->max

--SELECT *
--FROM Books
--WHERE YearPress = (SELECT MAX(YearPress) FROM Books)

CREATE TABLE ImportantData
(
	Id INT PRIMARY KEY IDENTITY,
	ImpartantText VARCHAR(255)
);

ALTER PROCEDURE GetTopBooks
	@quantity INT,
	@desc BIT = 1,
	@column NVARCHAR(100)  --'SELECT TOP 10 * FROM Books'
AS
BEGIN
	DECLARE @query NVARCHAR(255) = N'SELECT TOP '
												+ CAST(@quantity AS nvarchar(10))
												 + ' * FROM Books ORDER BY ' +
												@column + ' ' + IIF(@desc = 1,'DESC','ASC')
	print @query
	EXEC sp_executesql @query
END

--exec GetTopBooks 5 , 1,N'Quantity'
--sql injection
EXEC GetTopBooks 5 , 1 , N'Quantity; DROP TABLE ImportantData; --'

EXEC GetTopBooks 5 , 1 , N'Quantity; SELECT * FROM Students; --'




ALTER PROCEDURE GetTopBooks
	@quantity INT,
	@desc BIT = 1,
	@column NVARCHAR(100)  --'SELECT TOP 10 * FROM Books'
AS
BEGIN
	DECLARE @query NVARCHAR(255) = N'SELECT TOP '
												+ CAST(@quantity AS nvarchar(10))
												 + ' * FROM Books ORDER BY ' +
												QUOTENAME(@column) + ' ' + IIF(@desc = 1,'DESC','ASC')
	print @query
	EXEC sp_executesql @query
END

exec GetTopBooks 5 , 1,N'Quantity'

EXEC GetTopBooks 5 , 1 , N'Quantity; DROP TABLE ImportantData; --'

EXEC GetTopBooks 5 , 1 , N'Quantity; SELECT * FROM Students; --'