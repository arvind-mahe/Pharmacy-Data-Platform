/*
** Group number: 35
** Team Member 1: Arvind Mahendran
** Team Member 2: Pranesh Somasundar
** Course: IFT/530
** SQL Server Version: Microsoft SQL Server 2012 (SP1) 
** History
** Date Created    Comments
** 12/06/2024      Final Project (Pharmacy Database Management System)
*/

CREATE DATABASE GroupNo35;

USE GroupNo35;

--CREATE TABLE CUSTOMER
CREATE TABLE Customer(
customerid varchar(20) PRIMARY KEY,
cpass varchar(20) DEFAULT NULL,
firstname varchar(15) NOT NULL,
lastname varchar(15) NOT NULL,
email varchar(30) DEFAULT NULL,
address varchar(150) DEFAULT NULL,
phno varchar(50) DEFAULT NULL
);

--CREATE TABLE SELLER
CREATE TABLE Seller(
sellerid varchar(15) PRIMARY KEY,
sellername varchar(20) NOT NULL,
spass varchar(20) DEFAULT NULL,
address varchar(150) DEFAULT NULL,
phno varchar(50) DEFAULT NULL
);

--CREATE TABLE PRODUCT
CREATE TABLE Product (
    productid VARCHAR(15) PRIMARY KEY,
    productname VARCHAR(20) NOT NULL UNIQUE,
    mfgdate DATE DEFAULT NULL,
    expdate DATE DEFAULT NULL,
    price money DEFAULT NULL
);

--CREATE TABLE INVENTORY
CREATE TABLE Inventory (
    productid VARCHAR(15) NOT NULL, 
    productname VARCHAR(20) NOT NULL,
    quantity INT DEFAULT NULL,
    sellerid VARCHAR(15) NOT NULL,
    PRIMARY KEY (productid, sellerid),
    FOREIGN KEY (productid) REFERENCES Product(productid),
    FOREIGN KEY (productname) REFERENCES Product(productname),
    FOREIGN KEY (sellerid) REFERENCES Seller(sellerid)
);

--CREATE TABLE ORDERS
CREATE TABLE Orders(
orderid varchar(15) PRIMARY KEY,
productid varchar(15) NOT NULL,
sellerid varchar(15) NOT NULL,
customerid varchar(20) NOT NULL,
Orderdatetime datetime DEFAULT NULL,
Quantity int DEFAULT NULL,
price money NOT NULL,
FOREIGN KEY (productid) REFERENCES product(productid),
FOREIGN KEY (sellerid) REFERENCES seller(sellerid),
FOREIGN KEY (customerid) REFERENCES customer(customerid)
);

--CREATE TABLE INSURANCE
CREATE TABLE Insurance(
insuranceid varchar(15) PRIMARY KEY,
customerid varchar(20) NOT NULL,
insuranceprovider varchar(50) NOT NULL,
policyno varchar(30) NOT NULL UNIQUE,
coverageamount money NOT NULL,
expdate date NOT NULL,
FOREIGN KEY (customerid) REFERENCES customer(customerid)
);

--DROP TABLES
DROP TABLE Insurance;
DROP TABLE Orders;
DROP TABLE Inventory;
DROP TABLE Product;
DROP TABLE Seller;
DROP TABLE Customer;

--POPULATING TABLE CUSTOMER
INSERT INTO Customer (customerid, cpass, firstname, lastname, email, address, phno)
VALUES 
('CUST001', 'pass123', 'John', 'Doe', 'john.doe@example.com', '123 Elm St, Chicago, IL', '(312) 555-1234'),
('CUST002', 'pass456', 'Jane', 'Smith', 'jane.smith@example.com', '456 Oak St, Austin, TX', '(512) 555-5678'),
('CUST003', 'pass789', 'Alice', 'Johnson', 'alice.j@example.com', '789 Maple Ave, Seattle, WA', '(206) 555-9876'),
('CUST004', 'pass234', 'Bob', 'Brown', 'bob.b@example.com', '101 Pine Rd, Denver, CO', '(303) 555-4321'),
('CUST005', 'pass678', 'Carol', 'Taylor', 'carol.t@example.com', '505 Birch Blvd, Orlando, FL', '(407) 555-6543'),
('CUST006', 'pass910', 'Diana', 'Adams', 'diana.a@example.com', '303 Willow Ln, Boston, MA', '(617) 555-7890'),
('CUST007', 'pass112', 'Frank', 'Evans', 'frank.e@example.com', '606 Cypress Ct, Phoenix, AZ', '(602) 555-1230'),
('CUST008', 'pass313', 'Grace', 'Harris', 'grace.h@example.com', '707 Aspen Pl, Atlanta, GA', '(404) 555-4320'),
('CUST009', 'pass414', 'Henry', 'White', 'henry.w@example.com', '808 Spruce Ln, Columbus, OH', '(614) 555-7891'),
('CUST010', 'pass515', 'Irene', 'Clark', 'irene.c@example.com', '909 Lake St, San Francisco, CA', '(415) 555-6540');

SELECT * FROM CUSTOMER

--POPULATING TABLE SELLER
INSERT INTO Seller (sellerid, sellername, spass, address, phno)
VALUES 
('SELL001', 'PharmaPlus', 'secure123', '123 Main St, Los Angeles, CA', '(213) 555-4321'),
('SELL002', 'HealthMart', 'safe456', '456 First Ave, Miami, FL', '(305) 555-6789'),
('SELL003', 'WellnessCo', 'lock789', '789 Market St, Philadelphia, PA', '(215) 555-9876'),
('SELL004', 'MediSupply', 'key234', '101 Broadway, New York, NY', '(212) 555-5678'),
('SELL005', 'CarePro', 'shield567', '505 High St, Portland, OR', '(503) 555-4320'),
('SELL006', 'RxDepot', 'vault890', '303 Central Rd, Dallas, TX', '(214) 555-7891'),
('SELL007', 'LifeCare', 'guard112', '707 Hilltop Blvd, Charlotte, NC', '(704) 555-6543'),
('SELL008', 'MediServe', 'secure313', '606 River Ln, Houston, TX', '(713) 555-1234'),
('SELL009', 'HealthHub', 'lock414', '808 Willow Ct, San Diego, CA', '(619) 555-9876'),
('SELL010', 'PharmaLink', 'safe515', '909 Park Ave, Boston, MA', '(617) 555-6789');

SELECT * FROM SELLER

--POPULATING TABLE PRODUCT
INSERT INTO Product (productid, productname, mfgdate, expdate, price)
VALUES 
('PROD001', 'PainRelief', '2022-01-01', '2023-09-01', 15.00),
('PROD002', 'CoughSyrup', '2022-06-15', '2023-10-01', 10.00),
('PROD003', 'VitaminC', '2023-01-01', '2025-01-01', 5.00),
('PROD004', 'Antibiotic', '2022-12-01', '2024-12-01', 20.00),
('PROD005', 'Bandages', '2023-03-01', '2026-03-01', 2.50),
('PROD006', 'PainGel', '2023-05-01', '2026-05-01', 12.00),
('PROD007', 'Thermometer', '2023-07-01', '2027-07-01', 25.00),
('PROD008', 'EyeDrops', '2022-11-01', '2024-11-01', 8.00),
('PROD009', 'HandSanitizer', '2023-04-01', '2025-04-01', 4.00),
('PROD010', 'FaceMask', '2023-02-01', '2025-02-01', 1.50);

SELECT * FROM PRODUCT

--POPULATING TABLE INVENTORY
INSERT INTO Inventory (productid, productname, quantity, sellerid)
VALUES 
('PROD001', 'PainRelief', 30, 'SELL001'),
('PROD002', 'CoughSyrup', 40, 'SELL002'),
('PROD003', 'VitaminC', 50, 'SELL003'),
('PROD004', 'Antibiotic', 20, 'SELL004'),
('PROD005', 'Bandages', 70, 'SELL005'),
('PROD006', 'PainGel', 15, 'SELL006'),
('PROD007', 'Thermometer', 25, 'SELL007'),
('PROD008', 'EyeDrops', 30, 'SELL008'),
('PROD009', 'HandSanitizer', 60, 'SELL009'),
('PROD010', 'FaceMask', 100, 'SELL010'),
('PROD003', 'VitaminC', 40, 'SELL001'),
('PROD004', 'Antibiotic', 35, 'SELL002'),
('PROD005', 'Bandages', 45, 'SELL003'),
('PROD006', 'PainGel', 20, 'SELL004'),
('PROD007', 'Thermometer', 50, 'SELL005'),
('PROD008', 'EyeDrops', 25, 'SELL006'),
('PROD009', 'HandSanitizer', 35, 'SELL007'),
('PROD010', 'FaceMask', 75, 'SELL008'),
('PROD001', 'PainRelief', 10, 'SELL009'),
('PROD002', 'CoughSyrup', 15, 'SELL010');

SELECT * FROM INVENTORY

--POPULATING TABLE ORDERS
INSERT INTO Orders (orderid, productid, sellerid, customerid, orderdatetime, quantity, price)
VALUES 
('ORD001', 'PROD001', 'SELL001', 'CUST001', '2024-09-07', 2, 15.00), 
('ORD002', 'PROD002', 'SELL002', 'CUST002', '2024-08-28', 3, 10.00), 
('ORD003', 'PROD003', 'SELL003', 'CUST003', '2024-11-06', 4, 5.00),
('ORD004', 'PROD004', 'SELL004', 'CUST004', '2024-11-21', 1, 20.00),
('ORD005', 'PROD005', 'SELL005', 'CUST005', '2024-10-07', 5, 2.50),
('ORD006', 'PROD006', 'SELL006', 'CUST006', '2024-10-22', 6, 12.00),
('ORD007', 'PROD007', 'SELL007', 'CUST007', '2024-11-11', 2, 25.00),
('ORD008', 'PROD008', 'SELL008', 'CUST008', '2024-11-16', 3, 8.00),
('ORD009', 'PROD009', 'SELL009', 'CUST009', '2024-12-01', 4, 4.00),
('ORD010', 'PROD010', 'SELL010', 'CUST010', '2024-12-05', 5, 1.50),
('ORD011', 'PROD003', 'SELL001', 'CUST001', '2024-11-21', 3, 5.00),
('ORD012', 'PROD004', 'SELL002', 'CUST002', '2024-11-16', 2, 20.00),
('ORD013', 'PROD005', 'SELL003', 'CUST003', '2024-11-11', 4, 2.50),
('ORD014', 'PROD006', 'SELL004', 'CUST004', '2024-11-06', 1, 12.00),
('ORD015', 'PROD007', 'SELL005', 'CUST005', '2024-10-31', 3, 25.00),
('ORD016', 'PROD008', 'SELL006', 'CUST006', '2024-10-22', 2, 8.00),
('ORD017', 'PROD009', 'SELL007', 'CUST007', '2024-10-07', 5, 4.00),
('ORD018', 'PROD010', 'SELL008', 'CUST008', '2024-09-27', 1, 1.50),
('ORD019', 'PROD001', 'SELL009', 'CUST009', '2024-09-17', 3, 15.00), 
('ORD020', 'PROD002', 'SELL010', 'CUST010', '2024-08-10', 2, 10.00); 

SELECT * FROM ORDERS

--POPULATING TABLE INSURANCE
INSERT INTO Insurance (insuranceid, customerid, insuranceprovider, policyno, coverageamount, expdate)
VALUES 
('INS001', 'CUST001', 'Blue Cross', 'POLICY1001', 5000, '2024-11-05'),
('INS002', 'CUST002', 'UnitedHealthcare', 'POLICY1002', 7000, '2024-09-30'),
('INS003', 'CUST003', 'Aetna', 'POLICY1003', 6000, '2024-10-01'),
('INS004', 'CUST004', 'Cigna', 'POLICY1004', 8000, '2024-08-15'),
('INS005', 'CUST005', 'Kaiser Permanente', 'POLICY1005', 7000, '2024-07-20'),
('INS006', 'CUST006', 'Humana', 'POLICY1006', 9000, '2024-10-10'),
('INS007', 'CUST007', 'HealthPartners', 'POLICY1007', 7500, '2024-09-25'),
('INS008', 'CUST008', 'Oscar Health', 'POLICY1008', 8500, '2024-11-15'),
('INS009', 'CUST009', 'Molina Healthcare', 'POLICY1009', 6500, '2024-09-05'),
('INS010', 'CUST010', 'Centene', 'POLICY1010', 6000, '2024-11-01'),
('INS011', 'CUST001', 'Blue Shield', 'POLICY1011', 7200, '2025-03-06'),
('INS012', 'CUST002', 'Bright Health', 'POLICY1012', 6800, '2025-05-01'),
('INS013', 'CUST003', 'WellCare', 'POLICY1013', 5000, '2025-02-15'),
('INS014', 'CUST004', 'Medica', 'POLICY1014', 7600, '2025-04-20'),
('INS015', 'CUST005', 'Priority Health', 'POLICY1015', 8400, '2025-07-10'),
('INS016', 'CUST006', 'Health Alliance', 'POLICY1016', 8900, '2025-08-01'),
('INS017', 'CUST007', 'Capital BlueCross', 'POLICY1017', 7900, '2025-01-30'),
('INS018', 'CUST008', 'CareSource', 'POLICY1018', 5600, '2025-03-15'),
('INS019', 'CUST009', 'AmeriHealth', 'POLICY1019', 7300, '2025-06-20'),
('INS020', 'CUST010', 'Geisinger Health Plan', 'POLICY1020', 8800, '2025-08-25');

SELECT * FROM INSURANCE

-- QUERY 1: Expired Insurances
SELECT 
    i.insuranceid,
    i.customerid,
    c.firstname + ' ' + c.lastname AS customer_name,
    i.insuranceprovider,
    i.policyno,
    i.coverageamount,
    i.expdate
FROM Insurance i
JOIN Customer c ON i.customerid = c.customerid
WHERE i.expdate < '2024-12-06';

-- VIEW: Expired Insurances
CREATE VIEW ExpiredInsurances AS
SELECT 
    i.insuranceid,
    i.customerid,
    c.firstname + ' ' + c.lastname AS customer_name,
    i.insuranceprovider,
    i.policyno,
    i.coverageamount,
    i.expdate
FROM Insurance i
JOIN Customer c ON i.customerid = c.customerid
WHERE i.expdate < '2024-12-06';

--QUERY 2: Orders with Expired Products
SELECT 
    o.orderid,
    c.customerid,
    c.firstname + ' ' + c.lastname AS customer_name,
    p.productid,
    p.productname,
    p.expdate,
    o.quantity,
    o.price,
    (o.quantity * o.price) AS total_spent
FROM Orders o
JOIN Customer c ON o.customerid = c.customerid
JOIN Product p ON o.productid = p.productid
WHERE p.expdate < '2024-12-06'
ORDER BY o.orderdatetime DESC;

--VIEW: Orders with Expired Products
CREATE VIEW ExpiredProductOrders AS
SELECT 
    o.orderid,
    c.customerid,
    c.firstname + ' ' + c.lastname AS customer_name,
    p.productid,
    p.productname,
    p.expdate,
    o.quantity,
    o.price,
    (o.quantity * o.price) AS total_spent
FROM Orders o
JOIN Customer c ON o.customerid = c.customerid
JOIN Product p ON o.productid = p.productid
WHERE p.expdate < '2024-12-06';

-- QUERY 3: Expired Products with Remaining Inventory
SELECT 
    p.productid,
    p.productname,
    p.mfgdate,
    p.expdate,
    SUM(i.quantity) AS total_stock,
    (SUM(i.quantity) * p.price) AS total_value
FROM Product p
JOIN Inventory i ON p.productid = i.productid
WHERE p.expdate < '2024-12-06' 
GROUP BY p.productid, p.productname, p.mfgdate, p.expdate, p.price
HAVING SUM(i.quantity) > 0 
ORDER BY total_value DESC;

-- VIEW: Expired Products with Remaining Inventory
CREATE VIEW ExpiredProductsWithInventory AS
SELECT 
    p.productid,
    p.productname,
    p.mfgdate,
    p.expdate,
    SUM(i.quantity) AS total_stock,
    (SUM(i.quantity) * p.price) AS total_value
FROM Product p
JOIN Inventory i ON p.productid = i.productid
WHERE p.expdate < '2024-12-06'
GROUP BY p.productid, p.productname, p.mfgdate, p.expdate, p.price
HAVING SUM(i.quantity) > 0;

--AUDIT TABLE FOR THE PRODUCT TABLE

CREATE TABLE ProductAudit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    operation_type NVARCHAR(50) NOT NULL, 
    productid VARCHAR(15) NOT NULL,
    productname NVARCHAR(50),
    mfgdate DATE,
    expdate DATE,
    price MONEY,
    modified_by NVARCHAR(50), 
    modified_on DATETIME NOT NULL DEFAULT GETDATE() 
);

-- TRIGGER FOR INSERT
CREATE TRIGGER trg_Product_Insert
ON Product
AFTER INSERT
AS
BEGIN
    INSERT INTO ProductAudit (operation_type, productid, productname, mfgdate, expdate, price, modified_by)
    SELECT 'INSERT', productid, productname, mfgdate, expdate, price, SUSER_SNAME()
    FROM INSERTED;
END;
GO

-- TRIGGER FOR UPDATE
CREATE TRIGGER trg_Product_Update
ON Product
AFTER UPDATE
AS
BEGIN
    INSERT INTO ProductAudit (operation_type, productid, productname, mfgdate, expdate, price, modified_by)
    SELECT 'UPDATE', productid, productname, mfgdate, expdate, price, SUSER_SNAME()
    FROM INSERTED;
END;
GO

-- TRIGGER FOR DELETE
CREATE TRIGGER trg_Product_Delete
ON Product
AFTER DELETE
AS
BEGIN
    INSERT INTO ProductAudit (operation_type, productid, productname, mfgdate, expdate, price, modified_by)
    SELECT 'DELETE', productid, productname, mfgdate, expdate, price, SUSER_SNAME()
    FROM DELETED;
END;
GO


--TEST DATA FOR INSERT TRIGGER
INSERT INTO Product (productid, productname, mfgdate, expdate, price)
VALUES ('PROD011', 'TestProduct', '2023-01-01', '2024-12-31', 100.00);

--TEST DATA FOR UPDATE TRIGGER
UPDATE Product
SET price = 120.00
WHERE productid = 'PROD011';

--TEST DATA FOR DELETE TRIGGER
DELETE FROM Product
WHERE productid = 'PROD011';

--CHECKING THE AUDIT TABLE
SELECT * FROM ProductAudit;


--STORED PROCEDURE TO GET ALL EXPIRED PRODUCTS
CREATE PROCEDURE GetExpiredProducts
AS
BEGIN
    SELECT 
        productid,
        productname,
        mfgdate,
        expdate,
        price
    FROM Product
    WHERE expdate < GETDATE()
    ORDER BY expdate ASC;
END;

EXEC GetExpiredProducts;

--DROP STORED PROCEDURE
DROP PROCEDURE GetExpiredProducts;

--USER DEFINED FUNCTION TO CALCULATE THE TOTAL ORDER VALUE
CREATE FUNCTION CalculateOrderValue (@orderid VARCHAR(15))
RETURNS MONEY
AS
BEGIN
    DECLARE @totalValue MONEY;

    SELECT @totalValue = SUM(o.quantity * o.price)
    FROM Orders o
    WHERE o.orderid = @orderid;

    RETURN @totalValue;
END;

--USING THE UDF:CalculateOrderValue
SELECT dbo.CalculateOrderValue('ORD001') AS TotalOrderValue;

--DROP THE CalculateOrderValue
DROP FUNCTION CalculateOrderValue;

--CURSOR: Total Spent Per Customer

DECLARE @customerid VARCHAR(20);
DECLARE @customer_name NVARCHAR(50);
DECLARE @total_spent MONEY;

--TEMPORARY TABLE TO STORE RESULTS
CREATE TABLE #CustomerSpending (
    customerid VARCHAR(20),
    customer_name NVARCHAR(50),
    total_spent MONEY
);

-- DECLARING THE CURSOR
DECLARE customer_cursor CURSOR FOR
SELECT 
    c.customerid,
    c.firstname + ' ' + c.lastname AS customer_name
FROM Customer c;

-- OPEN THE CURSOR
OPEN customer_cursor;

-- FETCH THE FIRST ROW
FETCH NEXT FROM customer_cursor INTO @customerid, @customer_name;

-- LOOP THROUGH ALL THE ROWS
WHILE @@FETCH_STATUS = 0
BEGIN
    
    SELECT @total_spent = SUM(o.quantity * o.price)
    FROM Orders o
    WHERE o.customerid = @customerid;

    INSERT INTO #CustomerSpending (customerid, customer_name, total_spent)
    VALUES (@customerid, @customer_name, ISNULL(@total_spent, 0));

    FETCH NEXT FROM customer_cursor INTO @customerid, @customer_name;
END;

-- CLOSE AND DEALLOCATE THE CURSOR
CLOSE customer_cursor;
DEALLOCATE customer_cursor;

-- DISPLAY THE RESULT
SELECT * FROM #CustomerSpending ORDER BY total_spent DESC;

-- DROP THE TEMPORARY TABLE
DROP TABLE #CustomerSpending;


