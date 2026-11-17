-- What % of delivered orders arrived after the estimated date?

SELECT COUNT(*) AS delivered_orders,
       SUM(is_late) AS late_orders,
       ROUND(100.0 * SUM(is_late) / COUNT(*), 2) AS late_percent
FROM order_analysis;