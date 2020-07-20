﻿-- Requirement 1
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
				WHEN emp.EmployeeId is null THEN 0 ELSE 1 
			END AS IsEmployed
FROM		Person pers 
LEFT JOIN	Employee emp ON pers.PersonId=emp.EmployeeId
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
	VALUES (270, '1582 Electric Highway Drive', '94303')

INSERT INTO Company(CompanyName, MainAddressId) VALUES ('Tesla INC.', 8681);

SELECT		comp.CompanyName,
			CASE
				WHEN dep.DepartmentName IS NULL THEN 'N/A' ELSE dep.DepartmentName
			END AS DepartmentName
FROM		Company comp LEFT JOIN Department dep ON comp.CompanyId = dep.CompanyId
ORDER BY	CompanyName;
