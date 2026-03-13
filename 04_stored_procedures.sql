create procedure ADDSUPPLIER
    @sname VARCHAR(100),
    @saddr VARCHAR(200),
    @scity VARCHAR(50),
    @sphone VARCHAR(15),
    @email VARCHAR(100)
    AS
BEGIN
SET NOCOUNT ON;

   DECLARE @sid char(5)
   set @sid=dbo.GENERATE_ID('S',NEXT VALUE FOR Supplier_seq)

INSERT INTO SUPPLIER
VALUES(@sid,@sname,@saddr,@scity,@sphone,@email)

PRINT 'New Supplier Added'

SELECT * 
FROM SUPPLIER
WHERE SID = @sid

END

create procedure ADDPRO
   @pdesc VARCHAR(200),
   @price DECIMAL(10,2),
   @category VARCHAR(5),
   @sid CHAR(5)
AS
BEGIN
SET NOCOUNT ON;
 DECLARE @pid as char(5)
 set @pid=dbo.GENERATE_ID('P', NEXT VALUE FOR  Product_seq)

INSERT INTO PRODUCT
VALUES(@pid,@pdesc,@price,@category,@sid)

PRINT 'NEW PRODUCT ADDED'

SELECT * FROM PRODUCT
WHERE pid=@pid
END

create procedure ADDCUST
   @cname VARCHAR(100),
   @address VARCHAR(200),
   @city VARCHAR(50),
   @phone VARCHAR(15),
   @email VARCHAR(100),
   @dob Date
   AS
   BEGIN
   SET NOCOUNT ON;
    DECLARE @cid char(5)
    set @cid=dbo.GENERATE_ID('C',NEXT VALUE FOR Customer_seq )
    INSERT INTO CUST
    VALUES(@cid,@cname,@address,@city,@phone,@email,@dob)

    SELECT * FROM CUST
    WHERE cid=@cid
    
    END

 create procedure ADDORDER
  @pid CHAR(10),
  @cid CHAR(10),
  @oqty INT

  AS
  BEGIN
  SET NOCOUNT ON;
       DECLARE @oid char(5)
       set @oid=dbo.GENERATE_ID('O', NEXT VALUE FOR Order_seq)

  INSERT INTO ORDERS(oid,odate,pid,cid,oqty)
  Values(@oid,GETDATE(),@pid,@cid,@oqty)

  SELECT * FROM ORDERS
  WHERE oid=@oid

  END
