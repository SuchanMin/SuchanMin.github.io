---แสดงชื่อประเภทสินค้า ชื่อสินค้า และ ราคาสินค้า-------
SELECT c.CategoryName, p.ProductName, p.UnitPrice
From Products AS p, Categories as c
Where CategoryName = 'seafood'

Select CategoryName, ProductName,UnitPrice
From Products as P Join Categories as C
On P.CategoryID= c.CategoryID

Select CompanyName = OrderId
From Orders , Shippers
Where Shippers.ShipperID = Orders.Shipvia

SELECT CompanyName, OrderID
FROM Orders, Shippers
WHERE Shippers.ShipperID = Orders.Shipvia
AND OrderID = 10275

SELECT CompanyName, OrderID
FROM Orders JOIN Shippers
ON Shippers.ShipperID=Orders.Shipvia
WHERE OrderID=10275

--ต้องการรหัสสินค้า ชื่อสินค้า บริษัทผู้จำหน่าย ประเทศ
SELECT p.ProductID, p.ProductName, s.CompanyName, s.Country
From products p join Suppliers s on p.SupplierID = s.SupplierID
where Country in ('usa','uk')

--ต้องการรหัสพนักงาน ชื่อพนักงาน รหัสใบสั่งชื่อที่เกี่ยวข้อง เรียงตามลำดับของพนักงาน
SELECT e.EmployeeID,FirstName, o.OrderID
from Employees e JOIN Orders o on e.EmployeeID = o.EmployeeID
ORDER BY EmployeeID



------ชื่อบริษัทขนส่ง และจำนวนใบสั่งซื้อที่เกี่ยวข้อง ------------------
select s.companyName,count(*) จำนวนorders
from Shippers s join orders o on s.ShipperID = Shipvia
group by s.CompanyName 
order by 2 desc
------รหัสสินค้า ชื่อสินค้า และจำนวนทั้งหมดที่ขายได้ ------------
select p.productID, p.productName,sum(Quantity ) จำนวนที่ขายได้
from products p join[order Details ] od on p.productID = od.ProductID 
group by p.productiD , p.ProductName 

-------รหัสสินค้า ชื่อสินค้า ที่ nancy ขายได้ ทั้งหมด เรียงตามรหัสสินค้า------------------
select p.ProductID, P.productName 
from Employees e join orders o on e.EmployeeID  = o.EmployeeID 
                 join [order Details ] od on o.orderID  = od.orderID
                 join Products p on p.ProductID = od.ProductID
where e.FirstName = 'Nancy'
order by productID 

------- ชื่อบริษัทลูกค้าชื่อ Around the Horn  ชื่อสินค้าที่มาจากประเทศอะไรบ้าง --------------
select p.ProductID, P.productName  , sum(Quantity) จำนวนซื้อ 
from customers  c join orders o on c.CustomerID =o.CustomerID 
                  join [Order Details ] od on o.OrderID = od.OrderID
                  join products p on p.ProductID = od.ProductID 
where c.CompanyName = ' around the Horn'
group by p.ProductID , p.ProductName 

-----เลขใบสินค้า ชื่อพนักงาน และยอดขายในใบสั่งซื้อ -----------------------
SELECT o.OrderID, FirstName,
       round(sum (od.Quantity* od.UnitPrice * (1-Discount)),2) TotalCash
FROM Orders o join Employees e on o.EmployeeID = e.EmployeeID
              JOIN [Order Details] od on o.OrderID = od.OrderID
GROUP BY o.OrderID, FirstName
