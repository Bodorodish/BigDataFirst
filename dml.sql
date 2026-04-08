INSERT INTO dim_geography (country, city, postal_code)
SELECT DISTINCT customer_country, store_city, customer_postal_code FROM mock_data;

INSERT INTO dim_product_categories (category_name)
SELECT DISTINCT product_category FROM mock_data;

INSERT INTO dim_products (product_name, category_id, brand, price)
SELECT m.product_name, MIN(c.category_id), MAX(m.product_brand), AVG(m.product_price::DECIMAL)
FROM mock_data m
JOIN dim_product_categories c ON m.product_category = c.category_name
GROUP BY m.product_name;

INSERT INTO dim_customers (first_name, last_name, email, geo_id, pet_type)
SELECT MAX(m.customer_first_name), MAX(m.customer_last_name), m.customer_email, MIN(g.geo_id), MAX(m.customer_pet_type)
FROM mock_data m
JOIN dim_geography g ON m.customer_country = g.country AND (m.customer_postal_code = g.postal_code OR (m.customer_postal_code IS NULL AND g.postal_code IS NULL))
GROUP BY m.customer_email;


INSERT INTO fact_sales (sale_date, customer_id, product_id, quantity, total_price)
SELECT 
    TO_DATE(m.sale_date, 'MM/DD/YYYY'),
    c.customer_id,
    p.product_id,
    m.sale_quantity::INT,
    m.sale_total_price::DECIMAL
FROM mock_data m
JOIN dim_customers c ON m.customer_email = c.email
JOIN dim_products p ON m.product_name = p.product_name;