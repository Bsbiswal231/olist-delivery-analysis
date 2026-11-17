# Cleaning Log: Olist Delivery Analysis

Question: Why are customers unhappy, and is late delivery the reason?

Data: Olist Brazilian E-Commerce Public Dataset (Kaggle), 2016 to 2018

## 1. Loading the data
- Loaded 4 CSV files into PostgreSQL as raw tables, with every column as TEXT so the import could not fail on messy values.
- Row counts: orders 99,441 | customers 99,441 | order_items 112,650 | reviews 99,224.
- The raw tables are never changed. All cleaning is done in new tables.

## 2. Converting data types
- Made clean orders and reviews tables from the raw ones.
- Converted date columns from text to timestamps and review_score to integer.
- Empty cells were turned into real NULL values with NULLIF.
- Row counts stayed the same (99,441 orders, 99,224 reviews), so no rows were lost.

## 3. Quality checks

Check 1: Duplicate orders
- Found: 99,441 total and 99,441 unique, so no duplicates.
- Action: none needed.

Check 2: Orders by status
- Found: 96,478 delivered (about 97%). The other 2,963 are shipped, canceled, unavailable, invoiced, processing, created or approved.
- Action: late delivery can only be judged for delivered orders, so I use delivered orders only.

Check 3: Missing delivery date
- Found: 8 delivered orders have no delivery date.
- Action: these are a data error, so I removed them. Missing dates for shipped, canceled and other statuses are normal.

Check 4: Orders with more than one review
- Found: 547 orders.
- Action: a direct join would count these orders twice, so I keep only the latest review per order.

Check 5: Review score spread
- Found: 1 star 11,424 | 2 stars 3,151 | 3 stars 8,179 | 4 stars 19,142 | 5 stars 57,328.
- Insight: about 14.7% of reviews are 1 or 2 stars (14,575 of 99,224). This is the unhappy group I want to explain.

## 4. Rules for the analysis
- Late delivery: an order is late if the delivery date is after the estimated delivery date.
- Date only, no time: the estimated delivery date has no time (always 00:00:00), so I compare dates only. An order that arrives on the promised day is not late.
- Scope: only orders with status "delivered" and a delivery date are used. 8 delivered orders had no date and were removed.
- One row per order: items are added up per order before joining, and only the latest review is kept.
- Orders with no review are kept (LEFT JOIN) but have no review score.

## 5. Final analysis table (order_analysis)
One row per delivered order, combining the order dates, customer state, review score and order value in a single table. All later analysis uses this table.

- Total rows: 96,470
- Unique orders: 96,470
- Delivered orders with no review: 646

## 6. Limits
- The data covers 2016 to 2018 only.
- A bad review can have causes other than delivery (wrong item, damaged product). I check this later by reading sample comments.