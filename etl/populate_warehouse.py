import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os

load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

def make_connection_string_from_env(db_name):
    return (
        f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}"
        f"@{DB_HOST}:{DB_PORT}/{db_name}"
    )


def extract_source_data(source_engine):
    customer_df = pd.read_sql("SELECT * FROM customer", source_engine)
    seller_df = pd.read_sql("SELECT * FROM seller", source_engine)
    product_df = pd.read_sql("SELECT * FROM product", source_engine)
    orders_df = pd.read_sql("SELECT * FROM orders", source_engine)

    return customer_df, seller_df, product_df, orders_df


def build_dim_customer(customer_df: pd.DataFrame) -> pd.DataFrame:
    dim_customer = customer_df.copy()
    dim_customer["full_name"] = (
        dim_customer["first_name"].fillna("") + " " + dim_customer["last_name"].fillna("")
    ).str.strip()

    dim_customer = dim_customer[
        [
            "customer_id",
            "first_name",
            "last_name",
            "full_name",
            "email",
            "address",
            "phone",
            "created_at",
        ]
    ].drop_duplicates(subset=["customer_id"])

    return dim_customer


def build_dim_seller(seller_df: pd.DataFrame) -> pd.DataFrame:
    dim_seller = seller_df.copy()

    dim_seller = dim_seller[
        [
            "seller_id",
            "seller_name",
            "address",
            "phone",
            "created_at",
        ]
    ].drop_duplicates(subset=["seller_id"])

    return dim_seller


def build_dim_product(product_df: pd.DataFrame) -> pd.DataFrame:
    dim_product = product_df.copy()
    today = pd.Timestamp.today().normalize()

    dim_product["is_expired"] = dim_product["exp_date"].notna() & (pd.to_datetime(dim_product["exp_date"]) < today)

    dim_product = dim_product[
        [
            "product_id",
            "product_name",
            "mfg_date",
            "exp_date",
            "price",
            "is_expired",
            "created_at",
        ]
    ].drop_duplicates(subset=["product_id"])

    return dim_product


def build_dim_date(orders_df: pd.DataFrame) -> pd.DataFrame:
    order_dates = pd.to_datetime(orders_df["order_datetime"]).dt.normalize().dropna().sort_values().unique()

    dim_date = pd.DataFrame({"full_date": order_dates})
    dim_date["date_key"] = dim_date["full_date"].dt.strftime("%Y%m%d").astype(int)
    dim_date["day_of_month"] = dim_date["full_date"].dt.day
    dim_date["month_num"] = dim_date["full_date"].dt.month
    dim_date["month_name"] = dim_date["full_date"].dt.strftime("%B")
    dim_date["quarter_num"] = dim_date["full_date"].dt.quarter
    dim_date["year_num"] = dim_date["full_date"].dt.year
    dim_date["week_num"] = dim_date["full_date"].dt.isocalendar().week.astype(int)
    dim_date["day_name"] = dim_date["full_date"].dt.strftime("%A")
    dim_date["is_weekend"] = dim_date["full_date"].dt.dayofweek >= 5

    dim_date = dim_date[
        [
            "date_key",
            "full_date",
            "day_of_month",
            "month_num",
            "month_name",
            "quarter_num",
            "year_num",
            "week_num",
            "day_name",
            "is_weekend",
        ]
    ]

    return dim_date


def load_dimensions(warehouse_engine, dim_customer, dim_seller, dim_product, dim_date):
    dim_customer.to_sql("dim_customer", warehouse_engine, if_exists="append", index=False)
    dim_seller.to_sql("dim_seller", warehouse_engine, if_exists="append", index=False)
    dim_product.to_sql("dim_product", warehouse_engine, if_exists="append", index=False)
    dim_date.to_sql("dim_date", warehouse_engine, if_exists="append", index=False)


def fetch_dimension_keys(warehouse_engine):
    dim_customer_keys = pd.read_sql(
        "SELECT customer_key, customer_id FROM dim_customer",
        warehouse_engine
    )

    dim_seller_keys = pd.read_sql(
        "SELECT seller_key, seller_id FROM dim_seller",
        warehouse_engine
    )

    dim_product_keys = pd.read_sql(
        "SELECT product_key, product_id FROM dim_product",
        warehouse_engine
    )

    return dim_customer_keys, dim_seller_keys, dim_product_keys


def build_fact_orders(orders_df, dim_customer_keys, dim_seller_keys, dim_product_keys):
    fact_orders = orders_df.copy()

    fact_orders["order_datetime"] = pd.to_datetime(fact_orders["order_datetime"])
    fact_orders["date_key"] = fact_orders["order_datetime"].dt.strftime("%Y%m%d").astype(int)
    fact_orders["total_amount"] = fact_orders["quantity"] * fact_orders["unit_price"]

    fact_orders = fact_orders.merge(dim_customer_keys, on="customer_id", how="left")
    fact_orders = fact_orders.merge(dim_seller_keys, on="seller_id", how="left")
    fact_orders = fact_orders.merge(dim_product_keys, on="product_id", how="left")

    fact_orders = fact_orders[
        [
            "order_id",
            "customer_key",
            "seller_key",
            "product_key",
            "date_key",
            "order_datetime",
            "quantity",
            "unit_price",
            "total_amount",
        ]
    ]

    return fact_orders


def load_fact_orders(warehouse_engine, fact_orders):
    fact_orders.to_sql("fact_orders", warehouse_engine, if_exists="append", index=False)


def truncate_warehouse_tables(warehouse_engine):
    with warehouse_engine.begin() as conn:
        conn.execute(text("TRUNCATE TABLE fact_orders RESTART IDENTITY CASCADE"))
        conn.execute(text("TRUNCATE TABLE dim_date RESTART IDENTITY CASCADE"))
        conn.execute(text("TRUNCATE TABLE dim_product RESTART IDENTITY CASCADE"))
        conn.execute(text("TRUNCATE TABLE dim_seller RESTART IDENTITY CASCADE"))
        conn.execute(text("TRUNCATE TABLE dim_customer RESTART IDENTITY CASCADE"))


def main():
    source_engine = create_engine(make_connection_string_from_env("pharmacy_source"))
    warehouse_engine = create_engine(make_connection_string_from_env("pharmacy_warehouse"))

    print("Extracting source data")
    customer_df, seller_df, product_df, orders_df = extract_source_data(source_engine)

    print("Building dimension tables")
    dim_customer = build_dim_customer(customer_df)
    dim_seller = build_dim_seller(seller_df)
    dim_product = build_dim_product(product_df)
    dim_date = build_dim_date(orders_df)

    print("Clearing warehouse tables")
    truncate_warehouse_tables(warehouse_engine)

    print("Loading dimension tables")
    load_dimensions(warehouse_engine, dim_customer, dim_seller, dim_product, dim_date)

    print("Fetching surrogate keys")
    dim_customer_keys, dim_seller_keys, dim_product_keys = fetch_dimension_keys(warehouse_engine)

    print("Building fact_orders")
    fact_orders = build_fact_orders(
        orders_df,
        dim_customer_keys,
        dim_seller_keys,
        dim_product_keys,
    )

    print("Loading fact_orders")
    load_fact_orders(warehouse_engine, fact_orders)

    print("Warehouse population completed successfully")


if __name__ == "__main__":
    main()