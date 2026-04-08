DROP TABLE IF EXISTS fact_sales CASCADE;
DROP TABLE IF EXISTS dim_customers, dim_products, dim_product_categories, dim_geography CASCADE;

CREATE TABLE dim_geography (
    geo_id SERIAL PRIMARY KEY,
    country TEXT,
    city TEXT,
    postal_code TEXT
);

CREATE TABLE dim_product_categories (
    category_id SERIAL PRIMARY KEY,
    category_name TEXT
);

CREATE TABLE dim_products (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    category_id INT REFERENCES dim_product_categories(category_id),
    brand TEXT,
    price DECIMAL(12, 2)
);

CREATE TABLE dim_customers (
    customer_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    geo_id INT REFERENCES dim_geography(geo_id),
    pet_type TEXT
);

CREATE TABLE fact_sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE,
    customer_id INT REFERENCES dim_customers(customer_id),
    product_id INT REFERENCES dim_products(product_id),
    quantity INT,
    total_price DECIMAL(12, 2)
);