--Trigger

-- insert, delete, update

--create trigger [trigger-Name] ON [table name]
--[AFTER INSTEAD OF INSERT DELETE UPDATE]
--BEGIN
--	LOGIC
--END

CREATE TRIGGER TestInsertToEmployees
ON Employees
AFTER INSERT
AS
BEGIN
	PRINT 'New Employee added'
END

INSERT INTO Employees (Name,Surname,PositionId)
VALUES ('Nadir','Zeynalov',1)

ALTER TRIGGER TestDeleteTriggerToEmployees
ON Employees
AFTER DELETE
AS
BEGIN
	--PRINT 'Deleted!!'
	SELECT * FROM  deleted
END


CREATE TRIGGER TestUpdateTriggerToEmployees
ON Employees
AFTER UPDATE
AS
BEGIN
	PRINT 'Updated!!'
END

UPDATE Employees
SET Name = 'Test Employee'
WHERE Id = 12; 

-- DML(Data Manipulation Language)

CREATE TABLE HistoryEmployee(
Id INT PRIMARY KEY IDENTITY(1,1),
DMLQuery VARCHAR(10) NOT NULL,
EmplyeeFullName NVARCHAR(60) NOT NULL)

DROP TABLE HistoryEmployee

ALTER TRIGGER LogEmployee ON Employees
AFTER DELETE
AS
BEGIN
	INSERT INTO HistoryEmployee
	SELECT 'Delete', CONCAT(deleted.Name, ' ', deleted.Surname) from deleted
END

DELETE FROM Employees WHERE Id = 15 

alter TRIGGER LogEmployeeInsert ON Employees
AFTER INSERT
AS
BEGIN
	INSERT INTO HistoryEmployee
	SELECT 'INSERT', CONCAT(inserted.Name, ' ', inserted.Surname) from inserted
END

INSERT INTO Employees (Name,Surname,PositionId)
VALUES ('Elxan','Ehmedov',1)

alter TRIGGER LogEmployeUpdate ON Employees
AFTER update
AS
BEGIN
	--DECLARE @oldName VARCHAR(100) = (SELECT Name FROM deleted)
	--DECLARE @newName VARCHAR(100) = (SELECT Name FROM inserted)
	--DECLARE @oldId VARCHAR(100) = (SELECT Id FROM deleted)
	--DECLARE @newId VARCHAR(100) = (SELECT Id FROM inserted)
	INSERT INTO HistoryEmployee
	--SELECT 'update', CONCAT(@oldName , ' to ',@newName ) from inserted where @oldId = @newId
	SELECT 'update', CONCAT(deleted.Name , ' to ',inserted.Name ) from inserted,deleted where inserted.Id = deleted.Id

END

--update

--1 delete
--2 insert

UPDATE Employees
SET Name = 'Nihad'
WHERE Id = 10; 

-- =0 mehsul stockda yoxdur
-- =1 mehsuldan stockda sonuncudur
-- > 1 < 5 az qalib
-- > 5 mehsul stockda yeterincedir

CREATE Table Product(
Id INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(60) NOT NULL,
Price MONEY NOT NULL,
[Count] INT NOT NULL,
Description NVARCHAR(30))

-- AFTER DIFFERENCE INSTEAD
alter TRIGGER ProductInsertTrigger ON Product
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @ExistsProduct varchar(30) = (SELECT Product.Name FROM inserted,Product WHERE Product.Name = inserted.Name)

	IF @ExistsProduct is null
	BEGIN
	INSERT INTO Product (Name,Price,[Count],[Description])
	SELECT inserted.Name,Price,[Count],
	CASE
    WHEN [Count] = 0 THEN 'mehsul stockda yoxdur'
    WHEN [Count] = 1 THEN 'mehsuldan stockda sonuncudur'
    WHEN [Count] > 1 and [Count] < 5 THEN 'Mehdud saydadir'
	WHEN [Count] > 5 THEN 'mehsul stockda yeterincedir'
    ELSE 'unknown'
	END

	from inserted
	END
	else
		print '@ExistsProduct is not null'
	
END

ALTER TABLE Product ENABLE TRIGGER ProductInsertTrigger

INSERT INTO Product (Name,Price,Count) VALUES ('Tea',5,10)
INSERT INTO Product (Name,Price,Count) VALUES ('Milk',3,10)

DELETE FROM Product where id in (3,4)

select *
from Product