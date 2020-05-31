--1
D:\PgAdmin4\v4\runtime\pg_dump.exe --file "C:\\Users\\Dawid\\DOCUME~1\\dump.sql" --host "localhost" --port "5432" --username "postgres" --no-password --verbose --format=c --blobs "firma"
--2
DROP DATABASE firma;
--3
CREATE DATABASE firma;
D:\PgAdmin4\v4\runtime\pg_restore.exe --host "localhost" --port "5432" --username "postgres" --no-password --dbname "firma" --verbose "C:\\Users\\Dawid\\DOCUME~1\\dump.sql"
--7
SELECT	[LoginID]
		,[Name]
	FROM [AdventureWorks2017].[HumanResources].[Employee] E
	INNER JOIN [AdventureWorks2017].[HumanResources].[EmployeeDepartmentHistory] EDH
	ON E.BusinessEntityID = EDH.BusinessEntityID
	INNER JOIN [AdventureWorks2017].[HumanResources].[Department] D
	ON D.DepartmentID = EDH.DepartmentID
	WHERE EDH.EndDate IS NULL 



