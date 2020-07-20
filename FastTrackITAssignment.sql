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
				WHEN emp.EmployeeId is null THEN 0 ELSE 1 
			END AS IsEmployed
FROM		Person pers 
LEFT JOIN	Employee emp ON pers.PersonId=emp.EmployeeId
ORDER BY	LastName, FirstName;

-- Requirement 7


