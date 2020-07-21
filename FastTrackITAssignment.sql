-- Requirement 1
SELECT	* FROM dbo.Person
 WHERE LOWER(SUBSTRING(FirstName, 1, 1)) = 'z';
--WHERE	LOWER(FirstName) like 'z%';

-- Requirement 2
SELECT		jud.CountyName, COUNT(oras.CityName) AS NumberOfCities 
FROM		County jud LEFT JOIN City oras ON jud.CountyId = oras.CountyId 
GROUP BY	CountyName;

-- Requirement 3
SELECT		comp.CompanyName, addr.AddressLine, addr.PostalCode 
FROM		Company comp LEFT JOIN Address addr ON comp.CompanyId = addr.AddressId 
ORDER BY	CompanyName;

-- Requirement 4
SELECT		* FROM Person 
WHERE		PersonId in 
				(SELECT EmployeeId from Employee) 
ORDER BY	LastName, FirstName;

-- Requirement 5
INSERT	INTO DepartmentNames (DepartmentName)
		VALUES ('R&D');

SELECT * FROM DepartmentNames 
WHERE	DepartmentName NOT IN (SELECT DepartmentName FROM Department);

-- Requirement 6
SELECT		pers.FirstName, pers.LastName, pers.DateOfbirth,
			CASE 
				WHEN emp.EmployeeId IS NULL THEN 0 ELSE 1 
			END AS IsEmployed
FROM		Person pers 
			LEFT JOIN Employee emp ON pers.PersonId=emp.EmployeeId
ORDER BY	LastName, FirstName;

-- Requirement 7
SELECT		emp.EmployeeId, pers.* 
FROM		Employee emp RIGHT OUTER JOIN Person pers 
			ON emp.EmployeeId=pers.PersonId 
WHERE		EmployeeId IS NULL
ORDER BY	LastName, FirstName;

-- Requirement 8
SELECT		TOP(100) addr.AddressId, comp.CompanyId, city.CityName 
FROM		Address addr 
			RIGHT OUTER JOIN Company comp ON addr.AddressId = comp.MainAddressId 
			RIGHT OUTER JOIN City city ON addr.CityId = city.CityId 
WHERE		CompanyId IS NULL
ORDER BY	CityName;

-- Requirement 9
INSERT INTO Address (CityId, AddressLine, PostalCode)
	VALUES (270, '1582 Electric Highway Drive', '94303');
GO

INSERT INTO Company(CompanyName, MainAddressId) VALUES ('Tesla INC.', 8681);

SELECT		comp.CompanyName,
			CASE
				WHEN dep.DepartmentName IS NULL THEN 'N/A' ELSE dep.DepartmentName
			END AS DepartmentName
FROM		Company comp LEFT JOIN Department dep ON comp.CompanyId = dep.CompanyId
ORDER BY	CompanyName;

-- Requirement 10
GO
CREATE OR ALTER VIEW View_All_Employees
AS
SELECT			
			emp.EmployeeId, 
			pers.FirstName, pers.LastName, pers.DateOfBirth, 
			dep.CompanyId, 
			comp.CompanyName,  
			empComp.CompanyDepartmentId, 
			depName.DepartmentName, 
			emp.BadgeCode
FROM			
			Employee emp INNER JOIN Person pers ON emp.EmployeeId=pers.PersonId
			INNER JOIN EmployeeCompanyDepartment empComp ON emp.EmployeeId=empComp.EmployeeId
			INNER JOIN CompanyDepartment dep ON empComp.CompanyDepartmentId=dep.MappingId
			INNER JOIN DepartmentNames depName ON dep.DepartmentId=depName.DepartmentId
			INNER JOIN Company comp ON dep.CompanyId=comp.CompanyId;

GO

-- Requirement 11
CREATE OR ALTER PROCEDURE SP_Select_Employees_From_Company
	@CompanyName NVARCHAR(200)
AS
	SET NOCOUNT ON;
	SELECT		
			comp.CompanyName,	
			pers.FirstName, pers.LastName, 
			depName.DepartmentName, 
			emp.BadgeCode
FROM			
			Employee emp INNER JOIN Person pers ON emp.EmployeeId=pers.PersonId
			INNER JOIN EmployeeCompanyDepartment empComp ON emp.EmployeeId=empComp.EmployeeId
			INNER JOIN CompanyDepartment dep ON empComp.CompanyDepartmentId=dep.MappingId
			INNER JOIN DepartmentNames depName ON dep.DepartmentId=depName.DepartmentId
			INNER JOIN Company comp ON dep.CompanyId=comp.CompanyId
WHERE
			LOWER(CompanyName)=LOWER(@CompanyName);
GO
