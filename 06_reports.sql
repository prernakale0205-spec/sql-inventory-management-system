CREATE PROCEDURE DailyReport
AS
BEGIN

SELECT 
O.oid,
O.odate,
C.cname,
O.oqty,
p.pid,
P.price,
(O.oqty * P.price) AS TotalAmount
FROM Orders O
JOIN Cust C ON O.cid = C.cid
JOIN Product P ON O.pid = P.pid
WHERE CAST(O.odate AS DATE) = CAST(GETDATE() AS DATE)

END

CREATE PROCEDURE Bill
@OrderNo CHAR(10)
AS
BEGIN

SELECT 
O.oid,
O.odate,
C.cname,
P.pid,
O.oqty,
P.price,
(O.oqty * P.price) AS TotalAmount
FROM Orders O
JOIN Cust C ON O.cid = C.cid
JOIN Product P ON O.pid = P.pid
WHERE O.oid = @OrderNo

END

CREATE PROCEDURE CustomerLedger
@CustomerID CHAR(10)
AS
BEGIN

SELECT 
O.oid,
O.odate,
P.pid, 
O.oqty,
P.price,
C.cid,
(O.oqty * P.price) AS Amount
FROM Orders O
JOIN Product P ON O.pid = P.pid
JOIN CUST C on O.cid=C.cid
WHERE O.cid = @CustomerID
ORDER BY O.odate

END

CREATE PROCEDURE SupplierReport
@SupplierID CHAR(10)
AS
BEGIN

SELECT 
P.pid,
P.pdesc,
P.price,
S.sname
FROM Product P
JOIN Supplier S ON P.sid = S.sid
WHERE P.sid = @SupplierID

END
