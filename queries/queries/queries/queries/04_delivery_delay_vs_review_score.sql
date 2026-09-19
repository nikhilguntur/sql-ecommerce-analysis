WITH delivery_analysis AS (
  SELECT 
    o.order_id,
    DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date) AS days_late,
    CASE 
      WHEN DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date) < 0 THEN 'Early'
      WHEN DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date) = 0 THEN 'On Time'
      WHEN DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date) BETWEEN 1 AND 7 THEN '1-7 Days Late'
      WHEN DATEDIFF(o.order_delivered_timestamp, o.order_estimated_delivery_date) BETWEEN 8 AND 30 THEN '8-30 Days Late'
      ELSE '30+ Days Late'
    END AS delay_bucket,
    orv.review_score
  FROM orders o
  LEFT JOIN order_reviews orv ON o.order_id = orv.order_id
  WHERE o.order_delivered_timestamp IS NOT NULL
)
SELECT 
  delay_bucket,
  COUNT(*) AS order_count,
  ROUND(AVG(review_score), 2) AS avg_review_score,
  ROUND(STDDEV(review_score), 2) AS stddev_review_score
FROM delivery_analysis
GROUP BY delay_bucket
ORDER BY 
  CASE delay_bucket
    WHEN 'Early' THEN 1
    WHEN 'On Time' THEN 2
    WHEN '1-7 Days Late' THEN 3
    WHEN '8-30 Days Late' THEN 4
    ELSE 5
  END;
