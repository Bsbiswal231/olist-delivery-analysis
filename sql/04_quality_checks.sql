-- 1: Are there duplicate orders?
SELECT COUNT(*) AS total, COUNT(DISTINCT order_id) AS unique_orders 
FROM orders;

-- 2: How are orders split by status?
SELECT order_status, COUNT(*) 
FROM orders 
GROUP BY order_status
ORDER BY COUNT(*) DESC;

-- 3: Which orders have no delivery date?
SELECT order_status, COUNT(*) AS missing_delivery_date
FROM orders 
WHERE delivered_ts IS NULL 
GROUP BY order_status
ORDER BY COUNT(*) DESC;

-- 4: How many orders have more than one review?
SELECT COUNT(*) AS orders_with_multiple_reviews 
FROM (
  SELECT order_id 
  FROM reviews 
  GROUP BY order_id 
  HAVING COUNT(*) > 1
  ) t;

-- 5: How are review scores spread?
SELECT review_score, COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

