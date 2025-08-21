---แสดงชื่อประเภทสินค้า ชื่อสินค้า และ ราคาสินค้า-------
Select CategoryName ,ProductName ,UnitPrice 
From Products as p , Categories as c
Where P .CategoryID = C.CagetgoryID
and CategoryName = 'seafood'


Select CompanyName = OrderId
From Orders , Shippers
Where Shippers.ShipperID = Orders.Shipvia