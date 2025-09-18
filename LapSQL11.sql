-- 1.   จงแสดงให้เห็นว่าพนักงานแต่ละคนขายสินค้าประเภท Beverage ได้เป็นจำนวนเท่าใด และเป็นจำนวนกี่ชิ้น เฉพาะครึ่งปีแรกของ 2540(ทศนิยม 4 ตำแหน่ง)
SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    SUM(od.Quantity) AS TotalQuantity,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 4) AS TotalSales
    FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages'
  AND o.OrderDate BETWEEN '1997-01-01' AND '1997-06-30'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY e.EmployeeID
-- 2.   จงแสดงชื่อบริษัทตัวแทนจำหน่าย  เบอร์โทร เบอร์แฟกซ์ ชื่อผู้ติดต่อ จำนวนชนิดสินค้าประเภท Beverage ที่จำหน่าย โดยแสดงจำนวนสินค้า จากมากไปน้อย 3 อันดับแรก
SELECT TOP 3
    s.SupplierID,
    s.CompanyName AS SupplierName,
    s.ContactName,
    s.Phone,
    s.Fax,
    COUNT(DISTINCT p.ProductID) AS NumBeverageProducts
FROM Suppliers s
JOIN Products p ON p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages'
GROUP BY s.SupplierID, s.CompanyName, s.ContactName, s.Phone, s.Fax
ORDER BY NumBeverageProducts DESC;

-- 3.   จงแสดงข้อมูลชื่อลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ ของลูกค้าที่ซื้อของในเดือน สิงหาคม 2539 ยอดรวมของการซื้อโดยแสดงเฉพาะ ลูกค้าที่ไม่มีเบอร์แฟกซ์
SELECT
    c.CustomerID,
    c.CompanyName,
    c.ContactName,
    c.Phone,
    CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS TotalPurchase
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE o.OrderDate >= '1996-08-01' AND o.OrderDate < '1996-09-01'
  AND (c.Fax IS NULL OR LTRIM(RTRIM(c.Fax)) = '')
GROUP BY c.CustomerID, c.CompanyName, c.ContactName, c.Phone
HAVING SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) > 0;

-- 4.   แสดงรหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ทั้งหมดในปี 2541 ยอดเงินรวมที่ขายได้ทั้งหมดโดยเรียงลำดับตาม จำนวนที่ขายได้เรียงจากน้อยไปมาก พรอ้มทั้งใส่ลำดับที่ ให้กับรายการแต่ละรายการด้วย
WITH ProdSales AS (
  SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQty,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
  FROM Products p
  JOIN [Order Details] od ON od.ProductID = p.ProductID
  JOIN Orders o ON o.OrderID = od.OrderID
  WHERE o.OrderDate >= '1998-01-01' AND o.OrderDate < '1999-01-01'
  GROUP BY p.ProductID, p.ProductName
)
SELECT
  ROW_NUMBER() OVER (ORDER BY TotalQty ASC) AS RankNo,
  ProductID,
  ProductName,
  TotalQty,
  CAST(TotalAmount AS DECIMAL(18,2)) AS TotalAmount
FROM ProdSales
ORDER BY TotalQty ASC;

-- 5.   จงแสดงข้อมูลของสินค้าที่ขายในเดือนมกราคม 2540 เรียงตามลำดับจากมากไปน้อย 5 อันดับใส่ลำดับด้วย รวมถึงราคาเฉลี่ยที่ขายให้ลูกค้าทั้งหมดด้วย
SELECT TOP 5
  ROW_NUMBER() OVER (ORDER BY SUM(od.Quantity) DESC) AS RankNo,
  p.ProductID,
  p.ProductName,
  SUM(od.Quantity) AS TotalQty,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS TotalSales,
  CAST(AVG(od.UnitPrice) AS DECIMAL(18,4)) AS AvgUnitPrice
FROM Products p
JOIN [Order Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
WHERE o.OrderDate >= '1997-01-01' AND o.OrderDate < '1997-02-01'
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQty DESC;

-- 6.   จงแสดงชื่อพนักงาน จำนวนใบสั่งซื้อ ยอดเงินรวมทั้งหมด ที่พนักงานแต่ละคนขายได้ ในเดือน ธันวาคม 2539 โดยแสดงเพียง 5 อันดับที่มากที่สุด
SELECT TOP 5
  e.EmployeeID,
  (e.FirstName + ' ' + e.LastName) AS EmployeeFullName,
  COUNT(DISTINCT o.OrderID) AS NumOrders,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS TotalSales
FROM Employees e
JOIN Orders o ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE o.OrderDate >= '1996-12-01' AND o.OrderDate < '1997-01-01'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;

-- 7.   จงแสดงรหัสสินค้า ชื่อสินค้า ชื่อประเภทสินค้า ที่มียอดขาย สูงสุด 10 อันดับแรก ในเดือน ธันวาคม 2539 โดยแสดงยอดขาย และจำนวนที่ขายด้วย
SELECT TOP 10
  p.ProductID,
  p.ProductName,
  c.CategoryName,
  SUM(od.Quantity) AS TotalQty,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS TotalSales
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN [Order Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
WHERE o.OrderDate >= '1996-12-01' AND o.OrderDate < '1997-01-01'
GROUP BY p.ProductID, p.ProductName, c.CategoryName
ORDER BY TotalSales DESC;

-- 8.   จงแสดงหมายเลขใบสั่งซื้อ ชื่อบริษัทลูกค้า ที่อยู่ เมืองประเทศของลูกค้า ชื่อเต็มพนักงานผู้รับผิดชอบ ยอดรวมในแต่ละใบสั่งซื้อ จำนวนรายการสินค้าในใบสั่งซื้อ และเลือกแสดงเฉพาะที่จำนวนรายการในใบสั่งซื้อมากกว่า 2 รายการ
SELECT
  o.OrderID,
  c.CompanyName,
  c.Address,
  c.City,
  c.Country,
  (e.FirstName + ' ' + e.LastName) AS EmployeeFullName,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS OrderTotal,
  COUNT(od.ProductID) AS NumOrderLines
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY o.OrderID, c.CompanyName, c.Address, c.City, c.Country, e.FirstName, e.LastName
HAVING COUNT(od.ProductID) > 2
ORDER BY OrderTotal DESC;

-- 9.   จงแสดง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร เบอร์แฟกซ์ ยอดที่สั่งซื้อทั้งหมดในเดือน ธันวาคม 2539 แสดงผลเฉพาะลูกค้าที่มีเบอร์แฟกซ์
SELECT
  c.CustomerID,
  c.CompanyName,
  c.ContactName,
  c.Phone,
  c.Fax,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS TotalPurchase
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE o.OrderDate >= '1996-12-01' AND o.OrderDate < '1997-01-01'
  AND c.Fax IS NOT NULL AND LTRIM(RTRIM(c.Fax)) <> ''
GROUP BY c.CustomerID, c.CompanyName, c.ContactName, c.Phone, c.Fax
ORDER BY TotalPurchase DESC;

-- 10.  จงแสดงชื่อเต็มพนักงาน จำนวนใบสั่งซื้อที่รับผิดชอบ ยอดขายรวมทั้งหมด เฉพาะในไตรมาสสุดท้ายของปี 2539 เรียงตามลำดับ มากไปน้อยและแสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT
  e.EmployeeID,
  (e.FirstName + ' ' + e.LastName) AS EmployeeFullName,
  COUNT(DISTINCT o.OrderID) AS NumOrders,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSales_4dp
FROM Employees e
JOIN Orders o ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE o.OrderDate >= '1996-10-01' AND o.OrderDate < '1997-01-01'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales_4dp DESC;

-- 11.  จงแสดงชื่อพนักงาน และแสดงยอดขายรวมทั้งหมด ของสินค้าที่เป็นประเภท Beverage ที่ส่งไปยังประเทศ ญี่ปุ่น
SELECT
  e.EmployeeID,
  (e.FirstName + ' ' + e.LastName) AS EmployeeFullName,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS BeverageSalesToJapan
FROM Employees e
JOIN Orders o ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages'
  AND o.ShipCountry IN ('Japan', 'Japan (日本)') -- ปรับค่าตามข้อมูลจริงใน DB
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY BeverageSalesToJapan DESC;

-- 12.  แสดงรหัสบริษัทตัวแทนจำหน่าย ชื่อบริษัทตัวแทนจำหน่าย ชื่อผู้ติดต่อ เบอร์โทร ชื่อสินค้าที่ขาย เฉพาะประเภท Seafood ยอดรวมที่ขายได้แต่ละชนิด แสดงผลเป็นทศนิยม 4 ตำแหน่ง เรียงจาก มากไปน้อย 10 อันดับแรก
SELECT TOP 10
  s.SupplierID,
  s.CompanyName AS SupplierName,
  s.ContactName,
  s.Phone,
  p.ProductID,
  p.ProductName,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSales_4dp
FROM Suppliers s
JOIN Products p ON p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN [Order Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
WHERE c.CategoryName = 'Seafood'
GROUP BY s.SupplierID, s.CompanyName, s.ContactName, s.Phone, p.ProductID, p.ProductName
ORDER BY TotalSales_4dp DESC;

-- 13.  จงแสดงชื่อเต็มพนักงานทุกคน วันเกิด อายุเป็นปีและเดือน พร้อมด้วยชื่อหัวหน้า
SELECT
  e.EmployeeID,
  (e.FirstName + ' ' + e.LastName) AS EmployeeFullName,
  CONVERT(VARCHAR(10), e.BirthDate, 23) AS BirthDate_ISO,
  DATEDIFF(YEAR, e.BirthDate, GETDATE()) -
    CASE WHEN (MONTH(GETDATE()) < MONTH(e.BirthDate)) OR (MONTH(GETDATE()) = MONTH(e.BirthDate) AND DAY(GETDATE()) < DAY(e.BirthDate)) THEN 1 ELSE 0 END AS AgeYears,
  (DATEDIFF(MONTH, e.BirthDate, GETDATE()) % 12) AS AgeMonths,
  ISNULL(m.FirstName + ' ' + m.LastName, '(No Manager)') AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID
ORDER BY e.LastName, e.FirstName;

-- 14.  จงแสดงชื่อบริษัทลูกค้าที่อยู่ในประเทศ USA และแสดงยอดเงินการซื้อสินค้าแต่ละประเภทสินค้า
SELECT
  c.CustomerID,
  c.CompanyName,
  cat.CategoryName,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS TotalByCategory
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE c.Country IN ('USA', 'United States', 'U.S.A.')
GROUP BY c.CustomerID, c.CompanyName, cat.CategoryName
ORDER BY c.CompanyName, TotalByCategory DESC;

-- 15.  แสดงข้อมูลบริษัทผู้จำหน่าย ชื่อบริษัท ชื่อสินค้าที่บริษัทนั้นจำหน่าย จำนวนสินค้าทั้งหมดที่ขายได้และราคาเฉลี่ยของสินค้าที่ขายไปแต่ละรายการ แสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT
  s.SupplierID,
  s.CompanyName AS SupplierName,
  p.ProductID,
  p.ProductName,
  SUM(od.Quantity) AS TotalQuantitySold,
  CAST(AVG(od.UnitPrice) AS DECIMAL(18,4)) AS AvgSoldUnitPrice_4dp
FROM Suppliers s
JOIN Products p ON p.SupplierID = s.SupplierID
JOIN [Order Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY s.SupplierID, s.CompanyName, p.ProductID, p.ProductName
ORDER BY s.CompanyName, TotalQuantitySold DESC;

-- 16.  ต้องการชื่อบริษัทผู้ผลิต ชื่อผู้ต่อต่อ เบอร์โทร เบอร์แฟกซ์ เฉพาะผู้ผลิตที่อยู่ประเทศ ญี่ปุ่น พร้อมทั้งชื่อสินค้า และจำนวนที่ขายได้ทั้งหมด หลังจาก 1 มกราคม 2541
SELECT
  s.SupplierID,
  s.CompanyName AS SupplierName,
  s.ContactName,
  s.Phone,
  s.Fax,
  p.ProductID,
  p.ProductName,
  SUM(od.Quantity) AS TotalQtyAfter1998_01_01
FROM Suppliers s
JOIN Products p ON p.SupplierID = s.SupplierID
JOIN [Order Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
WHERE s.Country = 'Japan' AND o.OrderDate > '1998-01-01'
GROUP BY s.SupplierID, s.CompanyName, s.ContactName, s.Phone, s.Fax, p.ProductID, p.ProductName
ORDER BY TotalQtyAfter1998_01_01 DESC;

-- 17.  แสดงชื่อบริษัทขนส่งสินค้า เบอร์โทรศัพท์ จำนวนรายการสั่งซื้อที่ส่งของไปเฉพาะรายการที่ส่งไปให้ลูกค้า ประเทศ USA และ Canada แสดงค่าขนส่งโดยรวมด้วย
SELECT
  sh.ShipperID,
  sh.CompanyName AS ShipperName,
  sh.Phone,
  COUNT(o.OrderID) AS NumOrders_USA_Canada,
  CAST(SUM(o.Freight) AS DECIMAL(18,2)) AS TotalFreight
FROM Shippers sh
JOIN Orders o ON o.ShipVia = sh.ShipperID
WHERE o.ShipCountry IN ('USA','United States','Canada')
GROUP BY sh.ShipperID, sh.CompanyName, sh.Phone
ORDER BY NumOrders_USA_Canada DESC;

-- 18.  ต้องการข้อมูลรายชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ เบอร์แฟกซ์ ของลูกค้าที่ซื้อสินค้าประเภท Seafood แสดงเฉพาะลูกค้าที่มีเบอร์แฟกซ์เท่านั้น
SELECT DISTINCT
  c.CustomerID,
  c.CompanyName,
  c.ContactName,
  c.Phone,
  c.Fax
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName = 'Seafood'
  AND c.Fax IS NOT NULL AND LTRIM(RTRIM(c.Fax)) <> '';

-- 19.  จงแสดงชื่อเต็มของพนักงาน  วันเริ่มงาน (รูปแบบ 105) อายุงานเป็นปี เป็นเดือน ยอดขายรวม เฉพาะสินค้าประเภท Condiment ในปี 2540
SELECT
  e.EmployeeID,
  (e.FirstName + ' ' + e.LastName) AS EmployeeFullName,
  CONVERT(VARCHAR(10), e.HireDate, 105) AS HireDate_105,
  DATEDIFF(YEAR, e.HireDate, '1997-12-31') -
    CASE WHEN (MONTH('1997-12-31') < MONTH(e.HireDate)) OR (MONTH('1997-12-31') = MONTH(e.HireDate) AND DAY('1997-12-31') < DAY(e.HireDate)) THEN 1 ELSE 0 END AS ServiceYears,
  (DATEDIFF(MONTH, e.HireDate, '1997-12-31') % 12) AS ServiceMonths,
  CAST(ISNULL(SUM(CASE WHEN cat.CategoryName = 'Condiments' AND o.OrderDate >= '1997-01-01' AND o.OrderDate < '1998-01-01'
       THEN od.UnitPrice * od.Quantity * (1 - od.Discount) ELSE 0 END),0) AS DECIMAL(18,2)) AS CondimentsSales_1997
FROM Employees e
LEFT JOIN Orders o ON o.EmployeeID = e.EmployeeID
LEFT JOIN [Order Details] od ON od.OrderID = o.OrderID
LEFT JOIN Products p ON p.ProductID = od.ProductID
LEFT JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.HireDate
ORDER BY EmployeeFullName;

-- 20.  จงแสดงหมายเลขใบสั่งซื้อ  วันที่สั่งซื้อ(รูปแบบ 105) ยอดขายรวมทั้งหมด ในแต่ละใบสั่งซื้อ โดยแสดงเฉพาะ ใบสั่งซื้อที่มียอดจำหน่ายสูงสุด 10 อันดับแรก
SELECT TOP 10
  o.OrderID,
  CONVERT(VARCHAR(10), o.OrderDate, 105) AS OrderDate_105,
  CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,2)) AS OrderTotal
FROM Orders o
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY o.OrderID, o.OrderDate
ORDER BY OrderTotal DESC;
