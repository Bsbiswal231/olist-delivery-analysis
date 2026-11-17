CREATE TABLE orders_raw (
  order_id TEXT, customer_id TEXT, order_status TEXT,
  order_purchase_timestamp TEXT, order_approved_at TEXT,
  order_delivered_carrier_date TEXT, order_delivered_customer_date TEXT,
  order_estimated_delivery_date TEXT
);

CREATE TABLE customers_raw (
  customer_id TEXT, customer_unique_id TEXT,
  customer_zip_code_prefix TEXT, customer_city TEXT, customer_state TEXT
);

CREATE TABLE order_items_raw (
  order_id TEXT, order_item_id TEXT, product_id TEXT, seller_id TEXT,
  shipping_limit_date TEXT, price TEXT, freight_value TEXT
);


CREATE TABLE reviews_raw (
  review_id TEXT, order_id TEXT, review_score TEXT,
  review_comment_title TEXT, review_comment_message TEXT,
  review_creation_date TEXT, review_answer_timestamp TEXT
);

SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public' ORDER BY table_name;