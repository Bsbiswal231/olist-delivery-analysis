-- what % of late and on-time orders are unhappy?
SELECT CASE WHEN is_late = 1 THEN 'Late' ELSE 'On time' END AS delivery,
       COUNT(review_score) AS reviewed_orders,
       SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END) AS unhappy_orders,
       ROUND(100.0 * SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END)
             / COUNT(review_score), 1) AS pct_unhappy
FROM order_analysis
GROUP BY is_late
ORDER BY is_late;