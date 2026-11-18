-- Review score and % unhappy by how many days late.
SELECT CASE WHEN days_vs_estimate <= 0 THEN '1. On time'
            WHEN days_vs_estimate BETWEEN 1 AND 3 THEN '2. 1-3 days late'
            WHEN days_vs_estimate BETWEEN 4 AND 7 THEN '3. 4-7 days late'
            ELSE '4. 8+ days late' END AS lateness,
       COUNT(*) AS orders,
       COUNT(review_score) AS reviewed_orders,
       ROUND(AVG(review_score), 2) AS avg_review,
       ROUND(100.0 * SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END)
             / COUNT(review_score), 1) AS pct_unhappy
FROM order_analysis
GROUP BY 1
ORDER BY 1;