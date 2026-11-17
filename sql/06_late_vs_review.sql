-- Average review score for late vs on-time delivered orders.
-- Orders with no review are skipped by AVG.
SELECT CASE WHEN is_late = 1 THEN 'Late' ELSE 'On time' END AS delivery,
       COUNT(*) AS orders,
       ROUND(AVG(review_score), 2) AS avg_review
FROM order_analysis
GROUP BY is_late
ORDER BY is_late;