--2. Write separate queries using 
--		a join, 
--		a subquery, 
--		a CTE, and 
--		then an EXISTS 
--	to list all AdventureWorks customers who have not placed an order.



-- Using JOIN ====
SELECT *
FROM 
Sales.Customer C
LEFT OUTER JOIN 
Sales.SalesOrderHeader S 
ON
C.CustomerID = S.CustomerID
WHERE S.SalesOrderID IS NULL
;


-- Using a Subquery ====
SELECT *
FROM Sales.Customer C
WHERE C.CustomerID NOT IN(
	SELECT S.CustomerID
	FROM Sales.SalesOrderHeader S)
;


--Using CTE =====
WITH s AS(
	SELECT CustomerID,SalesOrderID
	FROM Sales.SalesOrderHeader
)
SELECT *
FROM Sales.Customer c
LEFT OUTER JOIN s
	ON
	c.CustomerID = s.CustomerID
WHERE s.SalesOrderID is NULL
;





--Using EXISTS ====
SELECT *
FROM Sales.Customer C
WHERE NOT EXISTS(
	SELECT *
	FROM Sales.SalesOrderHeader S
	WHERE C.CustomerID = S.CustomerID)
;