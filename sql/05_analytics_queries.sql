-- ============================================
-- 1. TOTAL REVENUE
-- ============================================

SELECT 
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM fact_orders;


-- ============================================
-- 2. MONTHLY REVENUE TREND
-- ============================================

SELECT
    d.year_num,
    d.month_num,
    d.month_name,
    ROUND(SUM(f.total_amount), 2) AS monthly_revenue
FROM fact_orders f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year_num, d.month_num, d.month_name
ORDER BY d.year_num, d.month_num;


-- ============================================
-- 3. TOP 5 PRODUCTS BY REVENUE
-- ============================================

SELECT
    p.product_name,
    ROUND(SUM(f.total_amount), 2) AS product_revenue
FROM fact_orders f
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY product_revenue DESC
LIMIT 5;


-- ============================================
-- 4. TOP 5 PRODUCTS BY QUANTITY SOLD
-- ============================================

SELECT
    p.product_name,
    SUM(f.quantity) AS total_quantity_sold
FROM fact_orders f
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;


-- ============================================
-- 5. TOP 5 CUSTOMERS BY SPENDING
-- ============================================

SELECT
    c.customer_id,
    c.full_name,
    ROUND(SUM(f.total_amount), 2) AS total_spent
FROM fact_orders f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC
LIMIT 5;


-- ============================================
-- 6. REVENUE BY SELLER
-- ============================================

SELECT
    s.seller_name,
    ROUND(SUM(f.total_amount), 2) AS seller_revenue
FROM fact_orders f
JOIN dim_seller s
    ON f.seller_key = s.seller_key
GROUP BY s.seller_name
ORDER BY seller_revenue DESC;


-- ============================================
-- 7. WEEKDAY VS WEEKEND REVENUE
-- ============================================

SELECT
    CASE
        WHEN d.is_weekend THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    ROUND(SUM(f.total_amount), 2) AS revenue
FROM fact_orders f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    CASE
        WHEN d.is_weekend THEN 'Weekend'
        ELSE 'Weekday'
    END
ORDER BY revenue DESC;


-- ============================================
-- 8. EXPIRED PRODUCTS STILL SOLD
-- ============================================

SELECT
    p.product_name,
    p.exp_date,
    SUM(f.quantity) AS quantity_sold_after_expiry,
    ROUND(SUM(f.total_amount), 2) AS revenue_after_expiry
FROM fact_orders f
JOIN dim_product p
    ON f.product_key = p.product_key
JOIN dim_date d
    ON f.date_key = d.date_key
WHERE p.exp_date < d.full_date
GROUP BY p.product_name, p.exp_date
ORDER BY revenue_after_expiry DESC;


-- ============================================
-- 9. CUSTOMER ORDER COUNTS
-- ============================================

SELECT
    c.customer_id,
    c.full_name,
    COUNT(f.order_id) AS total_orders
FROM fact_orders f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_id, c.full_name
ORDER BY total_orders DESC, c.customer_id;


-- ============================================
-- 10. AVERAGE ORDER VALUE
-- ============================================

SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM fact_orders;