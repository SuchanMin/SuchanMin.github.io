--1.   หาตำแหน่งของ Nancy ก่อน
SELECT + from Employees
WHERE Title = (Select TRIGGER_NESTLEVEL()
from Employees
WHERE FirstName = 'nancy')
--2.ต้องการชื่อนามสกุลพนักงานที่มีอายุมากที่สุด
SELECT Firstname, lastname from Employees
WHERE BirthDate = (Select min(BirthDate)from Employees)
--ต้องการซื้อสินค้าที่มีราคามากกว่าสินค้าซื้อ Ikura 
SELECT ProductName from Products
WHERE Unitprice > (Select UnitPrice from Products
                   where ProductName = 'Ikura')
--ต้องการชื่อบริษัทลูกค้าที่อยูาเมืองเดียวกันบริษัทชื่อ Around the Horn
SELECT CompanyName from Customers
where city = (Select city from Customers
              where CompanyName='Around the Horn')
--ต้องการชื่อนามสกุลพนักงานที่เข้างานคนล่าสุด
SELECT Firstname , Lastname from Employees
where HireDate = (select max (HireDate)from Employees)
--ข้อมูลใบสั่งซื้อที่ถูกส่งไปประเทศที่ไม่มีผู้ผลิตสินค้าตั้งอยู่
SELECT * from Orders
where ShipAddress not in (Select distinct country from Suppliers)




--ต้องการข้อมูลสินค้าที่มีราคาน้อยกว่า 50$
Select ROW_NUMBER() OVER (order by unitprice) AS fromName,
productName , UnitPrice
from Products
where UnitPrice < 50
-- คำสั่ง DML (Insert Update Delete)
Select * from Shippers
--ตาราง มี PK เป็น AutoIncrement (AutoNumber )
Insent into Shippers
VALUES (' บริษัทชนเยอะจำกัด',' 081-1234567')
Select * from Shippers (CompanyName)
values (' บริษัทชนมหาศาลจำกัด')

Select * from Customers
-- ตารางที่มี PK เป็น Char, nChar
insert into customers (CustomerID, CompanyName)
VALUES ('A0001', ' บริษัทซื้อเยอะจำกัด')

--จลเพิ่มข้อมูลพนักงาน 1 คน (ใส่ข้อมูลเท่าที่มี)
Insert into Employees(FirstName,LastName)
VALUES ('วุ่นเส้น','ชิงช้า')

--จงเพิ่มสินค้า ปลาแดกบอง ราคา 1.5$ จำนวน 12
INSERT into Products(ProductName,UnitPrice,UnitsInStock)
VALUES ('ปลาแดกบอง',1.5,12)

--ปรับปรุงเบอร์โทรศัพท์ ของบริษัทขนว่ง รหัส 6 
UPDATE Shippers
set Phone = '089-99998989'
where ShipperID = 5
select * from shippers 

--ปรับปรุงจำนวนสินค้าคงเหลือสินค้ารหัส 1 เพิ่มจำนวนเช้าไป 300 ชิ้น
๊UPDATE Products
set UnitsINStock = UnitsInStock + 100
where ProductID = 1
--ปรับปรุง เมือง ปละปรพเทศลูกค้า รหัส A0001 ให้เป็น อุดรธานี , Thailand
UPDATE Customers
set City = ' อุดรธานี' , Country = ' Thailand'
where CustomerID = ' A0001'

-- คำสั่ง Delete
---ลบบริษัทขนส่งสินค้า รหัส  6
DELETE from Shippers 
where ShipperID = 6 

Select * from ORDERS
