--CREATE PROCEDURE myFirstProcedure
--AS
--PRINT 'Hello'

--EXEC myFirstProcedure

--ALTER PROCEDURE myFirstProcedure
--AS
--PRINT 'Hello World!!!'

--EXEC myFirstProcedure

--DROP PROCEDURE myFirstProcedure

--create proc mySecondProcedure
--AS
--BEGIN
--print('test1')
--print('test2')
--END

--EXEC mySecondProcedure


CREATE PROC BooksWithAutorAndPress
AS
BEGIN
	SELECT B.Name, A.FirstName + ' ' + A.LastName AS Autor, P.Name AS PressName
	FROM Books AS B
	JOIN Authors AS A ON A.Id = B.Id_Author
	JOIN Press AS P ON P.Id = B.Id_Press
END

EXEC BooksWithAutorAndPress

CREATE VIEW BooksWithAutorAndPressView
AS
SELECT B.Name, A.FirstName + ' ' + A.LastName AS Autor, P.Name AS PressName
FROM Books AS B
JOIN Authors AS A ON A.Id = B.Id_Author
JOIN Press AS P ON P.Id = B.Id_Press

SELECT * FROM BooksWithAutorAndPressView;



ALTER PROC BooksWithAutorAndPress
	@year INT
AS
BEGIN
	SELECT B.Name, A.FirstName + ' ' + A.LastName AS Autor, P.Name AS PressName
	FROM Books AS B
	JOIN Authors AS A ON A.Id = B.Id_Author
	JOIN Press AS P ON P.Id = B.Id_Press
	where b.YearPress = @year
END


ALTER procedure BooksWithAutorAndPress
	@year INT = null
AS
BEGIN
	IF @year is not null
	BEGIN
		SELECT B.Name, A.FirstName + ' ' + A.LastName AS Autor, P.Name AS PressName
		FROM Books AS B
		JOIN Authors AS A ON A.Id = B.Id_Author
		JOIN Press AS P ON P.Id = B.Id_Press
		where b.YearPress = @year
	END
	ELSE
	BEGIN
		SELECT B.Name, A.FirstName + ' ' + A.LastName AS Autor, P.Name AS PressName
		FROM Books AS B
		JOIN Authors AS A ON A.Id = B.Id_Author
		JOIN Press AS P ON P.Id = B.Id_Press
	END

END

EXEC BooksWithAutorAndPress 1990
EXEC BooksWithAutorAndPress 2001


ALTER PROC SumTwoNumbers
	@firstNumber INT,
	@secondNumber INT
AS
BEGIN
	--PRINT @firstNumber+@secondNumber
	RETURN @firstNumber + @secondNumber
END



DECLARE @result int
EXEC @result = SumTwoNumbers 5,6
PRINT @result

ALTER PROC MaxPages
AS
BEGIN 
	--SELECT max(Pages)
	--FROM Books
	DECLARE @max INT
	SELECT @max = MAX(Pages) FROM Books
	return @max
END

DECLARE @result int
EXEC @result = MaxPages
PRINT @result



ALTER PROCEDURE MinMaxPages
	@min INT OUT,
	@max INT OUT
AS
BEGIN
	SELECT @min = MIN(Pages),@max = MAX(Pages) FROM Books 
END

DECLARE @minResult INT
DECLARE @maxResult INT

exec MinMaxPages @minResult OUTPUT,@maxResult OUTPUT

print @minResult
print @maxResult


CREATE PROCEDURE IncrementQuantity
	@pressName nvarchar(30)
AS
BEGIN
	DECLARE @pressId INT = null

	SELECT @pressId = Id
	FROM Press
	WHERE Press.Name = @pressName

	IF @pressId is not null
	BEGIN
		UPDATE Books
		SET Quantity = Quantity + 1
		WHERE Books.Id_Press = @pressId
	END
END

exec IncrementQuantity 'Питер'


SELECT *
FROM Groups

SELECT *
FROM Students

ALTER PROCEDURE CreateStudent
	@name NVARCHAR(30),
	@surname NVARCHAR(30),
	@groupname VARCHAR(30)
AS
BEGIN
	DECLARE @groupId INT
	SELECT @groupId = Id FROM Groups where [Name] = @groupname
	IF @groupId is null
	BEGIN
		INSERT INTO Groups([Name],Id_Faculty) VALUES(@groupname,1)
		SELECT @groupId = Id FROM Groups WHERE Name = @groupname
	END

	insert into Students(FirstName,LastName,Id_Group,Term) VALUES(@name,@surname,@groupId,1)
END

EXEC CreateStudent N'Mircefer','Nerimanli','javascript'