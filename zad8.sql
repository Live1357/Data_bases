--1
BEGIN
DECLARE @srednia_stawka FLOAT;
SET @srednia_stawka = (SELECT AVG(EPH.Rate * EPH.PayFrequency) FROM AdventureWorks2017.HumanResources.EmployeePayHistory EPH);
SELECT @srednia_stawka AS srednia_stawka;
SELECT E.*, EPH.Rate, EPH.PayFrequency FROM AdventureWorks2017.HumanResources.Employee E  
JOIN AdventureWorks2017.HumanResources.EmployeePayHistory EPH 
ON EPH.BusinessEntityID = E.BusinessEntityID
WHERE (EPH.Rate * EPH.PayFrequency) < @srednia_stawka
END;
--2
CREATE FUNCTION
data_wysylki (@id INT)
RETURNS TABLE AS
RETURN SELECT SOH.ShipDate as data_wysylki FROM AdventureWorks2017.Sales.SalesOrderHeader SOH
WHERE SOH.SalesOrderID = @id;
--SELECT * FROM data_wysylki(44300)
--3
CREATE PROCEDURE
product_info (@product_name nvarchar(50))
AS
SELECT Prod.ProductID, Prod.ProductNumber, Prod.SellEndDate FROM AdventureWorks2017.Production.Product Prod
WHERE Prod.Name = @product_name;
--EXEC product_info @product_name='Adjustable Race'
--4
CREATE FUNCTION
card_num (@id  INT)
RETURNS TABLE AS
RETURN (SELECT SOH.SalesOrderID, CC.CardNumber FROM AdventureWorks2017.Sales.SalesOrderHeader SOH
JOIN AdventureWorks2017.Sales.CreditCard CC
ON CC.CreditCardID = SOH.CreditCardID
WHERE SOH.SalesOrderID = @id);
--SELECT * FROM numer_karty(44300)
--5
CREATE PROCEDURE
dzielenie (@num1 float, @num2 float)
AS
BEGIN
IF @num1 > @num2 AND @num2 !=0
	SELECT @num1/@num2 AS Wynik_dzielenia
ELSE
	PRINT 'Niewłaściwie zdefiniowałeś dane wejściowe'
END;
--EXEC dzielenie @num1=10,@num2=5
--EXEC dzielenie @num1=5,@num2=10
--EXEC dzielenie @num1=5,@num2=0