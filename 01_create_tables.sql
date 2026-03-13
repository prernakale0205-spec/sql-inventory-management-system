 CREATE TABLE Supplier (
    sid CHAR(10) PRIMARY KEY,
    sname VARCHAR(100) NOT NULL,
    saddr VARCHAR(200) NOT NULL,
    scity VARCHAR(50) DEFAULT 'Delhi',
    sphone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Product (
    pid CHAR(10) PRIMARY KEY,
    pdesc VARCHAR(200) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    category VARCHAR(5) CHECK (category IN ('IT','HA','HC')),
    sid CHAR(10),
    FOREIGN KEY (sid) REFERENCES Supplier(sid)
);

CREATE TABLE CUST (
    cid CHAR(10) PRIMARY KEY,
    cname VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    dob DATE CHECK (dob < '2000-01-01')
);

CREATE TABLE Orders (
    oid CHAR(10) PRIMARY KEY,
    odate DATE,
    pid CHAR(10),
    cid CHAR(10),
    oqty INT CHECK (oqty >= 1),
    FOREIGN KEY (pid) REFERENCES Product(pid),
    FOREIGN KEY (cid) REFERENCES Cust(cid)
);
CREATE TABLE Stock (
    pid CHAR(10) PRIMARY KEY,
    sqty INT CHECK (sqty >= 0),
    rol INT CHECK (rol > 0),
    moq INT CHECK (moq >= 5),
    FOREIGN KEY (pid) REFERENCES Product(pid)
);
