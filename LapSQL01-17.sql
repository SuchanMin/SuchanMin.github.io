select * from Employees
select EmployeeID , FirstName , LastName From Employees
select * from Employees where City = 'London'
select EmployeeID , FirstName, Lastname from Employees where City = 'London'
select City , Country from Customers
select distinct City , Country from Customers
select * from Products where Unitprice >200
SELECT * FROM Customers WHERE City ='London' OR City ='Vancouver'
SELECT * FROM Products WHERE UnitPrice >= 50 AND UnitsInStock < 20


---ข้อมูลสินค้าที่มีจำนวนคงเหลือต่ำกว่า 20 หรือ จำนวนคงเหลือน้อยกว่าระดับการสั่งซื้อ 
SELECT * from Products
Where UnitsInstock< 20 or UnitsInStock <= ReorderLevel 


SELECT * FROM Products WHERE UnitPrice BETWEEN 50 AND 100
SELECT * FROM Products WHERE UnitPrice >= 50 AND UnitPrice<=100

SELECT * FROM Customers WHERE Country IN ('Brazil','Argentina','Mexico');
SELECT * FROM Customers WHERE Country = 'Brazil' or Country = 'Argentina' or Country = 'Mexico'

SELECT * FROM Employees WHERE FirstName LIKE 'N%'

---- ต้องการข้อมูลลูกค้าที่ชึ้นต้นด้วย A ---------
SELECT * from Customers
where CompanyName like 'A%'
 ----- ต้องการข้อมูลลูกค้าที่มีชื่อลงม้ายด้วย Y -----------
 SELECT * from Customers
 where CompanyName LIKE '%Y'

 -----ต้องการชื่อ นามสกุล พนักงานที่มีชื่อประกอบด้วยตัวอักษร 'an'---------------
 select firstname , lastname from Employees
 where FirstName like '%an%'

 -----ต้องการชื่อบริษัทลูกค้าที่มีตัวอักษรที 2 เป็น 'A'------

 SELECT ProductID,ProductName,UnitPrice FROM Products ORDER BY UnitPrice 

 ------ต้องการชื่อ และราคาสินค้าที่มีจำนวนในสต๊อกสูงที่สุด 10 อันดับแรก-------
 select  top 10 ProductName , Unitprice , UnitsInstock
 from Products
 order by UnitsInStock

 SELECT CategoryID, ProductName, UnitPrice
FROM Products
ORDER BY CategoryID ASC , UnitPrice DESC
