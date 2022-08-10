--6. Write a trigger for the Product table to ensure the list price can never be raised 
--	more than 15 Percent in a single change. Modify the above trigger to execute its 
--	check code only if the ListPrice column is updated


-- Creating trigger
CREATE TRIGGER [Production].[trgLimitPriceChanges]
ON [Production].[Product]
FOR UPDATE
AS
IF EXISTS(
		SELECT * 
		FROM inserted i
			 JOIN 
			deleted d
		ON i.ProductID = d.ProductID
		WHERE i.ListPrice > (d.ListPrice*1.15)
		)
BEGIN
	RAISERROR('Price increased cannot be more than 15 percent HENCE transaction failed',16,1)
	ROLLBACK TRAN
END
GO



-- updating trigger
ALTER TRIGGER [Production].[trgLimitPriceChanges]
ON [Production].[Product]
FOR UPDATE
AS
IF UPDATE(ListPrice)
BEGIN
	IF EXISTS(
			SELECT *
			FROM inserted i 
				JOIN
				deleted d
				ON i.ProductID = d.ProductID
				WHERE i.ListPrice > (d.ListPrice*1.15)
			)
	BEGIN
		RAISERROR('Price increased cannot be more than 15 percent HENCE transaction failed',16,1)
		ROLLBACK TRAN
	END
END
GO




--Testing trigger
update Production.Product
set ListPrice = 500
where ProductID =936;

update Production.Product
set ListPrice = 64
where ProductID =936;

update Production.Product
set ListPrice = 62.09          --original value of list price
where ProductID =936;
