
--1.สินค้าที่มีราคา 15 บาท
SELECT*FROM Products WHERE UnitPrice =15
--2.สินค้าที่มีจำนวนคงเหลือในสต๊อกต่ำกว่า 250
select*from  Products where UnitsInStock <250
--3.รหัสสินค้า ชื่อสินค้า ราคา ของสินค้าทีมีราคามากกว่า 100
SELECT ProductID, ProductName  from Products where Discontinued  =1
--4.รหัสสินค้า ชื่อสินค้า ราคา ของสินค้าที่มีราคามากกว่า 100
SELECT ProductID,Productname, UnitPrice from Products where Discontinued=1
--5.รหัสสินค้า และราคาของยางลบ
SELECT ProductId , ProductName , UnitPrice from  Products where UnitPrice > 100
--6.หมายเลขใบเสร็จ วันที่ และ ราคารวม ของใบเสร็จที่ออกก่อนวันที่ 15 ก.พ.
SELECT ReceiptID ,ReceiptDate , TotalCash from Receipts 
where ReceiptDate < '2013-02-15'
--7.รหัสสินค้า ชื่อสินค้า ที่มีจำนวนคงเหลือตั้งแต่ 400 ขึ้นไป
SELECT ProductID, ProductName FROM Products WHERE UnitsInStock >= 400;
--8.รหัสสินค้า ชื่อสินค้า ราคา และ จำนวนคงเหลือ ของแชมพูมแป้งเด็ก ม ดินสอมยางลบ
SELECT ProductID, ProductName, UnitPrice,UnitsInStock
FROM Products
WHERE ProductName in ('แชมพู','แป้งเด็ก','ดินสอ','ยางลบ');
-- 9. รายละเอียดของสินค้าประเภทเครื่องเขียน
SELECT [Description] from Categories where CategoryName = 'เครื่องเขียน'
-- 10. รหัสประเภทสินค้า ชื่อประเภท และรายละเอียดของ สินค้าประเภทเครื่องสำอาง
SELECT  CategoryID , CategoryName,[Description] from Categories
where CategoryName = 'เครื่องสำอาง'
-- 11.คำนำหน้า ชื่อ นามสกุล ของพนักงานที่เป็น Sale Representative
SELECT Title ,FirstName ,LastName from Employees where [Position] ='Sale Representative';
-- 12. รหัสพนักงาน ชื่อพนักงาน ชื่อผู้ใช้ รหัสผ่าน ของพนักงานทุกคน
SELECT EmployeeID, FirstName, UserName, Password
FROM Employees;
-- 13. ชื่อผู้ใช้ และรหัสผ่านของพนักงานที่ชื่อก้องนิรันดร์
SELECT UserName, Password FROM Employees WHERE FirstName = 'ก้องนิรันดร์';
-- 14. รหัสพนักงานที่ออกใบเสร็จหมายเลข 3
SELECT EmployeeID from Receipts where ReceiptID = 3
-- 15. รหัสสินค้า ชื่อสินค้า ราคา ของสินค้าที่มีรหัสประเภท 2, 4
SELECT productID , ProductName,UnitPrice from Products where CategoryID in (2,4)
