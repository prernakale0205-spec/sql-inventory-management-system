CREATE TRIGGER trg_Insert_Order
ON Orders
AFTER INSERT
AS
BEGIN

DECLARE @PID CHAR(10)
DECLARE @QTY INT
DECLARE @STOCK INT

SELECT @PID = pid, @QTY = oqty
FROM inserted

SELECT @STOCK = sqty
FROM Stock
WHERE pid = @PID

IF @STOCK < @QTY
BEGIN
    PRINT 'Order cannot be accepted. Insufficient stock'
    ROLLBACK TRANSACTION
END

ELSE
BEGIN
    UPDATE Stock
    SET sqty = sqty - @QTY
    WHERE pid = @PID
END

END


CREATE TRIGGER trg_Update_Order
ON Orders
AFTER UPDATE
AS
BEGIN

DECLARE @OLDQTY INT
DECLARE @NEWQTY INT
DECLARE @PID CHAR(10)
DECLARE @STOCK INT
DECLARE @DIFF INT

SELECT @OLDQTY = oqty, @PID = pid
FROM deleted

SELECT @NEWQTY = oqty
FROM inserted

SET @DIFF = @NEWQTY - @OLDQTY

SELECT @STOCK = sqty
FROM Stock
WHERE pid = @PID

IF @STOCK < @DIFF
BEGIN
    PRINT 'Not enough stock for updated order'
    ROLLBACK TRANSACTION
END

ELSE
BEGIN
    UPDATE Stock
    SET sqty = sqty - @DIFF
    WHERE pid = @PID
END

END

CREATE TRIGGER trg_Purchase_Order
ON Stock
AFTER UPDATE
AS
BEGIN

INSERT INTO Purchase(pid,sid,pqty,dop)

SELECT 
P.pid,
P.sid,
S.moq,
GETDATE()

FROM Product P
JOIN Stock S
ON P.pid = S.pid

WHERE S.sqty < S.rol

END
