-- ============================================
-- DIMENSION TABLE: CUSTOMER
-- ============================================

CREATE TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    full_name VARCHAR(101),
    email VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    created_at TIMESTAMP
);


-- ============================================
-- DIMENSION TABLE: SELLER
-- ============================================

CREATE TABLE dim_seller (
    seller_key SERIAL PRIMARY KEY,
    seller_id VARCHAR(15) NOT NULL UNIQUE,
    seller_name VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    created_at TIMESTAMP
);


-- ============================================
-- DIMENSION TABLE: PRODUCT
-- ============================================

CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id VARCHAR(15) NOT NULL UNIQUE,
    product_name VARCHAR(100),
    mfg_date DATE,
    exp_date DATE,
    price NUMERIC(10,2),
    is_expired BOOLEAN,
    created_at TIMESTAMP
);


-- ============================================
-- DIMENSION TABLE: DATE
-- ============================================

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_of_month INT,
    month_num INT,
    month_name VARCHAR(20),
    quarter_num INT,
    year_num INT,
    week_num INT,
    day_name VARCHAR(20),
    is_weekend BOOLEAN
);


-- ============================================
-- FACT TABLE: ORDERS
-- ============================================

CREATE TABLE fact_orders (
    order_key SERIAL PRIMARY KEY,
    order_id VARCHAR(15) NOT NULL UNIQUE,
    customer_key INT NOT NULL,
    seller_key INT NOT NULL,
    product_key INT NOT NULL,
    date_key INT NOT NULL,
    order_datetime TIMESTAMP,
    quantity INT,
    unit_price NUMERIC(10,2),
    total_amount NUMERIC(12,2),

    CONSTRAINT fk_fact_orders_customer
        FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),

    CONSTRAINT fk_fact_orders_seller
        FOREIGN KEY (seller_key) REFERENCES dim_seller(seller_key),

    CONSTRAINT fk_fact_orders_product
        FOREIGN KEY (product_key) REFERENCES dim_product(product_key),

    CONSTRAINT fk_fact_orders_date
        FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
);