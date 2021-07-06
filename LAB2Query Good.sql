USE [Lab2bDB]

--Select * from Paper
--Select * from carrier
--Select * from zone
--Select * from region
--Select * from dropsite
--Select * from route
--Select * from customer
--Select * from deliverytype
--Select * from customerPaper

--Use Lab2B.SQL to create the tables and populate them with data.

--1. Write queries to select the following information from the News2Go Database.

--a. Select the first name, last name, and city for the customer with customer ID 4. Show first name and last name as one column. 

SELECT 'First and Last Name' = FirstName + ' ' + LastName, City
FROM Customer
WHERE CustomerID = '4'

--b.*** For all carriers, select the carriers first name, last name, and the number of customers they have. 

SELECT Carrier.FirstName, Carrier.LastName, COUNT(Carrier.CarrierID)'Number Of Customers' 
FROM Carrier
LEFT OUTER JOIN Route ON Carrier.CarrierID = Route.CarrierID
RIGHT OUTER JOIN Customer ON Route.RouteID = Customer.RouteID
GROUP BY Carrier.CarrierID, Carrier.FirstName, Carrier.LastName


--c. Select the average DeliveryType Charge.

SELECT AVG(charge) AS Average
FROM DeliveryType


--d. Select the carrier first name and last name for all carriers whose prepaid tips total more than $100. 


SELECT Carrier.FirstName, Carrier.LastName, SUM(PrePaidTip) AS PrePaidTip
FROM Carrier
LEFT OUTER JOIN Route ON Carrier.CarrierID = Route.CarrierID
RIGHT OUTER JOIN Customer ON Route.RouteID = Customer.RouteID
GROUP BY Carrier.CarrierID, Carrier.FirstName, Carrier.LastName
HAVING SUM(PrePaidTip) > 100 


--e. *** Select the Description of all delivery types that have more than 10 customers.
--Selecting delivery types that have more than 10 customers



SELECT Carrier.FirstName 'CarrierFristName', Carrier.LastName 'CarrierLastName', Customer.FirstName 'CustomerFirstName ',
Customer.LastName 'CustomerLastName', Route.RouteID
FROM Carrier
LEFT OUTER JOIN Route ON Carrier.CarrierID = Route.CarrierID
LEFT OUTER JOIN Customer ON Route.RouteID = Customer.RouteID 


--f. *** Select all the carriers’ first names & last names with the first names and last names of all their customers. Include carriers that do not have any customers in your results.

-- how to connect what customer goes to what carrier


SELECT Carrier.FirstName'CarrierFirstName', Carrier.LastName 'CarrierLastName', Customer.FirstName'CustomerFirstName', Customer.LastName'CustomerLastName', Route.RouteID
FROM Carrier
LEFT OUTER JOIN Route ON Carrier.CarrierID = Route.CarrierID
LEFT OUTER JOIN Customer ON Route.RouteID = Customer.RouteID
	

--g. Select the first name and last name of all the customers whose last name starts with ‘S’. 

SELECT FirstName, LastName
FROM Customer
WHERE (LastName LIKE 'S%')


--h. Select the first name and last name of all the carriers whose first name is 3 characters long with ‘ob’ as the last 2 characters. 

SELECT FirstName, LastName
FROM Carrier
WHERE FirstName LIKE '_ob'


--i. *** Select the full names of the carriers who have no routes. count of routes per carrier, only see the carriers without routes

SELECT FirstName+' '+LastName AS CarrierName
FROM Carrier
LEFT OUTER JOIN Route ON Carrier.CarrierID = Route.CarrierID 
WHERE RouteID IS NULL


	

--j. Select the Description of the most common delivery type. You must use a subquery in your answer. 

SELECT DeliveryType.Description, COUNT(*) AS MostCommonDeliveryType
FROM DeliveryType
GROUP BY DeliveryType.Description
HAVING COUNT(*) >= ALL(
SELECT COUNT(*) FROM DeliveryType GROUP BY DeliveryType.Description)


--k. Create a view called CustomerSummary that contains CustomerID, FirstName, LastName, and the Paper Descriptions they subscribe to. Assume all customers have at least one subscription. 

GO
CREATE VIEW CustomerSummary
AS 
SELECT Customer.CustomerID, Customer.FirstName + ' '+ Customer.LastName 'FullName', Description
FROM Customer
INNER JOIN CustomerPaper ON Customer.CustomerID = CustomerPaper.CustomerID
INNER JOIN Paper ON Paper.PaperId = CustomerPaper.PaperID




--l. Using the CustomerSummary view select the Customerid, fullname, and the count of papers each customer receives.


GO
SELECT CustomerID, [FullName], COUNT(*)'NumberOfPaper'
FROM CustomerSummary
GROUP BY CustomerID, [FullName]
	

--2. Write DML statements to accomplish the following:
--a) Insert the following records into the region table given the following data:



--RegionID
--400

--RegionName
--Calmar

--SupervisorFirstName
--David

--SupervisorLastName
--Smithers

--ZoneID
--3


INSERT INTO Region(RegionID, [Name], SupervisorFirstName, SupervisorLastName, ZoneID)
VALUES ('400', 'Calmar', 'David', 'Smithers', '3')

EXEC sp_help Region
SELECT * FROM Region


--Seceond Record to add to Region:


--RegionID
--500

--RegionName
--Thorsby

--SupervisorFirstName
--Jane

--SupervisorLastName
--Jacobs

--ZoneID
--4

--The same ZoneID as the current ZoneID for RegionID 300

INSERT INTO Region(RegionID, [Name], SupervisorFirstName, SupervisorLastName, ZoneID)
VALUES ('500', 'Thorsby', 'Jane', 'Jacobs', '4')

EXEC sp_help Region
SELECT * FROM Region



--b) Change the following records given the following data:


--a. Increase the Charge of the Deliverytype that has a Description of “daily” by $0.10. 


UPDATE DeliveryType(daily)
SET Charge = Charge * 0.10


--b. Yay! Bub Slug is popular! Everyone on his route(s) has agreed to increase their prepaid tips by 10%! Update all his customers records accordingly! 



--c. Remove all carrier records for carriers that have no routes.
SELECT * FROM Route
WHERE CarrierID = 'NULL'


--** For the DML statements you must work with the data you have been given in the question.
