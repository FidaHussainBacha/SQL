use assignment_work;
-- __________________________________

select* from petowners;
select * from pets;
select * from proceduresdetails;
select* from procedureshistory;
-- ____________________________________

-- 1) List the names of all pet owners along with the names of their pets.
select* from petowners as po ;
select * from pets as p;
select po.ownerid ,po.name as owner_name,  p.name as pet_name , p.kind as pet_kind
from petowners  po
join pets p on po.OwnerID = p.OwnerID;
-- _____________________________________
-- 2)List all pets and their owner names, including pets that don't have recorded  owners.  
select* from petowners as po ;
select * from pets as p;
select p.petid , p.name as pet_name ,po.name as owner_name , po.Surname
from pets p 
left join PetOwners po ON p.OwnerID = po.OwnerID;
-- _______________________________________
-- 3)Combine the information of pets and their owners, including those pets  without owners and owners without pets. 
select* from petowners as po ;
select * from pets as p;
SELECT p.PetID, p.Name, p.Kind, p.Gender, p.Age, po.OwnerID, po.Name as OwnerName, po.Surname
FROM Pets p
LEFT JOIN PetOwners po ON p.OwnerID = po.OwnerID
UNION
SELECT NULL, NULL, NULL, NULL, NULL, po.OwnerID, po.Name, po.Surname
FROM PetOwners po
LEFT JOIN Pets p ON p.OwnerID = po.OwnerID
WHERE p.PetID IS NULL;
-- _________________________________________
-- 4)Find the names of pets along with their owners' names and the details of the  procedures they have undergone.
select* from petowners as po ;
select * from pets as p;
select * from procedureshistory as ph;
select * from proceduresdetails AS pd;

SELECT p.Name AS PetName, po.Name AS OwnerName, ph.Date, pd.Description
FROM Pets p
JOIN PetOwners po ON p.OwnerID = po.OwnerID
JOIN ProceduresHistory ph ON p.PetID = ph.PetID
JOIN ProceduresDetails pd ON ph.ProcedureType = pd.ProcedureType AND ph.ProcedureSubCode = pd.ProcedureSubCode;
-- __________________________________________
-- 5)List all pet owners and the number of dogs they own.  
SELECT po.Name, po.Surname, COUNT(p.PetID) AS NumberOfDogs
FROM PetOwners po
JOIN Pets p ON po.OwnerID = p.OwnerID
WHERE p.Kind = 'Dog'
GROUP BY po.OwnerID, po.Name, po.Surname;
-- _____________________________________________
-- 6) Identify pets that have not had any procedures.  
SELECT p.PetID, p.Name
FROM Pets p
LEFT JOIN ProceduresHistory ph ON p.PetID = ph.PetID
WHERE ph.PetID IS NULL;
-- ____________________________________________
-- 7)Find the name of the oldest pet.  
SELECT p.Name , p.kind, p.age
FROM Pets p
WHERE p.Age = (SELECT MAX(Age) FROM Pets);
-- ___________________________________________
-- 8)List all pets who had procedures that cost more than the average cost of all  procedures.  
SELECT DISTINCT ph.PetID, p.Name
FROM ProceduresHistory ph
JOIN Pets p ON ph.PetID = p.PetID
JOIN ProceduresDetails pd ON ph.ProcedureType = pd.ProcedureType AND ph.ProcedureSubCode = pd.ProcedureSubCode
WHERE pd.Price > (SELECT AVG(Price) FROM ProceduresDetails);
-- ____________________________________________
-- 9)Find the details of procedures performed on 'Cuddles'.  
SELECT ph.Date, pd.Description, pd.Price, p.name,p.kind
FROM ProceduresHistory ph
JOIN Pets p ON ph.PetID = p.PetID
JOIN ProceduresDetails pd ON ph.ProcedureType = pd.ProcedureType AND ph.ProcedureSubCode = pd.ProcedureSubCode
WHERE p.Name = 'Cuddles';
-- _____________________________________________
-- 10)Create a list of pet owners along with the total cost they have spent on  procedures and display only those who have spent above the average  spending.  
SELECT po.Name, po.Surname, SUM(pd.Price) AS TotalSpent
FROM PetOwners po
JOIN Pets p ON po.OwnerID = p.OwnerID
JOIN ProceduresHistory ph ON p.PetID = ph.PetID
JOIN ProceduresDetails pd ON ph.ProcedureType = pd.ProcedureType AND ph.ProcedureSubCode = pd.ProcedureSubCode
GROUP BY po.OwnerID, po.Name, po.Surname
HAVING SUM(pd.Price) > (
SELECT AVG(TotalSpent)
FROM (
SELECT po.OwnerID, SUM(pd.Price) AS TotalSpent
FROM PetOwners po
JOIN Pets p ON po.OwnerID = p.OwnerID
JOIN ProceduresHistory ph ON p.PetID = ph.PetID
JOIN ProceduresDetails pd ON ph.ProcedureType = pd.ProcedureType AND ph.ProcedureSubCode = pd.ProcedureSubCode
GROUP BY po.OwnerID
) x
);
-- ____________________________________________
-- 11)List the pets who have undergone a procedure called 'VACCINATIONS'.
select * from pets as p ;
select * from procedureshistory as ph;
SELECT p.Name , p.kind, p.age , ph.proceduresubcode ,ph.Proceduretype
FROM Pets p
join procedureshistory ph on p.PetID = ph.PetID
WHERE ph.ProcedureType ="vaccinations";
-- ____________________________________________
-- 12) Find the owners of pets who have had a procedure called 'EMERGENCY'
select * from petowners as po;
select* from proceduresdetails as pd;
select po.ownerid , po.name as owner_name
from petowners po 
JOIN Pets p ON po.OwnerID = p.OwnerID
JOIN ProceduresHistory ph ON p.PetID = ph.PetID
JOIN ProceduresDetails pd ON ph.ProcedureType = pd.ProcedureType AND ph.ProcedureSubCode = pd.ProcedureSubCode
WHERE pd.Description = 'EMERGENCY';
-- _________________________________________
-- 13)Calculate the total cost spent by each pet owner on procedures.  
SELECT po.Name, po.Surname, SUM(pd.Price) AS TotalCost
FROM PetOwners po
JOIN Pets p ON po.OwnerID = p.OwnerID
JOIN ProceduresHistory ph ON p.PetID = ph.PetID
JOIN ProceduresDetails pd ON ph.ProcedureType = pd.ProcedureType AND ph.ProcedureSubCode = pd.ProcedureSubCode
GROUP BY po.Name, po.Surname;
-- _______________________________________
-- 14)Count the number of pets of each kind.  
select * from pets ;
SELECT  Kind, COUNT(PetID) AS Count
FROM Pets
group by kind;
-- ________________________________________
-- 15)Group pets by their kind and gender and count the number of pets in each  group.  
select * from pets ;
select gender,kind, COUNT(PetID) AS Count
from pets
group by gender , kind ;
-- ______________________________________
-- 16)Show the average age of pets for each kind, but only for kinds that have more  than 5 pets. 
SELECT Kind, round(AVG(Age),2)AS AverageAge
FROM Pets
GROUP BY Kind
HAVING COUNT(PetID) > 5;
-- _______________________________________
-- 17).Find the types of procedures that have an average cost greater than $50.
SELECT ProcedureType, AVG(Price) AS AveragePrice
FROM ProceduresDetails
GROUP BY ProcedureType
HAVING AVG(Price) > 50;
-- _________________________________________
-- 18).Classify pets as 'Young', 'Adult', or 'Senior' based on their age. Age less then  3 Young, Age between 3and 8 Adult, else Senior.  
SELECT
Name,
CASE
WHEN Age < 3 THEN 'Young'
WHEN Age BETWEEN 3 AND 8 THEN 'Adult'
ELSE 'Senior'
END AS AgeGroup
FROM Pets;
-- __________________________________________
-- 19)
SELECT po.Name,po.Surname,SUM(pd.Price) AS TotalSpending,
CASE
WHEN SUM(pd.Price) < 100 THEN 'Low Spender'
WHEN SUM(pd.Price) BETWEEN 100 AND 500 THEN 'Moderate Spender'
ELSE 'High Spender'
END AS SpendingCategory
FROM PetOwners po
JOIN Pets p ON po.OwnerID = p.OwnerID
JOIN ProceduresHistory ph ON p.PetID = ph.PetID
JOIN ProceduresDetails pd ON ph.ProcedureType = pd.ProcedureType
AND ph.ProcedureSubCode = pd.ProcedureSubCode
GROUP BY po.Name, po.Surname;
-- ______________________________________________
-- 20)Show the gender of pets with a custom label ('Boy' for male, 'Girl' for female).
SELECT
Name,
CASE WHEN Gender = 'Male' THEN 'Boy'
WHEN Gender = 'Female' THEN 'Girl'
END AS PetGender
FROM Pets;
-- ______________________________________________
-- 21)
SELECT
p.Name,
COUNT(ph.Proceduretype) AS NumProcedures,
CASE
WHEN COUNT(ph.Proceduretype) BETWEEN 1 AND 3 THEN 'Regular'
WHEN COUNT(ph.Proceduretype) BETWEEN 4 AND 7 THEN 'Frequent'
ELSE 'Super User'
END AS Status
FROM Pets p
LEFT JOIN ProceduresHistory ph ON p.PetID = ph.PetID
GROUP BY p.Name;
-- _____________________________________________
-- 22)Rank pets by age within each kind.  
SELECT p.Kind, p.Name, p.Age,
DENSE_RANK() OVER(PARTITION BY p.Kind ORDER BY p.Age DESC) AS AgeRank
FROM Pets p;
-- ________________________________________________
-- 23)Assign a dense rank to pets based on their age, regardless of kind.  
SELECT p.Name, p.Age,
DENSE_RANK() OVER(ORDER BY p.Age DESC) AS AgeOverallRank
FROM Pets p;
-- _______________________________________________
-- 24) For each pet, show the name of the next and previous pet in alphabetical order.
SELECT p.Name,p.kind,
LEAD(p.Name) OVER(ORDER BY p.Name) AS NextPet,
LAG(p.Name) OVER(ORDER BY p.Name) AS PreviousPet
FROM Pets p
ORDER BY p.Name,p.kind;
-- ______________________________________________
-- 25)Show the average age of pets, partitioned by their kind.  
SELECT Kind, AVG(Age) OVER(PARTITION BY Kind) AS AvgAge
FROM Pets;
-- __________________________________________________
-- 26)Create a CTE that lists all pets, then select pets older than 5 years from the  CTE. 
WITH all_pets AS (
SELECT * FROM Pets
)

SELECT *
FROM all_pets
WHERE Age > 5;
-- ________________________________________________











 
