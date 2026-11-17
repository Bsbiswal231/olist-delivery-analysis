CREATE TABLE order_analysis AS
WITH items AS (
  SELECT order_id,
         SUM(price::numeric) AS order_value,
         SUM(freight_value::numeric) AS freight,
         COUNT(*) AS item_count
  FROM order_items_raw
  GROUP BY order_id
),
latest_review AS (
  SELECT DISTINCT ON (order_id) order_id, review_score
  FROM reviews
  ORDER BY order_id, review_created_ts DESC, review_id
)
SELECT o.order_id,
       c.customer_state,
       o.purchase_ts,
       o.delivered_ts,
       o.estimated_ts,
       (o.delivered_ts::date - o.estimated_ts::date) AS days_vs_estimate,
       CASE WHEN o.delivered_ts::date > o.estimated_ts::date THEN 1 ELSE 0 END AS is_late,
       r.review_score,
       i.order_value,
       i.freight,
       i.item_count
FROM orders o
JOIN customers_raw c ON c.customer_id = o.customer_id
LEFT JOIN items i ON i.order_id = o.order_id
LEFT JOIN latest_review r ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.delivered_ts IS NOT NULL;



-- 1: Check that no order is repeated.
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT order_id) AS unique_orders
FROM order_analysis;

-- 2: Count orders with no review.
SELECT COUNT(*) AS delivered_orders_without_review
FROM order_analysis 
WHERE review_score IS NULL;
-- 
SELECT order_id, customer_state, days_vs_estimate, is_late, review_score, order_value
FROM order_analysis LIMIT 10;

-- 3. What % of delivered orders are late?
SELECT COUNT(*) AS delivered_orders,
       SUM(is_late) AS late_orders,
       ROUND(100.0 * SUM(is_late) / COUNT(*), 2) AS late_percent
FROM order_analysis;
