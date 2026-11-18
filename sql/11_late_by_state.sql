-- Late percentage by customer state (states with 500+ orders)

SELECT customer_state,
       COUNT(*) AS orders,
       SUM(is_late) AS late_orders,
       ROUND(100.0 * SUM(is_late) / COUNT(*), 1) AS late_percent
FROM order_analysis
GROUP BY customer_state
HAVING COUNT(*) >= 500
ORDER BY late_percent DESC;