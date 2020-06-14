--1
CREATE FUNCTION
fibonacci_sequence (@n INT)
RETURNS
@fibonacci TABLE (Ci¹g_Fibonacciego INT)
BEGIN
	DECLARE @zm INT = 0;
	DECLARE @n1 INT = 0;
	DECLARE @n2 INT = 1;

	IF @n > 0
		BEGIN
			INSERT INTO @fibonacci SELECT @n1;
			SET @n = @n - 1;
		END;
	IF @n > 0
		BEGIN
			INSERT INTO @fibonacci SELECT @n2;
			SET @n = @n - 1;
		END;
	WHILE @n >= 1
		BEGIN
			SET @zm = @n1 + @n2;
			SET @n1 = @n2;
			SET @n2 = @zm;
			SET @n = @n-1;
			INSERT INTO @fibonacci SELECT @zm;
		END;
	RETURN;
END;

CREATE PROCEDURE
fib_seq @n INT
AS
SELECT * FROM fibonacci_sequence(@n);

--2
CREATE TRIGGER
LastNameToUpper ON AdventureWorks2017.Person.Person
FOR UPDATE AS
UPDATE AdventureWorks2017.Person.Person SET LastName = UPPER(LastName)

--3
CREATE TRIGGER
taxRateMonitoring ON AdventureWorks2017.Sales.SalesTaxRate
AFTER UPDATE AS
BEGIN
	DECLARE @old_tax FLOAT = (SELECT TaxRate FROM deleted);
	DECLARE @new_tax FLOAT = (SELECT TaxRate FROM inserted);
	DECLARE @diff FLOAT = @old_tax * 0.3;
	IF (@new_tax > (@old_tax + @diff)) OR (@new_tax < (@old_tax - @diff))
		BEGIN
		PRINT 'B³¹d! Zmieniono wartoœæ w polu TaxRate o wiêcej ni¿ 30%'
		ROLLBACK;
	END;
END;