SELECT g.country, cat.category_name, SUM(f.total_price) as revenue
FROM fact_sales f
JOIN dim_customers c ON f.customer_id = c.customer_id
JOIN dim_geography g ON c.geo_id = g.geo_id
JOIN dim_products p ON f.product_id = p.product_id
JOIN dim_product_categories cat ON p.category_id = cat.category_id
GROUP BY 1, 2 ORDER BY 3 DESC LIMIT 5;