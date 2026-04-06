-- ============================================
-- CUSTOMER DATA
-- ============================================

INSERT INTO customer (customer_id, password, first_name, last_name, email, address, phone)
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


-- ============================================
-- SELLER DATA
-- ============================================

INSERT INTO seller (seller_id, seller_name, password, address, phone)
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


-- ============================================
-- PRODUCT DATA
-- ============================================

INSERT INTO product (product_id, product_name, mfg_date, exp_date, price)
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


-- ============================================
-- INVENTORY DATA
-- ============================================

INSERT INTO inventory (product_id, seller_id, quantity)
VALUES
('PROD001', 'SELL001', 30),
('PROD002', 'SELL002', 40),
('PROD003', 'SELL003', 50),
('PROD004', 'SELL004', 20),
('PROD005', 'SELL005', 70),
('PROD006', 'SELL006', 15),
('PROD007', 'SELL007', 25),
('PROD008', 'SELL008', 30),
('PROD009', 'SELL009', 60),
('PROD010', 'SELL010', 100),
('PROD003', 'SELL001', 40),
('PROD004', 'SELL002', 35),
('PROD005', 'SELL003', 45),
('PROD006', 'SELL004', 20),
('PROD007', 'SELL005', 50),
('PROD008', 'SELL006', 25),
('PROD009', 'SELL007', 35),
('PROD010', 'SELL008', 75),
('PROD001', 'SELL009', 10),
('PROD002', 'SELL010', 15);


-- ============================================
-- ORDERS DATA
-- ============================================

INSERT INTO orders (order_id, product_id, seller_id, customer_id, order_datetime, quantity, unit_price)
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


-- ============================================
-- INSURANCE DATA
-- ============================================

INSERT INTO insurance (insurance_id, customer_id, insurance_provider, policy_no, coverage_amount, exp_date)
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