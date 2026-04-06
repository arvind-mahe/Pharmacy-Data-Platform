import pandas as pd
from sqlalchemy import create_engine

from dotenv import load_dotenv
import os

load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

# connection string
engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

# 1. Monthly revenue
monthly = pd.read_sql("""
SELECT
    d.year_num,
    d.month_num,
    d.month_name,
    SUM(f.total_amount) AS revenue
FROM fact_orders f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year_num, d.month_num, d.month_name
ORDER BY d.year_num, d.month_num
""", engine)

monthly.to_csv("data/exports/monthly_revenue.csv", index=False)

# 2. Top products
top_products = pd.read_sql("""
SELECT
    p.product_name,
    SUM(f.total_amount) AS revenue
FROM fact_orders f
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5
""", engine)

top_products.to_csv("data/exports/top_products.csv", index=False)

print("Exports completed")