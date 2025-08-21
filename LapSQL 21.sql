---แสดงชื่อประเภทสินค้า ชื่อสินค้า และ ราคาสินค้า-------
Select CategoryName ,ProductName ,UnitPrice 
From Products as p , Categories as c
Where P .CategoryID = C.CagetgoryID
and CategoryName = 'seafood'

Select CategoryName , ProductName , UnitPrice 
From Products Join Categorics
On P.CategoryID = C.CagetgoryID

Select CompanyName = OrderId
From Orders , Shippers
Where Shippers.ShipperID = Orders.Shipvia

select * from Orders where orderID = 10250
select * from [order Detaills ] where orderIdv= 10250
-----รหัสสินค้า ชื่อสินค้า ประเทศ -----------
select P.ProductID, p.ProductName , S.ComanyName , S.Contry
from products p join Suppliers s on p.SupplierID = S.SuoolierID

------รหัสพนักงาน ชื่อพนักงงาน รหัสใบสินค้าที่เกี่ยวข้อง เรียงตามลำดับรหัวสินค้า -------------
select  EmployeeID , Firstname ,o.orderID
From EmployeeID 
-----รหัสสินค้า ชื่อสินค้า เมือง และประเเทศของบริษัทผู้หน่าย-----------
select o.orderID , c.companyName , e.firstName , o.oShipAddress 
from Orders O join Customers C on o.CustomeriD = c.CustomeriD 
join Employees E on O.EmployeeID = E.EmployeeID 


------ชื่อบริษัทขนส่ง และจำนวนใบสั่งซื้อที่เกี่ยวข้อง ------------------
select s.companyName,count(*) จำนวนorders
from Shippers s join orders o on s.ShipperID = Shipvia
group by s.CompanyName 
order by 2 desc
------รหัสสินค้า ชื่อสินค้า และจำนวนทั้งหมดที่ขายได้ ------------
select p.productID, p.productName,sum(Quantitl ) จำนวนที่ขายได้
from products p join[order Details ] od on p.productID = od.ProductID 
group by p.productiD , p.ProductName 

-------รหัสสินค้า ชื่อสินค้า ที่ nancy ขายได้ ทั้งหมด เรียงตามรหัสสินค้า------------------
select p.ProductID, P.productName 
from Employees e join orders o on e.EmployeeID  = o.EmployeeID 
                 join [order Details ] od on o.orderID  = od.orderID
                 join Products p on p.ProductID = od.ProductID
where e.FirstName = 'Nancy'
order by productID 