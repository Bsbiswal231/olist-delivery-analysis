-- find out why on-time customers are unhappy ?
SELECT r.review_comment_message
FROM order_analysis a
JOIN reviews r ON r.order_id = a.order_id
WHERE a.is_late = 0
  AND r.review_score = 1
  AND r.review_comment_message IS NOT NULL
  AND r.review_comment_message <> ''
ORDER BY random()
LIMIT 30;SELECT r.review_comment_message
FROM order_analysis a
JOIN reviews r ON r.order_id = a.order_id
WHERE a.is_late = 0
  AND r.review_score = 1
  AND r.review_comment_message IS NOT NULL
  AND r.review_comment_message <> ''
ORDER BY random()
LIMIT 30;