--1.1 Display the number of records in the [SalesPerson] Table

SELECT COUNT([BusinessEntityID]) AS "No Of SalesPerson"
FROM [Sales].[SalesPerson];




--1.2FirstName and LastName of records from the Person table where the FirstName begins with the letter ‘B’.

SELECT [FirstName] AS 'First Name',[LastName] AS 'Last Name'
FROM [Person].[Person]
WHERE FirstName like 'b%'
ORDER BY FirstName;




--1.3 list of FirstName and LastName for employees where 
--    Title is one of Design Engineer, Tool Designer or Marketing Assistant.

SELECT p.FirstName, p.LastName, e.JobTitle
FROM Person.Person AS p
INNER JOIN HumanResources.Employee as e
	ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.JobTitle = 'Design Engineer'
   OR e.JobTitle = 'Tool Designer'
   OR e.JobTitle = 'Marketing Assistant';





--1.4 Name and Color of the Product with the maximum weight.

SELECT Name, Color, Weight
FROM [Production].[Product] 
WHERE Weight = 
	(SELECT MAX(Weight)
	FROM Production.Product)
;




--1.5 Display Description and MaxQty fields from the SpecialOffer table. 
--	Some of the MaxQty values are NULL, in this case display the value 0.00 instead.

SELECT Description, ISNULL(MaxQty,0.00) AS 'Max Quantity'
FROM [Sales].[SpecialOffer] ;






--1.6 overall Average of the [CurrencyRate].[AverageRate] values for the exchange rate ‘USD’ to ‘GBP’ for the year 2005 
--	i.e. FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’.



SELECT AVG(AverageRate) as 'Overall average in 2005'
FROM [Sales].[CurrencyRate]
WHERE YEAR(CurrencyRateDate) = 2005
	AND ToCurrencyCode = 'GBP'
;




--1.7 FirstName and LastName of records from the Person table where FirstName contains the letters ‘ss’. 
--	Display an additional column with sequential numbers for each row returned beginning at integer 1.

SELECT ROW_NUMBER() OVER (ORDER BY FirstName asc) AS RowNumber, FirstName, LastName
FROM [Person].[Person]
WHERE FirstName like '%ss%'
;




--1.8 [SalesPersonID] with an additional column entitled ‘Commission Band’ indicating the appropriate band


SELECT BusinessEntityID as SalesPersonID, CommissionPct, 
'Commision Band'= CASE
WHEN CommissionPct = 0 then 'band 0'
WHEN CommissionPct > 0 AND CommissionPct <= 0.01 THEN 'band 1'
WHEN CommissionPct > 0.01 AND CommissionPct <= 0.015 THEN 'band 2'
WHEN CommissionPct > 0.015 THEN 'band 2'
END
FROM [Sales].[SalesPerson]
;





--1.9 Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez.

DECLARE @ID int;
SELECT @ID = BusinessEntityID
FROM Person.Person AS p
WHERE FirstName = 'Ruth'
	AND LastName = 'Ellerbrock'
	AND PersonType = 'EM';

EXEC dbo.uspGetEmployeeManagers @ID;




--1.10 Display the ProductId of the product with the largest stock level


SELECT TOP 1 ProductID, dbo.ufnGetStock(ProductID) AS 'Stock'
FROM Production.Product
ORDER BY 'Stock' desc;



	

