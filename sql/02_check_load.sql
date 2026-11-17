SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM orders_raw
UNION ALL
SELECT 'customers', COUNT(*) FROM customers_raw
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items_raw 
UNION ALL
SELECT 'review', COUNT(*) FROM reviews_raw;
