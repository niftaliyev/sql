--Default Functions --- T-SQL

--Strings
SELECT Name FROM Books WHERE LEN(Name) > 10
SELECT LTRIM('         123        ');
SELECT RTRIM('         123        ');
SELECT CHARINDEX('a','Gultac',0)
SELECT PATINDEX('%Fizuli%','My name is Fizuli');
select left('Kamran',2)
select right('Kamran',2)
select SUBSTRING('Kamran',3,3)
select reverse('Kamran')
select concat('Kamran','!!!!!!!!!!')
select lower('Kamran')
select upper('Kamran')
select SPACE(20)

--Numbers
SELECT Price from Books

SELECT ROUND(Price,2) FROM Books
SELECT CEILING(Price) FROM Books
SELECT FLOOR(Price) FROM Books
SELECT RAND()
SELECT RAND()
SELECT ISNUMERIC('123')
SELECT ABS(-10)
SELECT SQRT(16)
SELECT SIN(1)
SELECT COS(1)
SELECT TAN(1)

-- Dates 
SELECT GETDATE() --2024-04-26 20:45:56.837
SELECT GETUTCDATE() -- 2024-04-26 16:47:12.083 + 4
SELECT DAY(GETDATE()) --26
SELECT YEAR(GETDATE()) --2024
SELECT MONTH(GETDATE()) --4
SELECT ISDATE('2025-05-25')
SELECT DATEFROMPARTS(2025,05,25)
SELECT DATEADD(month,4,GETDATE())
SELECT DATEADD(day,4,GETDATE())
SELECT DATEADD(YEAR,4,GETDATE())
SELECT DATEDIFF(YEAR,'2015-12-31',GETDATE())

--Typcasting
SELECT Pages FROM Books where pages % 2 = 0  --error
SELECT Pages FROM Books where CAST(pages AS INT) % 2 = 1 
SELECT Name, CAST(Price AS NVARCHAR(50)) + ' $' FROM books

--OTHER
SELECT NEWID()
SELECT NEWID()