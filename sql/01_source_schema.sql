CREATE DATABASE pharmacy_source;

-- ============================================
-- CUSTOMER TABLE
-- ============================================

CREATE TABLE customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(100),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================
-- SELLER TABLE
-- ============================================

CREATE TABLE seller (
    seller_id VARCHAR(15) PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL,
    password VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================
-- PRODUCT TABLE
-- ============================================

CREATE TABLE product (
    product_id VARCHAR(15) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    mfg_date DATE,
    exp_date DATE,
    price NUMERIC(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================
-- INVENTORY TABLE (FIXED: no redundant product_name)
-- ============================================

CREATE TABLE inventory (
    product_id VARCHAR(15) NOT NULL,
    seller_id VARCHAR(15) NOT NULL,
    quantity INT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (product_id, seller_id),

    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id)
);


-- ============================================
-- ORDERS TABLE
-- ============================================

CREATE TABLE orders (
    order_id VARCHAR(15) PRIMARY KEY,
    product_id VARCHAR(15) NOT NULL,
    seller_id VARCHAR(15) NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    order_datetime TIMESTAMP,
    quantity INT,
    unit_price NUMERIC(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);


-- ============================================
-- INSURANCE TABLE
-- ============================================

CREATE TABLE insurance (
    insurance_id VARCHAR(15) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    insurance_provider VARCHAR(100) NOT NULL,
    policy_no VARCHAR(50) NOT NULL UNIQUE,
    coverage_amount NUMERIC(10,2) NOT NULL,
    exp_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);