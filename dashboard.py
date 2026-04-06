import pandas as pd
import streamlit as st
import plotly.express as px
from sqlalchemy import create_engine

from dotenv import load_dotenv
import os

load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")


# -------------------------------
# PAGE CONFIG
# -------------------------------
st.set_page_config(
    page_title="Pharmacy Data Platform Dashboard",
    page_icon="💊",
    layout="wide"
)


engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)


# -------------------------------
# HELPER FUNCTION
# -------------------------------
@st.cache_data
def run_query(query: str) -> pd.DataFrame:
    return pd.read_sql(query, engine)


# -------------------------------
# TITLE
# -------------------------------
st.title("💊 Pharmacy Data Platform Dashboard")
st.markdown("Interactive analytics dashboard built on the pharmacy data warehouse")


# -------------------------------
# KPI QUERIES
# -------------------------------
total_revenue_df = run_query("""
SELECT ROUND(SUM(total_amount), 2) AS total_revenue
FROM fact_orders
""")

avg_order_df = run_query("""
SELECT ROUND(AVG(total_amount), 2) AS avg_order_value
FROM fact_orders
""")

total_orders_df = run_query("""
SELECT COUNT(*) AS total_orders
FROM fact_orders
""")

total_customers_df = run_query("""
SELECT COUNT(*) AS total_customers
FROM dim_customer
""")


# -------------------------------
# KPI CARDS
# -------------------------------
col1, col2, col3, col4 = st.columns(4)

with col1:
    st.metric("Total Revenue", f"${total_revenue_df.iloc[0]['total_revenue']:,}")

with col2:
    st.metric("Average Order Value", f"${avg_order_df.iloc[0]['avg_order_value']:,}")

with col3:
    st.metric("Total Orders", f"{int(total_orders_df.iloc[0]['total_orders']):,}")

with col4:
    st.metric("Total Customers", f"{int(total_customers_df.iloc[0]['total_customers']):,}")


st.divider()


# -------------------------------
# MONTHLY REVENUE
# -------------------------------
monthly_revenue_df = run_query("""
SELECT
    d.year_num,
    d.month_num,
    d.month_name,
    ROUND(SUM(f.total_amount), 2) AS monthly_revenue
FROM fact_orders f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year_num, d.month_num, d.month_name
ORDER BY d.year_num, d.month_num
""")

monthly_revenue_df["month_label"] = (
    monthly_revenue_df["month_name"] + " " + monthly_revenue_df["year_num"].astype(str)
)

fig_monthly = px.line(
    monthly_revenue_df,
    x="month_label",
    y="monthly_revenue",
    markers=True,
    title="Monthly Revenue Trend"
)

st.plotly_chart(fig_monthly, use_container_width=True)


# -------------------------------
# TOP PRODUCTS AND TOP CUSTOMERS
# -------------------------------
top_products_df = run_query("""
SELECT
    p.product_name,
    ROUND(SUM(f.total_amount), 2) AS product_revenue
FROM fact_orders f
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY product_revenue DESC
LIMIT 5
""")

top_customers_df = run_query("""
SELECT
    c.customer_id,
    c.full_name,
    ROUND(SUM(f.total_amount), 2) AS total_spent
FROM fact_orders f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC
LIMIT 5
""")

col5, col6 = st.columns(2)

with col5:
    fig_products = px.bar(
        top_products_df,
        x="product_name",
        y="product_revenue",
        title="Top 5 Products by Revenue"
    )
    st.plotly_chart(fig_products, use_container_width=True)

with col6:
    fig_customers = px.bar(
        top_customers_df,
        x="full_name",
        y="total_spent",
        title="Top 5 Customers by Spending"
    )
    st.plotly_chart(fig_customers, use_container_width=True)


# -------------------------------
# SELLER REVENUE
# -------------------------------
seller_revenue_df = run_query("""
SELECT
    s.seller_name,
    ROUND(SUM(f.total_amount), 2) AS seller_revenue
FROM fact_orders f
JOIN dim_seller s
    ON f.seller_key = s.seller_key
GROUP BY s.seller_name
ORDER BY seller_revenue DESC
""")

fig_seller = px.bar(
    seller_revenue_df,
    x="seller_name",
    y="seller_revenue",
    title="Revenue by Seller"
)

st.plotly_chart(fig_seller, use_container_width=True)


# -------------------------------
# EXPIRED PRODUCTS SOLD AFTER EXPIRY
# -------------------------------
expired_sales_df = run_query("""
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
ORDER BY revenue_after_expiry DESC
""")

st.subheader("Expired Products Sold After Expiry")

if expired_sales_df.empty:
    st.success("No expired products were sold after expiry")
else:
    st.dataframe(expired_sales_df, use_container_width=True)


# -------------------------------
# FULL FACT TABLE VIEW
# -------------------------------
st.subheader("Warehouse Fact Orders Preview")

fact_preview_df = run_query("""
SELECT *
FROM fact_orders
ORDER BY order_datetime
LIMIT 20
""")

st.dataframe(fact_preview_df, use_container_width=True)


# -------------------------------
# SIDEBAR FILTERS VERSION
# -------------------------------
st.sidebar.header("Filters")

product_options = run_query("""
SELECT DISTINCT product_name
FROM dim_product
ORDER BY product_name
""")["product_name"].tolist()

selected_products = st.sidebar.multiselect(
    "Select Product(s)",
    options=product_options,
    default=product_options
)

if selected_products:
    product_filter_string = "', '".join(selected_products)

    filtered_product_sales_df = run_query(f"""
    SELECT
        p.product_name,
        ROUND(SUM(f.total_amount), 2) AS product_revenue
    FROM fact_orders f
    JOIN dim_product p
        ON f.product_key = p.product_key
    WHERE p.product_name IN ('{product_filter_string}')
    GROUP BY p.product_name
    ORDER BY product_revenue DESC
    """)

    st.subheader("Filtered Product Revenue")

    fig_filtered = px.bar(
        filtered_product_sales_df,
        x="product_name",
        y="product_revenue",
        title="Filtered Product Revenue"
    )
    st.plotly_chart(fig_filtered, use_container_width=True)