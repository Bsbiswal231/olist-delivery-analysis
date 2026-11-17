CREATE TABLE orders AS
SELECT order_id, customer_id, order_status,
  NULLIF(order_purchase_timestamp,'')::timestamp AS purchase_ts,
  NULLIF(order_delivered_customer_date,'')::timestamp AS delivered_ts,
  NULLIF(order_estimated_delivery_date,'')::timestamp AS estimated_ts
FROM orders_raw;

CREATE TABLE reviews AS
SELECT review_id, order_id,
  review_score::int AS review_score,
  review_comment_message,
  NULLIF(review_creation_date,'')::timestamp AS review_created_ts
FROM reviews_raw;

SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM reviews;

SELECT order_id, purchase_ts, delivered_ts, estimated_ts
FROM orders LIMIT 5;