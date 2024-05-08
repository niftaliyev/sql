CREATE FUNCTION TestFunction()
RETURNS INT
AS
BEGIN
	RETURN 555;
END

SELECT dbo.TestFunction()


CREATE FUNCTION SumFunction(@first INT , @second INT)
RETURNS INT
AS
BEGIN
	RETURN @first+@second;
END

SELECT dbo.SumFunction(5,6)

SELECT Name, dbo.SumFunction(Quantity,5)
FROM Books

 UPDATE  Books
SET Quantity = 0
where Id = 17




-- 0 Mehsul bitib
-- 1 Sonuncu Mehsul
-- 2<>5 Mehsul bitmek uzeredir
-- >= 6 Mehsul stockda yeterincedir

CREATE FUNCTION TextToQuantity(@quantity INT)
RETURNS NVARCHAR(50)
AS
BEGIN
	RETURN CASE 
		WHEN @quantity = 0 THEN 'Mehsul bitib'
		WHEN @quantity = 1 THEN 'Sonuncu Mehsul'
		WHEN @quantity BETWEEN 2 AND 5 THEN 'Mehsul bitmek uzeredir'
		WHEN @quantity >= 6 THEN 'Mehsul stockda yeterincedir'
		ELSE 'Mehsul yoxdur'
		end
END

SELECT Name , dbo.TextToQuantity(Quantity) FROM Books



CREATE FUNCTION TextFormatDate(@date DATETIME)
RETURNS NVARCHAR(30)
AS
BEGIN
	RETURN CAST(DAY(@date) AS NVARCHAR(10)) + ' ' + DATENAME(MONTH,@date) + ' ' + CAST(YEAR(@date) AS NVARCHAR(10)) 
END

select Students.FirstName, Books.Name,dbo.TextFormatDate(DateOut)
from S_Cards
JOIN Students ON S_Cards.Id_Student = Students.Id
JOIN Books ON Books.Id = S_Cards.Id_Book


CREATE TABLE Person (
	Id INT PRIMARY KEY IDENTITY,
	FullName VARCHAR(255) NOT NULL,
	DateOfBirth DATE NOT NULL

	CONSTRAINT CK_Person_DateOfBirth CHECK (dbo.GetDifferenceInBirth(DateOfBirth) >= 18)
);
DROP TABLE Person


INSERT INTO Person(FullName,DateOfBirth) VALUES ('Kamran Niftaliyev','1995-08-03')
INSERT INTO Person(FullName,DateOfBirth) VALUES ('Mircefer Rzayev','2006-12-26')
INSERT INTO Person(FullName,DateOfBirth) VALUES ('Naila Khalfaguliyeva','1997-01-01')

SELECT DATEDIFF(YEAR,'1995-08-03',GETDATE())

CREATE FUNCTION GetDifferenceInBirth(@date DATE)
RETURNS INT
AS
BEGIN
	RETURN DATEDIFF(YEAR,@date, GETDATE())
END

CREATE FUNCTION GetBooksByYearPress(@year INT)
RETURNS TABLE
AS
	RETURN SELECT * FROM Books WHERE YearPress = @year




SELECT *
FROM Books

SELECT * FROM dbo.GetBooksByYearPress(1999)


CREATE FUNCTION GetBooksByYearPress2(@year INT)
RETURNS @result TABLE(Id INT,BookName NVARCHAR(100),PressName NVARCHAR(100), AutorName NVARCHAR(100))
AS
BEGIN
	INSERT INTO @result
	SELECT b.Id, b.Name,Press.Name,Authors.LastName
	FROM Books AS B
	JOIN Authors ON Authors.Id = B.Id_Author
	JOIN Press ON Press.Id = B.Id_Press
	WHERE YearPress = @year

	RETURN
END
	
SELECT * FROM dbo.GetBooksByYearPress2(1999)
ORDER BY Id DESC

