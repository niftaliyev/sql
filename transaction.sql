create database TestDb


CREATE TABLE CreditCard(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Owner NVARCHAR(60) NOT NULL,
	PinCode INT NOT NULL,
	CardNumber NVARCHAR(19),
	[Money] Money NOT NULL DEFAULT 0,

	CONSTRAINT CK_Pincode CHECK(PinCode < 10000 AND PinCode >= 0),
	CONSTRAINT CK_CardNumber CHECK(CardNumber LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
	CONSTRAINT CK_CheckMoney CHECK([Money] >=0 and [Money] <= 10000)
);

drop table CreditCard

-- 1234-1234-1234-1234





ALTER PROCEDURE MoneyTransfer
	@CardNumberSender NVARCHAR(19),
	@CardNumberReciver NVARCHAR(19),
	@Quantity MONEY
AS
BEGIN
	IF @Quantity > 0
	BEGIN
	UPDATE CreditCard
	SET [Money] = [Money] - @Quantity
	WHERE CardNumber LIKE @CardNumberSender

	UPDATE CreditCard
	SET [Money] = [Money] + @Quantity
	WHERE CardNumber LIKE @CardNumberReciver
	END
END

INSERT INTO CreditCard(Owner,CardNumber,PinCode,Money)VALUES('','5678-5678-5678-5678',9874,100000)
INSERT INTO CreditCard(Owner,CardNumber,PinCode,Money)VALUES('','1234-1234-1234-1234',1234,3000)


update CreditCard 
SET Money = 5000
where Id = 4





ALTER PROCEDURE MoneyTransfer
	@CardNumberSender NVARCHAR(19),
	@CardNumberReciver NVARCHAR(19),
	@Quantity MONEY
AS
BEGIN
	IF @Quantity > 0
	BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	UPDATE CreditCard
	SET [Money] = [Money] - @Quantity
	WHERE CardNumber LIKE @CardNumberSender

	UPDATE CreditCard
	SET [Money] = [Money] + @Quantity
	WHERE CardNumber LIKE @CardNumberReciver
	COMMIT
	END TRY
	BEGIN CATCH
		PRINT 'TRY CATCH ERROR!!'
		ROLLBACK
	END CATCH
	END
	ELSE
		PRINT 'IF ELSE ERROR!!'
END

EXEC MoneyTransfer '1234-1234-1234-1234','5678-5678-5678-5678',4000

select * from CreditCard


